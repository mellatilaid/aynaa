//enum Entities { lesson, version, subject, exams, examSections, questions }

enum Entities {
  versions,
  subjects,
  lessons,

  exam,
  examSections,
  questions,
}

enum PostgressEventType { insert, delete, update }

//enum DeletedItemType { lesson, subject, version }

enum UserRole { admin, student }

enum FilterComparison { equal, greaterThan }
