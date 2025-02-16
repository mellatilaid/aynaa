class ExamEntity {
  final String uuid;
  final String title;
  final String? image;
  final String? localFilePath;
  ExamEntity({
    required this.uuid,
    required this.title,
    required this.image,
    required this.localFilePath,
  });
}
