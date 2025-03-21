import 'package:atm_app/features/common/posts/domain/entities/post_entity.dart';

import '../../../../../core/const/remote_db_const.dart';

class PostModel extends PostEntity {
  PostModel({
    required super.postID,
    super.title,
    required super.content,
    required super.timeStamp,
  });

  factory PostModel.fromEntity(PostEntity post) {
    return PostModel(
      postID: post.postID,
      title: post.title,
      content: post.content,
      timeStamp: post.timeStamp,
    );
  }
  factory PostModel.fromMap(Map<String, dynamic> post) {
    return PostModel(
      postID: post[kPostID],
      title: post[kPostTitle],
      content: post[kPostContent],
      timeStamp: post[kPostTimeStamp],
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
