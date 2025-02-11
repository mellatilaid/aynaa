part of 'create_new_aynaa_version_cubit.dart';

@immutable
sealed class CreateNewAynaaVersionState {}

final class CreateNewAynaaVersionInitial extends CreateNewAynaaVersionState {}

final class CreateNewAynaaVersionLoading extends CreateNewAynaaVersionState {}

final class CreateNewAynaaVersionSuccess extends CreateNewAynaaVersionState {}

final class CreateNewAynaaVersionFailure extends CreateNewAynaaVersionState {
  final String errMessage;

  CreateNewAynaaVersionFailure({required this.errMessage});
}
