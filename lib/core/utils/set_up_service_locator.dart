import 'package:atm_app/core/classes/pick_file.dart';
import 'package:atm_app/core/services/cach_index_lessons_in_background.dart';
import 'package:atm_app/core/services/data_base.dart';
import 'package:atm_app/core/services/file_cach_manager.dart';
import 'package:atm_app/core/services/hive_base_impl.dart';
import 'package:atm_app/core/services/isar_storage_service.dart';
import 'package:atm_app/core/services/local_storage_service.dart';
import 'package:atm_app/core/services/storage_service.dart';
import 'package:atm_app/core/services/supabase_DB.dart';
import 'package:atm_app/core/services/supabase_auth_service.dart';
import 'package:atm_app/core/services/supabase_storage.dart';
import 'package:atm_app/features/admin/materials/data/data_source/aynaa_versions_data_source.dart/aynaa_versions_remote_data_sourse.dart';
import 'package:atm_app/features/admin/materials/data/data_source/aynaa_versions_data_source.dart/versions_local_data_source.dart';
import 'package:atm_app/features/admin/materials/data/data_source/lessons_data_source/lessons_local_data_source.dart';
import 'package:atm_app/features/admin/materials/data/data_source/lessons_data_source/lessons_remote_data_source.dart';
import 'package:atm_app/features/admin/materials/data/data_source/subjects_data_source.dart/subjects_local_data_source.dart';
import 'package:atm_app/features/admin/materials/data/data_source/subjects_data_source.dart/subjects_remote_data_source.dart';
import 'package:atm_app/features/admin/materials/data/repos/lessons_repo_impl.dart';
import 'package:atm_app/features/admin/materials/data/repos/subjects_repo_impl.dart';
import 'package:atm_app/features/admin/materials/domain/entities/aynaa_versions_entity.dart';
import 'package:atm_app/features/admin/materials/domain/entities/lesson_entity.dart';
import 'package:atm_app/features/admin/materials/domain/entities/subjects_entity.dart';
import 'package:atm_app/features/admin/materials/domain/repos/lessons_repo.dart';
import 'package:atm_app/features/admin/materials/domain/repos/subjects_repo.dart';
import 'package:atm_app/features/admin/materials/domain/repos/versions_repo.dart';
import 'package:atm_app/features/auth/data/repos/auth_repo_impl.dart';
import 'package:atm_app/features/auth/domain/repos/auth_repo.dart';
import 'package:get_it/get_it.dart';

import '../../features/admin/materials/data/repos/versions_repo_impl.dart';
import '../services/background_download_service.dart';

final getit = GetIt.instance;

setUpServiceLocator() {
  getit.registerSingleton<AuthRepo>(AuthRepoImpl(
      authServices: SupabaseAuthService(), dataBase: SupabaseDb()));
  getit.registerSingleton<DataBase>(SupabaseDb());
  getit.registerSingleton<StorageService>(SupaBaseStorage());
  getit.registerSingleton<IsarStorageService>(IsarStorageService());
  getit.registerSingleton<LocalCacheService<AynaaVersionsEntity>>(
      BaseHiveCache());
  getit.registerSingleton<LocalCacheService<SubjectsEntity>>(BaseHiveCache());
  getit.registerSingleton<LocalCacheService<LessonEntity>>(BaseHiveCache());
  getit.registerSingleton<FileCacheManager>(FileSystemCacheManager());
  getit.registerSingleton<VersionsLocalDataSource>(
    VersionsLocalDataSourceImpl(
      hiveCache: getit.get<LocalCacheService<AynaaVersionsEntity>>(),
    ),
  );
  getit.registerSingleton<SubjectsLocalDataSource>(
    SubjectsLocalDataSourceImpl(
      hiveCache: getit.get<LocalCacheService<SubjectsEntity>>(),
    ),
  );
  getit.registerSingleton<LessonsLocalDataSource>(
    LessonsLocalDataSourceImpl(
      hiveCache: getit.get<LocalCacheService<LessonEntity>>(),
    ),
  );
  getit.registerSingleton<AynaaVersionsRemoteDataSource>(
      AynaaVersionsRemoteDataSourceImpl(
    dataBase: getit.get<DataBase>(),
    isarStorageService: getit.get<IsarStorageService>(),
  ));
  getit
      .registerSingleton<SubjectsRemoteDataSource>(SubjectsRemoteDataSourceImpl(
    dataBase: getit.get<DataBase>(),
    hiveCache: getit.get<LocalCacheService<SubjectsEntity>>(),
  ));
  getit.registerSingleton<LessonsRemoteDataSource>(LessonsRemoteDataSourceImpl(
    dataBase: getit.get<DataBase>(),
    hiveCache: getit.get<LocalCacheService<LessonEntity>>(),
    storageService: getit.get<StorageService>(),
    fileCacheManager: getit.get<FileCacheManager>(),
  ));
  getit.registerSingleton<VersionsRepo>(
    VersionsRepoImpl(
      dataBase: getit.get<DataBase>(),
      storageService: getit.get<StorageService>(),
      remoteDataSource: getit.get<AynaaVersionsRemoteDataSource>(),
      versionsLocalDataSource: getit.get<VersionsLocalDataSource>(),
    ),
  );
  getit.registerSingleton<SubjectsRepo>(
    SubjectsRepoImpl(
      dataBase: getit.get<DataBase>(),
      subjectsRemoteDataSource: getit.get<SubjectsRemoteDataSource>(),
      subjectsLocalDataSource: getit.get<SubjectsLocalDataSource>(),
    ),
  );
  getit.registerSingleton<LessonsRepo>(
    LessonsRepoImpl(
        dataBase: getit.get<DataBase>(),
        storageService: getit.get<StorageService>(),
        lessonsRemoteDataSource: getit.get<LessonsRemoteDataSource>(),
        lessonsLocalDataSource: getit.get<LessonsLocalDataSource>()),
  );

  getit.registerSingleton<BackgroundDownloadService<LessonEntity>>(
    BackgroundDownloadService(
        fileSystemCacheManager: getit.get<FileCacheManager>(),
        storageService: getit.get<StorageService>(),
        updateLocalDataSource: (LessonEntity entity) =>
            getit.get<LessonsLocalDataSource>().handleUpdate(
                  lesson: entity,
                )),
  );
  getit.registerSingleton<FilePickerHelper>(FilePickerHelper());
  getit
      .registerSingleton<CachIndexLessonsInBackground>(
          CachIndexLessonsInBackground(
              hiveCache: getit.get<LocalCacheService<LessonEntity>>()))
      .initializeCacheInBackground();
}
