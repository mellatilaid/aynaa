class LessonEntity {
  final String id;
  final String name;
  final String? url;
  final String? description;
  final String aynaaVersionId;
  final String subjectId;

  const LessonEntity(this.id, this.name, this.url, this.description,
      this.aynaaVersionId, this.subjectId);
}
