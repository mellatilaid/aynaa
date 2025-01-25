part of 'pick_file_cubit.dart';

@immutable
sealed class PickFileState {}

final class PickFileInitial extends PickFileState {}

final class PickFileLoading extends PickFileState {}

final class PickFileLoaded extends PickFileState {
  final XFile filePath;

  PickFileLoaded({required this.filePath});
}

final class PickFileFailure extends PickFileState {
  final String errMessage;

  PickFileFailure({required this.errMessage});
}

final class PickFileCanceled extends PickFileState {}
