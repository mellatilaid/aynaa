import 'package:atm_app/core/errors/failures.dart';
import 'package:atm_app/core/use_cases/use_case.dart';
import 'package:atm_app/features/common/posts/domain/entities/post_entity.dart';
import 'package:atm_app/features/common/posts/domain/repos/posts_repo.dart';
import 'package:dartz/dartz.dart';

class AddPostUseCase extends UseCase<void, PostEntity> {
  final PostsRepo postsRepo;

  AddPostUseCase({required this.postsRepo});
  @override
  Future<Either<Failures, void>> call(PostEntity param) async {
    return await postsRepo.addPost(post: param);
  }
}
