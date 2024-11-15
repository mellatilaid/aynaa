part of 'sign_in_cubit.dart';

@immutable
sealed class SignInState {}

final class SignInInitial extends SignInState {}

final class SignInLoading extends SignInState {}

final class SignInFailure extends SignInState {
  final String errMessage;
  SignInFailure({required this.errMessage});
}

final class SignInSuccuss extends SignInState {
  final UserEntity userEntity;
  SignInSuccuss({required this.userEntity});
}
