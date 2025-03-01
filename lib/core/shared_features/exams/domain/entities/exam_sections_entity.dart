import 'package:atm_app/core/common/entitiy.dart';
import 'package:isar/isar.dart';

part 'exam_sections_entity.g.dart';

@Collection()
class ExamSectionsEntity with Entity {
  Id id = Isar.autoIncrement;
  @override
  @Index(unique: true)
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
  String updatedAt;

  @override
  bool isDeleted;
  ExamSectionsEntity({
    required this.entityID,
    required this.title,
    required this.examTitle,
    required this.versionName,
    required this.updatedAt,
    this.url,
    this.oldUrl,
    required this.examID,
    this.localFilePath,
    this.isDeleted = false,
    this.isLocked = true,
  });

  @override
  // TODO: implement name
  String? get name => title;
}
