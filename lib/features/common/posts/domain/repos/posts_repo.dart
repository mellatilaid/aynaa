import 'package:atm_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

import '../entities/post_entity.dart';

abstract class PostsRepo {
  Future<Either<Failures, void>> addPost({required PostEntity post});
  Future<Either<Failures, void>> deletePost({required String postID});
  Future<Either<Failures, void>> updatePost({required PostEntity post});
  Future<Either<Failures, List<PostEntity>>> fetchPosts();
}
