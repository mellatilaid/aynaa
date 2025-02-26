import 'package:atm_app/core/common/entitiy.dart';
import 'package:isar/isar.dart';

part 'lesson_entity.g.dart';

@Collection()
class LessonEntity with Entity {
  Id id = Isar.autoIncrement;
  @override
  @Index(unique: true)
  final String entityID;
  @override
  String name;
  @override
  final String? url;
  @override
  String? oldUrl;
  String description;
  final String aynaaVersionId;
  final String subjectId;
  @override
  final String versionName;
  final String subjectName;
  @override
  String? localFilePath;
  @override
  String updatedAt;
  @override
  bool isDeleted;
  LessonEntity({
    required this.entityID,
    required this.name,
    this.url,
    required this.description,
    required this.aynaaVersionId,
    required this.subjectId,
    required this.versionName,
    required this.subjectName,
    required this.updatedAt,
    this.isDeleted = false,
    this.localFilePath,
    this.oldUrl,
  });
}
