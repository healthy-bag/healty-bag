import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:healthy_bag/core/di/usecase_di/like_usecase_di.dart';
import 'package:healthy_bag/domain/entities/feed_entity.dart';
import 'package:healthy_bag/presentation/my/viewmodel/my_tap_viewmodel.dart';
import 'package:healthy_bag/presentation/notifier/global_user_notifier.dart';
import 'package:image_picker/image_picker.dart';
import 'package:healthy_bag/presentation/notifier/global_like_notifier.dart';

class DetailDialog extends ConsumerStatefulWidget {
  const DetailDialog({super.key, required this.feed});

  final FeedEntity feed;

  @override
  ConsumerState<DetailDialog> createState() => _DetailDialogState();
}

class _DetailDialogState extends ConsumerState<DetailDialog> {
  late TextEditingController _contentController;
  late int likeCount;
  bool isEditing = false;
  File? selectedImage;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _contentController = TextEditingController(text: widget.feed.content);
    likeCount = widget.feed.likeCount;
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  // 갤러리에서 사진 가져오기
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        selectedImage = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // 최신 피드 데이터 구독
    final feedAsync = ref.watch(myTapViewmodelProvider);
    final currentFeed = feedAsync.when(
      data: (feeds) {
        return feeds.firstWhere(
          (feed) => feed.feedId == widget.feed.feedId,
          orElse: () => widget.feed,
        );
      },
      error: (error, stackTrace) => widget.feed,
      loading: () => widget.feed,
    );

    final currentUser = ref.watch(globalUserViewModelProvider);
    final bool isMe = currentUser?.uid == widget.feed.uid;
    final myLikes = ref.watch(globalLikeProvider);
    final isLiked = myLikes.value?.contains(widget.feed.feedId) ?? false;

    return Stack(
      children: [
        AbsorbPointer(
          absorbing: isLoading,
          child: AlertDialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 32),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            icon: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 완료 버튼 (편집 모드에서만 노출)
                if (isEditing)
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        await ref
                            .read(myTapViewmodelProvider.notifier)
                            .updateFeed(
                              widget.feed.copyWith(
                                content: _contentController.text,
                              ),
                              selectedImage,
                            );
                        setState(() {
                          selectedImage = null;
                          isEditing = false;
                        });
                      } catch (e) {
                        debugPrint('Update error: $e');
                      } finally {
                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
                    child: const Text(
                      '완료',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                else
                  const SizedBox(width: 50),
                // 닫기 버튼
                GestureDetector(
                  onTap: () {
                    if (context.mounted) context.pop();
                  },
                  child: const Icon(CupertinoIcons.xmark, color: Colors.black),
                ),
              ],
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  spacing: 12,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 이미지 영역 (고정 비율로 흔들림 방지)
                    AspectRatio(
                      aspectRatio: 0.8,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: selectedImage != null
                                  ? Image.file(
                                      selectedImage!,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      currentFeed.fileUrl,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const Center(
                                                child: Icon(
                                                  Icons.error_outline,
                                                  size: 40,
                                                ),
                                              ),
                                    ),
                            ),
                          ),
                          if (isEditing)
                            Positioned(
                              top: 12,
                              right: 12,
                              child: GestureDetector(
                                onTap: pickImage,
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(
                                    color: Colors.black45,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.add_a_photo,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    // 액션 바 (좋아요, 댓글, 수정/삭제)
                    Row(
                      children: [
                        ItemButton(
                          icon: isLiked
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: isLiked ? Colors.red : null,
                          content: likeCount.toString(),
                          onTap: () async {
                            if (currentUser == null) return;
                            setState(() {
                              if (isLiked) {
                                likeCount--;
                              } else {
                                likeCount++;
                              }
                            });
                            await ref
                                .read(likeUsecaseProvider)
                                .like(currentUser, widget.feed);
                          },
                        ),
                        const SizedBox(width: 16),
                        ItemButton(
                          icon: Icons.chat_bubble_outline,
                          content: widget.feed.commentCount.toString(),
                          onTap: () {
                            // 댓글 이동 로직 (필요 시 구현)
                          },
                        ),
                        if (isMe && !isEditing) ...[
                          const Spacer(),
                          editAndDelete(context),
                        ],
                      ],
                    ),
                    // 본문 영역
                    if (isEditing)
                      TextField(
                        controller: _contentController,
                        maxLines: null,
                        style: const TextStyle(fontSize: 14),
                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 8),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      )
                    else
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          currentFeed.content,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
        // 로딩 오버레이
        if (isLoading)
          Positioned.fill(
            child: Container(
              color: Colors.black26,
              child: const Center(child: CircularProgressIndicator()),
            ),
          ),
      ],
    );
  }

  // 수정/삭제 바텀시트
  Widget editAndDelete(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final action = await showModalBottomSheet<String>(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
          ),
          builder: (context) => SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 8),
                ListTile(
                  leading: const Icon(Icons.edit),
                  title: const Text('수정하기'),
                  onTap: () => Navigator.pop(context, 'edit'),
                ),
                ListTile(
                  leading: const Icon(Icons.delete, color: Colors.red),
                  title: const Text(
                    '삭제하기',
                    style: TextStyle(color: Colors.red),
                  ),
                  onTap: () => Navigator.pop(context, 'delete'),
                ),
              ],
            ),
          ),
        );

        if (action == 'edit') {
          setState(() => isEditing = true);
        } else if (action == 'delete' && context.mounted) {
          final confirmed = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('게시물 삭제'),
              content: const Text('정말로 삭제하시겠습니까?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text(
                    '취소',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text('삭제', style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
          );

          if (confirmed == true && context.mounted) {
            await ref
                .read(myTapViewmodelProvider.notifier)
                .deleteFeed(widget.feed.feedId);
            if (context.mounted) Navigator.pop(context);
          }
        }
      },
      child: const Icon(Icons.more_vert),
    );
  }
}

// 공용 아이콘 버튼 위젯
class ItemButton extends StatelessWidget {
  const ItemButton({
    super.key,
    required this.icon,
    required this.content,
    required this.onTap,
    this.color,
  });

  final IconData icon;
  final String content;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 22, color: color),
          const SizedBox(width: 6),
          Text(
            content,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
