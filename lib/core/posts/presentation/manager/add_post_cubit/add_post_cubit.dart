import 'package:atm_app/core/posts/domain/use_cases/add_post_use_case.dart';
import 'package:bloc/bloc.dart';

import '../../../../../features/admin/posts/presentation/manager/add_post_cubit/add_post_cubit.dart';
import '../../../domain/entities/post_entity.dart';

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
