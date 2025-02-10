import 'package:atm_app/core/entities/entitiy.dart';
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
  String description;
  final String aynaaVersionId;
  final String subjectId;
  @override
  final String versionName;
  final String subjectName;
  @override
  String? localFilePath;
  LessonEntity({
    required this.entityID,
    required this.name,
    this.url,
    required this.description,
    required this.aynaaVersionId,
    required this.subjectId,
    required this.versionName,
    required this.subjectName,
    this.localFilePath,
  });
}
