import 'package:atm_app/core/entities/entitiy.dart';
import 'package:hive/hive.dart';

part 'lesson_entity.g.dart';

@HiveType(typeId: 2)
class LessonEntity extends HiveObject with Entity {
  @override
  @HiveField(0)
  final String? id;
  @override
  @HiveField(1)
  final String? name;
  @override
  @HiveField(2)
  final String? url;
  @HiveField(3)
  final String? description;
  @HiveField(4)
  final String aynaaVersionId;
  @HiveField(5)
  final String subjectId;
  @override
  @HiveField(6)
  final String versionName;
  @HiveField(7)
  final String subjectName;
  @override
  @HiveField(8)
  String? localFilePath;
  LessonEntity({
    this.id,
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
