import 'package:atm_app/core/const/remote_db_const.dart';
import 'package:atm_app/core/functions/map_to_list_of_entity.dart';
import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/services/remote_db_service/i_remote_d_b_service.dart';
import 'package:atm_app/core/utils/db_enpoints.dart';
import 'package:atm_app/features/common/posts/domain/entities/post_entity.dart';

abstract class PostsRemoteDataSource {
  Future<List<PostEntity>> fetchPosts();
}

class PostsRemoteDataSourceImpl implements PostsRemoteDataSource {
  final IRemoteDBService dataBase;

  PostsRemoteDataSourceImpl({required this.dataBase});
  @override
  Future<List<PostEntity>> fetchPosts() async {
    List<PostEntity> items;

    final List<Map<String, dynamic>> data = await dataBase.getData(
      path: DbEnpoints.posts,
      query: {kIsDeleted: false},
    );
    items = mapToListOfEntity(data, Entities.posts);
    //update last time versions fetched from remote in settings

    return items;
  }
}
