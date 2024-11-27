import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'create_new_aynaa_version_state.dart';

class CreateNewAynaaVersionCubit extends Cubit<CreateNewAynaaVersionState> {
  CreateNewAynaaVersionCubit() : super(CreateNewAynaaVersionInitial());
}
