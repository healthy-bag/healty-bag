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
import 'package:healthy_bag/presentation/notifier/global_user_notifier.dart';

class DetailDialog extends ConsumerStatefulWidget {
  const DetailDialog({super.key, required this.feed});

  final FeedEntity feed;
  @override
  ConsumerState<DetailDialog> createState() => _DetailDialogState();
}

class _DetailDialogState extends ConsumerState<DetailDialog> {
  late int likeCount;

  @override
  ConsumerState<DetailDialog> createState() => _DetailDialogState();
}

class _DetailDialogState extends ConsumerState<DetailDialog> {
  late TextEditingController _contentController;
  bool isEditing = false;
  File? selectedImage;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    _contentController = TextEditingController(text: widget.feed.content);
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
  void initState() {
    super.initState();
    likeCount = widget.feed.likeCount;
  }

  @override
  Widget build(BuildContext context) {
    final feedAsync = ref.watch(myTapViewmodelProvider);
    final currentFeed = feedAsync.when(
      data: (feeds) {
        return feeds.firstWhere(
          (feed) => feed.feedId == widget.feed.feedId,
          orElse: () => widget.feed,
        );
      },
      error: (error, stackTrace) {
        return widget.feed;
      },
      loading: () {
        return widget.feed;
      },
    );
    final currentUser = ref.watch(globalUserViewModelProvider);
    final bool isMe = currentUser?.uid == widget.feed.uid;
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
                // 완료 버튼
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
                        rethrow;
                      } finally {
                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
                    child: const Text(
                      '완료',
                      style: TextStyle(color: Colors.blue),
                    ),
                  )
                else
                  const SizedBox(width: 50),
                GestureDetector(
                  onTap: () {
                    if (context.mounted) context.pop();
                  },
                  child: const Align(
                    alignment: Alignment.topRight,
                    child: Icon(CupertinoIcons.xmark, color: Colors.black),
                  ),
                ),
              ],
            ),
            // 이미지 영역
            content: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  spacing: 12,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AspectRatio(
                      aspectRatio: 0.8,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: ClipRRect(
                              child: selectedImage != null
                                  ? Image.file(
                                      selectedImage!,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      currentFeed.fileUrl,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          if (isEditing) ...[
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
                                    size: 28,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    // 좋아요, 댓글
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.favorite_border),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.chat_bubble_outline),
                        ),
                        if (isMe) ...[
                          Spacer(),
                          //
                          editAndDelete(context),
                        ],
                      ],
                    ),
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
    final user = ref.read(globalUserViewModelProvider);
    final myLikes = ref.watch(globalLikeProvider);
    final isLiked = myLikes.value?.contains(widget.feed.feedId) ?? false;

    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          spacing: 12,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(widget.feed.fileUrl),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12,
              children: [
                ItemButton(
                  icon: isLiked ? Icons.favorite : Icons.favorite_border,
                  onTap: () async {
                    if (user == null) return;
                    if (isLiked) {
                      setState(() {
                        likeCount--;
                      });
                    } else {
                      setState(() {
                        likeCount++;
                      });
                    }
                    ref.read(likeUsecaseProvider).like(user, widget.feed);
                  },
                  content: likeCount.toString(),
                ),
                ItemButton(
                  icon: Icons.chat_bubble_outline,
                  onTap: () {},
                  content: widget.feed.commentCount.toString(),
                ),
              ],
            ),
            Text(widget.feed.content),
          ],
        ),
      ),
      icon: GestureDetector(
        onTap: () {
          if (context.mounted) context.pop();
        },
        child: Align(
          alignment: Alignment.topRight,
          child: Icon(CupertinoIcons.xmark, color: Colors.black),
        ),
        if (isLoading)
          Positioned.fill(
            child: Container(
              color: Colors.black38,
              child: Center(child: CircularProgressIndicator()),
            ),
          ),
      ],
    );
  }
}

  GestureDetector editAndDelete(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // 1. 바텀시트 띄우고 결과 대기
        final String? action = await showModalBottomSheet<String>(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
          ),
          builder: (BuildContext context) {
            return SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(height: 20),
                  ListTile(
                    leading: const Icon(Icons.edit),
                    title: const Text('수정하기'),
                    onTap: () {
                      setState(() {
                        isEditing = true;
                      });
                      Navigator.pop(context, 'edit');
                    },
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
            );
          },
        );

        if (action == 'delete' && context.mounted) {
          // 2. 삭제 확인 다이얼로그 띄우고 결과 대기
          final bool? confirmed = await showDialog<bool>(
            context: context,
            builder: (BuildContext dialogContext) {
              return AlertDialog(
                title: const Text('게시물 삭제'),
                content: const Text('이 게시물을 정말로 삭제하시겠습니까?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(dialogContext, false),
                    child: const Text(
                      '취소',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(dialogContext, true),
                    child: const Text(
                      '삭제',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              );
            },
          );

          // 3. 최종 삭제 실행 및 상세창 닫기
          if (confirmed == true && context.mounted) {
            ref
                .read(myTapViewmodelProvider.notifier)
                .deleteFeed(widget.feed.feedId);

            // 현재 DetailDialog를 닫음
            Navigator.pop(context);
          }
        }
      },
      child: Icon(Icons.more_vert),
class ItemButton extends StatelessWidget {
  const ItemButton({
    super.key,
    required this.icon,
    required this.onTap,
    required this.content,
  });

  final IconData icon;
  final VoidCallback onTap;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(onPressed: onTap, icon: Icon(icon)),
        Text(content),
      ],
    );
  }
}
