import 'dart:developer';

import 'package:atm_app/core/errors/failures.dart';
import 'package:atm_app/core/services/data_base.dart';
import 'package:atm_app/core/shared_features/posts/domain/entities/post_entity.dart';
import 'package:atm_app/core/shared_features/posts/domain/repos/posts_repo.dart';
import 'package:atm_app/core/utils/db_enpoints.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/shared_features/posts/data/models/post_model.dart';

class AdminPostRepoImpl extends PostsRepo {
  final DataBase dataBase;

  AdminPostRepoImpl({required this.dataBase});
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
  Future<Either<Failures, List<PostEntity>>> fetchPost() {
    // TODO: implement fetchPost
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, void>> updatePost({required PostEntity post}) {
    // TODO: implement updatePost
    throw UnimplementedError();
  }
}
