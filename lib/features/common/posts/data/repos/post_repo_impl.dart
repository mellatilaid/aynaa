import 'dart:developer';

import 'package:atm_app/core/errors/failures.dart';
import 'package:atm_app/core/services/remote_db_service/i_remote_d_b_service.dart';
import 'package:atm_app/core/utils/db_enpoints.dart';
import 'package:atm_app/features/common/posts/domain/entities/post_entity.dart';
import 'package:atm_app/features/common/posts/domain/repos/posts_repo.dart';
import 'package:dartz/dartz.dart';

import '../models/post_model.dart';

class PostRepoImpl extends PostsRepo {
  final IRemoteDBService dataBase;

  PostRepoImpl({required this.dataBase});
  @override
  Future<Either<Failures, void>> addPost({required PostEntity post}) async {
    try {
      PostModel postModel = PostModel.fromEntity(post);
      await dataBase.setDate(path: DbEnpoints.posts, data: postModel.toMap());
      return right(null);
    } catch (e) {
      log(e.toString());
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failures, void>> deletePost({required String postID}) {
    // TODO: implement deletePost
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, List<PostEntity>>> fetchPosts() {
    // TODO: implement fetchPost
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, void>> updatePost({required PostEntity post}) {
    // TODO: implement updatePost
    throw UnimplementedError();
  }
}
