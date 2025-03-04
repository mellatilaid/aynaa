part of 'delete_version_cubit.dart';

@immutable
sealed class DeleteVersionState {}

final class DeleteVersionInitial extends DeleteVersionState {}

final class DeleteVersionLoading extends DeleteVersionState {}

final class DeleteVersionSuccess extends DeleteVersionState {}

final class DeleteVersionFailed extends DeleteVersionState {
  final String errorMessage;
  DeleteVersionFailed(this.errorMessage);
}
