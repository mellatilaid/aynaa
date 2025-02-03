import 'package:atm_app/core/entities/entitiy.dart';
import 'package:isar/isar.dart';

part 'lesson_entity.g.dart';

@Collection()
class LessonEntity with Entity {
  Id id = Isar.autoIncrement;
  @override
  final String entityID;
  @override
  final String? name;
  @override
  final String? url;
  final String? description;
  final String aynaaVersionId;
  final String subjectId;
  @override
  final String versionName;
  final String subjectName;
  @override
  String? localFilePath;
  LessonEntity({
    required this.entityID,
    this.name,
    this.url,
    this.description,
    required this.aynaaVersionId,
    required this.subjectId,
    required this.versionName,
    required this.subjectName,
    this.localFilePath,
  });
}
