class ExamSectionsEntity {
  final String entityID;
  final String title;
  final String examTitle;
  final String versionName;

  String? url;
  final String examID;
  String? localFilePath;

  ExamSectionsEntity({
    required this.entityID,
    required this.title,
    required this.examTitle,
    required this.versionName,
    this.url,
    required this.examID,
    this.localFilePath,
  });
}
