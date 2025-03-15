class PostEntity {
  final String postID;
  final String? title;
  final String content;
  final String timeStamp;
  final String? imagePath;

  PostEntity({
    required this.postID,
    this.title,
    required this.content,
    required this.timeStamp,
    this.imagePath,
  });
}
