import 'package:atm_app/features/admin/exams/domain/entities/exam_entity.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'fetch_exams_state.dart';

class FetchExamsCubit extends Cubit<FetchExamsState> {
  FetchExamsCubit() : super(FetchExamsInitial());
}
