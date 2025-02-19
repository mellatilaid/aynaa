import 'package:atm_app/core/entities/entitiy.dart';

class ExamSectionsEntity with Entity {
  @override
  final String entityID;
  final String title;
  final String examTitle;
  @override
  final String versionName;

  @override
  String? url;
  final String examID;
  @override
  String? localFilePath;
  bool isLocked;
  ExamSectionsEntity({
    required this.entityID,
    required this.title,
    required this.examTitle,
    required this.versionName,
    this.url,
    required this.examID,
    this.localFilePath,
    this.isLocked = true,
  });

  @override
  // TODO: implement name
  String? get name => throw UnimplementedError();
}
