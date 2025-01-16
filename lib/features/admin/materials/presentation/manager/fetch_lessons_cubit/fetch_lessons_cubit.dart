import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/lesson_entity.dart';

part 'fetch_lessons_state.dart';

class FetchLessonsCubit extends Cubit<FetchLessonsState> {
  FetchLessonsCubit() : super(FetchLessonsInitial());
}
