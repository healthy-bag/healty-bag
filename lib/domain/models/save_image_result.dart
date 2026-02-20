sealed class SaveImageResult {}

class SaveImageSuccess extends SaveImageResult {
  final String imageUrl;
  SaveImageSuccess({required this.imageUrl});
}

class SaveImageFailure extends SaveImageResult {
  final String message;
  SaveImageFailure({required this.message});
}
