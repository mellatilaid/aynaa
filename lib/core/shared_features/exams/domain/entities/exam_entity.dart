class ExamEntity {
  final String uuid;
  final String title;
  final String versionName;
  final String? image;
  final String? localFilePath;
  ExamEntity({
    required this.uuid,
    required this.title,
    required this.versionName,
    required this.image,
    required this.localFilePath,
  });
}
