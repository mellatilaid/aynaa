import 'package:atm_app/features/auth/domain/repos/auth_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/user_entity.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final AuthRepo authRepo;
  SignInCubit(this.authRepo) : super(SignInInitial());

  Future<void> signInWithGoogle() async {
    emit(SignInLoading());

    final resault = await authRepo.signInWithGoogle();
    resault.fold((failure) {
      emit(SignInFailure(errMessage: failure.errMessage));
    }, (user) {
      emit(SignInSuccuss(userEntity: user));
    });
  }
}
