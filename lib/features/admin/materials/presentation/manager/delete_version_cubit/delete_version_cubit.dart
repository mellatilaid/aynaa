import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'delete_version_state.dart';

class DeleteVersionCubit extends Cubit<DeleteVersionState> {
  DeleteVersionCubit() : super(DeleteVersionInitial());
}
