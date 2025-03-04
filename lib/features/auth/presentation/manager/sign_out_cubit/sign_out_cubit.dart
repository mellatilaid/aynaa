import 'package:atm_app/features/auth/domain/repos/auth_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'sign_out_state.dart';

class SignOutCubit extends Cubit<SignOutState> {
  final AuthRepo authRepo;
  SignOutCubit({required this.authRepo}) : super(SignOutInitial());

  Future<void> signOut() async {
    emit(SignOutLoading());

    final resault = await authRepo.signOut();
    resault.fold((failure) {
      emit(SignOutFailure(errMessage: failure.errMessage));
    }, (user) {
      emit(SignOutSuccuss());
    });
  }
}
