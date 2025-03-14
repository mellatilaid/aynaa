import 'package:atm_app/features/common/posts/domain/entities/post_entity.dart';
import 'package:atm_app/features/common/posts/domain/use_cases/add_post_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'add_post_state.dart';

class AddPostCubit extends Cubit<AddPostState> {
  final AddPostUseCase addPostUseCase;
  AddPostCubit({required this.addPostUseCase}) : super(AddPostInitial());

  Future<void> addPost({required PostEntity post}) async {
    emit(AddPostLoading());
    final resault = await addPostUseCase.call(post);
    resault.fold((failure) {
      emit(AddPostFailure(errMessage: failure.errMessage));
    }, (succuss) {
      emit(AddPostSuccuss());
    });
  }
}
