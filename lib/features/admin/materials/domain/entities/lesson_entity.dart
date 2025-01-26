import 'package:atm_app/core/entities/entitiy.dart';
import 'package:hive/hive.dart';

part 'lesson_entity.g.dart';

@HiveType(typeId: 2)
class LessonEntity implements Entity {
  @override
  @HiveField(0)
  final String? id;
  @override
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final String? url;
  @HiveField(3)
  final String? description;
  @HiveField(4)
  final String aynaaVersionId;
  @HiveField(5)
  final String subjectId;
  @HiveField(6)
  final String versionName;
  @HiveField(7)
  final String subjectName;
  const LessonEntity({
    this.id,
    this.name,
    this.url,
    this.description,
    required this.aynaaVersionId,
    required this.subjectId,
    required this.versionName,
    required this.subjectName,
  });
}
