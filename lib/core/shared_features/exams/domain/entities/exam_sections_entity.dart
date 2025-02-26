import 'package:atm_app/core/common/entitiy.dart';

class ExamSectionsEntity with Entity {
  @override
  final String entityID;
  final String title;
  final String examTitle;
  @override
  final String versionName;

  @override
  String? url;
  @override
  String? oldUrl;
  final String examID;
  @override
  String? localFilePath;
  bool isLocked;

  @override
  bool isDeleted;
  ExamSectionsEntity({
    required this.entityID,
    required this.title,
    required this.examTitle,
    required this.versionName,
    this.url,
    this.oldUrl,
    required this.examID,
    this.localFilePath,
    this.isDeleted = false,
    this.isLocked = true,
  });

  @override
  // TODO: implement name
  String? get name => throw UnimplementedError();
}
