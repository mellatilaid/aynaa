import 'package:atm_app/core/shared_features/posts/domain/entities/post_entity.dart';

import '../../../../const/remote_db_const.dart';

class PostModel extends PostEntity {
  PostModel(
      {required super.postID,
      required super.title,
      required super.content,
      required super.timeStamp});

  factory PostModel.fromEntity(PostEntity post) {
    return PostModel(
      postID: post.postID,
      title: post.title,
      content: post.content,
      timeStamp: post.timeStamp,
    );
  }

  toMap() {
    return {
      kPostID: postID,
      kPostTitle: title,
      kPostContent: content,
      kPostTimeStamp: timeStamp
    };
  }
}
