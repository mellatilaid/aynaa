import 'dart:async';
import 'dart:developer';

import 'package:atm_app/core/materials/data/data_source/lessons_data_source/lessons_remote_data_source.dart';
import 'package:atm_app/core/materials/domain/entities/lesson_entity.dart';
import 'package:atm_app/core/services/db_sync_service/db_sync_service.dart';
import 'package:atm_app/core/services/local_db_service/local_d_b_service.dart';
import 'package:atm_app/core/services/local_storage_service/i_local_storage_service.dart';
import 'package:atm_app/core/services/storage_service.dart';
import 'package:atm_app/core/utils/set_up_service_locator.dart';

import '../../../../../../core/const/remote_db_const.dart';
import '../../../../../../core/functions/map_to_list_of_entity.dart';
import '../../../../../../core/helper/enums.dart';
import '../../../../../../core/services/data_base.dart';
import '../../../../../../core/utils/db_enpoints.dart';

class StudentLessonsRemoteDataSourceImpl implements LessonsRemoteDataSource {
  final DataBase dataBase;
  final LocalDbService isarStorageService;
  final StorageService storageService;
  final ILocalStorageService fileCacheManager;
  StudentLessonsRemoteDataSourceImpl({
    required this.dataBase,
    required this.isarStorageService,
    required this.storageService,
    required this.fileCacheManager,
  });
  @override
  Future<List<LessonEntity>> fetchLessons(
      {required String subjectID, required String versionID}) async {
    log(subjectID);
    final List<Map<String, dynamic>> data =
        await dataBase.getData(path: DbEnpoints.lessons, query: {
      kSubjectID: subjectID,
      kVersionID: versionID,
    });

    List<LessonEntity> lessons =
        mapToListOfEntity<LessonEntity>(data, Entities.versions);

    if (lessons.isNotEmpty) {
      isarStorageService.putAll(
        items: lessons,
        collentionType: Entities.lessons,
      );
      getit.get<DBSyncService<LessonEntity>>().donwloadInBauckground(lessons);
    }

    return lessons;
  }

  @override
  Future<void> syncDB({required String subjectID}) {
    // TODO: implement syncDB
    throw UnimplementedError();
  }
}


/*final cachingFutures = lessons.map((lesson) async {
      if (lesson.url == null) return;

      final fileName = lesson.url!.replaceFirst('${lesson.versionName}/', '');
      /*final cachedPath = await FileSystemCacheManager().getCachedPath(fileName);
    
    // Return early if already cached
    if (cachedPath != null) {
      lesson.localFilePath = cachedPath;
      return;
    }*/

      final file = await SupaBaseStorage()
          .downloadFile(bucketName: lesson.versionName, filePath: fileName);
      final localPath =
          await FileSystemCacheManager().cacheFile(fileName, file);
      lesson.localFilePath = localPath;
    }).toList();

    // Wait for all downloads to complete before caching lessons
    await Future.wait(cachingFutures);*/