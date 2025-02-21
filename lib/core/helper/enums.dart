enum Entities { lesson, version, subject, exams, examSections, questions }

enum CollentionType {
  versions,
  subjects,
  lessons,
  deletedItmes,
  exam,
}

enum PostgressEventType { insert, delete, update }

enum DeletedItemType { lesson, subject, version }

enum UserRole { admin, student }

enum FilterComparison { equal, greaterThan }
