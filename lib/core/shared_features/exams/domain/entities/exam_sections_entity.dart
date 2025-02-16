class ExamSectionsEntity {
  final String entityID;
  final String title;
  String? url;
  final String examID;
  String? localFilePath;

  ExamSectionsEntity({
    required this.entityID,
    required this.title,
    this.url,
    required this.examID,
    this.localFilePath,
  });
}
