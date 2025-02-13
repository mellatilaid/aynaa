class PostEntity {
  final String postID;
  final String title;
  final String content;
  final String timeStamp;
  final String? image;

  PostEntity({
    required this.postID,
    required this.title,
    required this.content,
    required this.timeStamp,
    this.image,
  });
}
