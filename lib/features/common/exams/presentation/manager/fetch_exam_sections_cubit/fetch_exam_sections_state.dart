part of 'fetch_exam_sections_cubit.dart';

@immutable
sealed class FetchExamSectionsState {}

final class FetchExamSectionsInitial extends FetchExamSectionsState {}

final class FetchExamSectionsLoading extends FetchExamSectionsState {}

final class FetchExamSectionsSuccuss extends FetchExamSectionsState {
  final List<ExamSectionsEntity> sections;
  FetchExamSectionsSuccuss({required this.sections});
}

final class FetchExamSectionsFailure extends FetchExamSectionsState {
  final String errMessage;
  FetchExamSectionsFailure({required this.errMessage});
}
