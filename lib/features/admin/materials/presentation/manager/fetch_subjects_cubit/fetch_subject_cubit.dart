import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/subjects_entity.dart';

part 'fetch_subject_state.dart';

class FetchSubjectCubit extends Cubit<FetchSubjectState> {
  FetchSubjectCubit() : super(FetchSubjectInitial());
}
