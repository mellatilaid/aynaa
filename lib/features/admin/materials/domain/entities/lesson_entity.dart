import 'package:atm_app/core/entities/entitiy.dart';

class LessonEntity implements Entity {
  @override
  final String? id;
  @override
  final String? name;
  final String? url;
  final String? description;
  final String aynaaVersionId;
  final String subjectId;

  const LessonEntity(
      {this.id,
      this.name,
      this.url,
      this.description,
      required this.aynaaVersionId,
      required this.subjectId});
}
