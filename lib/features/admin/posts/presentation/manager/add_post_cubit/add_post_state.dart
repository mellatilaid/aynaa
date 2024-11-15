part of 'add_post_cubit.dart';

@immutable
sealed class AddPostState {}

final class AddPostInitial extends AddPostState {}

final class AddPostLoading extends AddPostState {}

final class AddPostFailure extends AddPostState {
  final String errMessage;

  AddPostFailure({required this.errMessage});
}

final class AddPostSuccuss extends AddPostState {}
