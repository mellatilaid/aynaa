import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/exam_sections_entity.dart';

part 'fetch_exam_sections_state.dart';

class FetchExamSectionsCubit extends Cubit<FetchExamSectionsState> {
  FetchExamSectionsCubit() : super(FetchExamSectionsInitial());
}
