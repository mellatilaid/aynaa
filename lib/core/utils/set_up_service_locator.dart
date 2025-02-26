import 'package:atm_app/core/classes/pick_file.dart';
import 'package:atm_app/core/common/entitiy.dart';
import 'package:atm_app/core/common/settings_entity.dart';
import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/materials/data/data_source/lessons_data_source/lessons_local_data_source.dart';
import 'package:atm_app/core/materials/data/data_source/lessons_data_source/lessons_remote_data_source.dart';
import 'package:atm_app/core/materials/data/data_source/subjects_data_source/subjects_local_data_source.dart';
import 'package:atm_app/core/materials/data/data_source/subjects_data_source/subjects_remote_data_source.dart';
import 'package:atm_app/core/materials/data/data_source/versions_data_source/versions_local_data_source.dart';
import 'package:atm_app/core/materials/data/data_source/versions_data_source/versions_remote_data_source.dart';
import 'package:atm_app/core/materials/domain/entities/aynaa_versions_entity.dart';
import 'package:atm_app/core/materials/domain/entities/deleted_itmes_entity.dart';
import 'package:atm_app/core/materials/domain/entities/lesson_entity.dart';
import 'package:atm_app/core/materials/domain/entities/subjects_entity.dart';
import 'package:atm_app/core/materials/domain/repos/lessons_repo.dart';
import 'package:atm_app/core/materials/domain/repos/subjects_repo.dart';
import 'package:atm_app/core/materials/domain/repos/versions_repo.dart';
import 'package:atm_app/core/services/data_base.dart';
import 'package:atm_app/core/services/db_sync_service/I_db_sync_service.dart';
import 'package:atm_app/core/services/db_sync_service/db_sync_service.dart';
import 'package:atm_app/core/services/internt_state_service/i_network_state_service.dart';
import 'package:atm_app/core/services/internt_state_service/network_state_service.dart';
import 'package:atm_app/core/services/local_db_service/local_d_b_service.dart';
import 'package:atm_app/core/services/local_settings_service/i_local_settings_service.dart';
import 'package:atm_app/core/services/local_settings_service/local_setting_service.dart';
import 'package:atm_app/core/services/local_storage_service/local_storage_service.dart';
import 'package:atm_app/core/services/profile_storage.dart';
import 'package:atm_app/core/services/realtime_sync_service.dart';
import 'package:atm_app/core/services/storage_service.dart';
import 'package:atm_app/core/services/supabase_DB.dart';
import 'package:atm_app/core/services/supabase_auth_service.dart';
import 'package:atm_app/core/services/supabase_storage.dart';
import 'package:atm_app/core/shared_features/exams/data/data_source/exam_sections_data_source/exam_sections_local_data_source.dart';
import 'package:atm_app/core/shared_features/exams/data/data_source/exam_sections_data_source/exam_sections_remote_data_source.dart';
import 'package:atm_app/core/shared_features/exams/data/data_source/exams_data_source/exams_local_data_source.dart';
import 'package:atm_app/core/shared_features/exams/data/data_source/exams_data_source/exams_remote_data_source.dart';
import 'package:atm_app/core/shared_features/exams/data/data_source/questions_data_source/questions_local_data_source.dart';
import 'package:atm_app/core/shared_features/exams/data/data_source/questions_data_source/questions_remote_data_source.dart';
import 'package:atm_app/core/shared_features/exams/domain/entities/exam_entity.dart';
import 'package:atm_app/features/admin/exams/data/data_source/exam_sections_data_source/admin_exam_sections_local_data_source_impl.dart';
import 'package:atm_app/features/admin/exams/data/data_source/exam_sections_data_source/admin_exam_sections_remote_data_source_impl.dart';
import 'package:atm_app/features/admin/exams/data/data_source/exams_data_source/admin_exams_local_data_source_impl.dart';
import 'package:atm_app/features/admin/exams/data/data_source/exams_data_source/admin_exams_remote_data_source_impl.dart';
import 'package:atm_app/features/admin/exams/data/data_source/questions_data_source/admin_questions_local_data_source_impl.dart';
import 'package:atm_app/features/admin/exams/data/data_source/questions_data_source/admin_questions_remote_data_source_impl.dart';
import 'package:atm_app/features/admin/materials/data/data_source/admin_lessons_data_source/admin_lessons_local_data_source.dart';
import 'package:atm_app/features/admin/materials/data/data_source/admin_subjects_data_source.dart/admin_subjects_local_data_source.dart';
import 'package:atm_app/features/admin/materials/data/data_source/admin_versions_data_source.dart/admin_versions_local_data_source.dart';
import 'package:atm_app/features/admin/materials/data/data_source/admin_versions_data_source.dart/admin_versions_remote_data_sourse.dart';
import 'package:atm_app/features/admin/materials/data/repos/admin_lessons_repo_impl.dart';
import 'package:atm_app/features/admin/materials/data/repos/admin_subjects_repo_impl.dart';
import 'package:atm_app/features/admin/materials/data/repos/admin_versions_repo_impl.dart';
import 'package:atm_app/features/auth/data/repos/auth_repo_impl.dart';
import 'package:atm_app/features/auth/domain/repos/auth_repo.dart';
import 'package:atm_app/features/student/materials/data/data_source/lessons_data_source/lessons_local_data_source.dart';
import 'package:atm_app/features/student/materials/data/data_source/lessons_data_source/lessons_remote_data_source.dart';
import 'package:atm_app/features/student/materials/data/data_source/subjects_data_source.dart/subjects_local_data_source.dart';
import 'package:atm_app/features/student/materials/data/data_source/subjects_data_source.dart/subjects_remote_data_source.dart';
import 'package:atm_app/features/student/materials/data/data_source/versions_data_source.dart/versions_local_data_source.dart';
import 'package:atm_app/features/student/materials/data/data_source/versions_data_source.dart/versions_remote_data_sourse.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../features/admin/materials/data/data_source/admin_lessons_data_source/admin_lessons_remote_data_source.dart';
import '../../features/admin/materials/data/data_source/admin_subjects_data_source.dart/admin_subjects_remote_data_source.dart';
import '../../features/student/materials/data/repos/student_lessons_repo_impl.dart';
import '../../features/student/materials/data/repos/student_subjects_repo_impl.dart';
import '../../features/student/materials/data/repos/student_versions_repo_impl.dart';
import '../services/local_db_service/i_local_db_service.dart';
import '../services/local_storage_service/i_local_storage_service.dart';

final getit = GetIt.instance;
setUpCoreServiceLocator() async {
  getit
    ..registerSingleton<StorageService>(SupaBaseStorage())
    ..registerSingleton<DataBase>(SupabaseDb())
    ..registerSingleton<ProfileStorage>(ProfileStorageImpl()).loadUserProfile()
    ..registerSingletonAsync<Isar>(() async => await _isarInit())
    ..registerSingleton<AuthRepo>(AuthRepoImpl(
        authServices: SupabaseAuthService(),
        dataBase: SupabaseDb(),
        profileStorage: getit.get<ProfileStorage>()))
    ..registerSingleton<INetworkStateService>(NetworkStateService());

  await getit.getAsync<Isar>();
  getit
    ..registerFactory<ILocalDbService>(() => LocalDbService(getit()))
    ..registerSingleton<RealtimeSyncService>(RealtimeSyncService())
    ..registerSingleton<ILocalSettingsService>(
      LocalSettingService(localDBService: getit.get<ILocalDbService>())
        ..init(
          settingsEntity: SettingsEntity(
            entityID: '0',
            lastTimeVersionsFetched: null,
            lastTimeSubjectsFetched: null,
            lastTimeLessonssFetched: null,
          ),
        ),
    );
}

setUpServiceLocator({required UserRole userRole}) {
  void registerIfNotExists<T extends Object>(T instance) {
    if (!getit.isRegistered<T>()) {
      getit.registerLazySingleton<T>(() => instance);
    }
  }

  registerIfNotExists<ILocalStorageService>(LocalStorageService());

  registerIfNotExists<IDBSyncService>(
    DBSyncService(
      iLocalDbService: getit.get<ILocalDbService>(),
      localStorageService: getit.get<ILocalStorageService>(),
      storageService: getit.get<StorageService>(),
      updateLocalDataSource:
          (Entity entity, PostgressEventType eventType) async {
        return await null;
      },
      dataBase: getit.get<DataBase>(),
    ),
  );

  /*registerIfNotExists<StorageSyncService<LessonEntity>>(
    StorageSyncService(
      iLocalDbService: getit.get<ILocalDbService>(),
      fileSystemCacheManager: getit.get<FileCacheManager>(),
      storageService: getit.get<StorageService>(),
      updateLocalDataSource:
          (LessonEntity entity, PostgressEventType eventType) =>
              getit.get<LessonsLocalDataSource>().handleUpdate(
                    lesson: entity,
                    eventType: eventType,
                  ),
    ),
  );

  registerIfNotExists<StorageSyncService<SubjectsEntity>>(
    StorageSyncService(
      iLocalDbService: getit.get<ILocalDbService>(),
      fileSystemCacheManager: getit.get<FileCacheManager>(),
      storageService: getit.get<StorageService>(),
      updateLocalDataSource:
          (SubjectsEntity entity, PostgressEventType eventType) =>
              getit.get<SubjectsLocalDataSource>().handleUpdate(
                    subject: entity,
                    eventType: eventType,
                  ),
    ),
  );

  registerIfNotExists<StorageSyncService<AynaaVersionsEntity>>(
    StorageSyncService(
      iLocalDbService: getit.get<ILocalDbService>(),
      fileSystemCacheManager: getit.get<FileCacheManager>(),
      storageService: getit.get<StorageService>(),
      updateLocalDataSource:
          (AynaaVersionsEntity entity, PostgressEventType eventType) =>
              getit.get<VersionsLocalDataSource>().handleUpdate(
                    version: entity,
                    eventType: eventType,
                  ),
    ),
  );*/

  /* registerIfNotExists<DBSyncService<ExamEntity>>(
    DBSyncService(
      iLocalDbService: getit.get<ILocalDbService>(),
      localStorageService: getit.get<ILocalStorageService>(),
      storageService: getit.get<StorageService>(),
      updateLocalDataSource:
          (ExamEntity entity, PostgressEventType eventType) =>
              getit.get<ExamsLocalDataSource>().handleUpdate(
                    exam: entity,
                    eventType: eventType,
                  ),
    ),
  );
  registerIfNotExists<DBSyncService<ExamSectionsEntity>>(
    DBSyncService(
      iLocalDbService: getit.get<ILocalDbService>(),
      localStorageService: getit.get<ILocalStorageService>(),
      storageService: getit.get<StorageService>(),
      updateLocalDataSource:
          (ExamSectionsEntity entity, PostgressEventType eventType) =>
              getit.get<ExamSectionsLocalDataSource>().handleUpdate(
                    item: entity,
                    eventType: eventType,
                  ),
    ),
  );*/

  switch (userRole) {
    case UserRole.admin:
      registerIfNotExists<VersionsLocalDataSource>(
        AdminVersionsLocalDataSourceImpl(
          iLocalDbService: getit.get<ILocalDbService>(),
          iStorageSyncService: getit.get<IDBSyncService>(),
        ),
      );
      registerIfNotExists<SubjectsLocalDataSource>(
        AdminSubjectsLocalDataSourceImpl(
          iLocalDbService: getit.get<ILocalDbService>(),
          iDBSyncService: getit.get<IDBSyncService>(),
        ),
      );
      registerIfNotExists<LessonsLocalDataSource>(
        AdminLessonsLocalDataSourceImpl(
          iLocalDbService: getit.get<ILocalDbService>(),
          idbSyncService: getit.get<IDBSyncService>(),
        ),
      );
      registerIfNotExists<ExamsLocalDataSource>(
        AdminExamsLocalDataSourceImpl(
            iLocalDbService: getit.get<ILocalDbService>()),
      );
      registerIfNotExists<ExamSectionsLocalDataSource>(
        AdminExamSectionsLocalDataSourceImpl(
          iLocalDbService: getit.get<ILocalDbService>(),
        ),
      );
      registerIfNotExists<QuestionsLocalDataSource>(
        AdminQuestionsLocalDataSourceImpl(),
      );
      registerIfNotExists<AynaaVersionsRemoteDataSource>(
        AdminVersionsRemoteDataSourceImpl(
          dataBase: getit.get<DataBase>(),
          localDB: getit.get<ILocalDbService>(),
          iLocalSettingsService: getit.get<ILocalSettingsService>(),
          iStorageSyncService: getit.get<IDBSyncService>(),
        ),
      );
      registerIfNotExists<SubjectsRemoteDataSource>(
        AdminSubjectsRemoteDataSourceImpl(
          dataBase: getit.get<DataBase>(),
          iLocalDbService: getit.get<ILocalDbService>(),
          storageSyncService: getit.get<IDBSyncService>(),
          iLocalSettingsService: getit.get<ILocalSettingsService>(),
        ),
      );
      registerIfNotExists<LessonsRemoteDataSource>(
        LessonsRemoteDataSourceImpl(
          dataBase: getit.get<DataBase>(),
          iLocalDbService: getit.get<ILocalDbService>(),
          storageSyncService: getit.get<IDBSyncService>(),
          iLocalSettingsService: getit.get<ILocalSettingsService>(),
        ),
      );
      registerIfNotExists<ExamsRemoteDataSource>(
        AdminExamsRemoteDataSourceImpl(
          dataBase: getit.get<DataBase>(),
          iLocalDbService: getit.get<ILocalDbService>(),
        ),
      );
      registerIfNotExists<ExamSectionsRemoteDataSource>(
        AdminExamSectionsRemoteDataSourceImpl(
          dataBase: getit.get<DataBase>(),
          iLocalDbService: getit.get<ILocalDbService>(),
        ),
      );
      registerIfNotExists<QuestionsRemoteDataSource>(
        AdminQuestionsRemoteDataSourceImpl(
          dataBase: getit.get<DataBase>(),
          iLocalDbService: getit.get<ILocalDbService>(),
        ),
      );

      registerIfNotExists<VersionsRepo>(
        AdminVersionsRepoImpl(
          dataBase: getit.get<DataBase>(),
          storageService: getit.get<StorageService>(),
          remoteDataSource: getit.get<AynaaVersionsRemoteDataSource>(),
          versionsLocalDataSource: getit.get<VersionsLocalDataSource>(),
          dbSyncService: getit.get<IDBSyncService>(),
          networkStateService: getit.get<INetworkStateService>(),
        ),
      );
      registerIfNotExists<SubjectsRepo>(
        AdminSubjectsRepoImpl(
          dataBase: getit.get<DataBase>(),
          storageService: getit.get<StorageService>(),
          subjectsRemoteDataSource: getit.get<SubjectsRemoteDataSource>(),
          subjectsLocalDataSource: getit.get<SubjectsLocalDataSource>(),
          iDBSyncService: getit.get<IDBSyncService>(),
          iNetworkStateService: getit.get<INetworkStateService>(),
        ),
      );
      registerIfNotExists<LessonsRepo>(
        AdminLessonsRepoImpl(
            dataBase: getit.get<DataBase>(),
            storageService: getit.get<StorageService>(),
            lessonsRemoteDataSource: getit.get<LessonsRemoteDataSource>(),
            lessonsLocalDataSource: getit.get<LessonsLocalDataSource>()),
      );
      /* registerIfNotExists<ExamsRepo>(
        AdminExamRepoImpl(
            dataBase: getit.get<DataBase>(),
            storageService: getit.get<StorageService>(),
            examsRemoteDataSource: getit.get<ExamsRemoteDataSource>(),
            examsLocalDataSource: getit.get<ExamsLocalDataSource>()),
      );
      registerIfNotExists<ExamSectionsRepo>(
        AdminExamSectionsRepoImpl(
            dataBase: getit.get<DataBase>(),
            storageService: getit.get<StorageService>(),
            remoteDataSource: getit.get<ExamSectionsRemoteDataSource>(),
            localDataSource: getit.get<ExamSectionsLocalDataSource>()),
      );
      registerIfNotExists<QuestionRepo>(
        AdminQuestionRepoImpl(
            dataBase: getit.get<DataBase>(),
            storageService: getit.get<StorageService>(),
            remoteDataSource: getit.get<QuestionsRemoteDataSource>(),
            localDataSource: getit.get<QuestionsLocalDataSource>()),
      );*/

      break;
    case UserRole.student:
      registerIfNotExists<VersionsLocalDataSource>(
        StudentVersionsLocalDataSourceImpl(
          iLocalDbService: getit.get<ILocalDbService>(),
        ),
      );
      registerIfNotExists<SubjectsLocalDataSource>(
        StudentSubjectsLocalDataSourceImpl(
          iLocalDbService: getit.get<ILocalDbService>(),
        ),
      );
      registerIfNotExists<LessonsLocalDataSource>(
        StudentLessonsLocalDataSourceImpl(
          iLocalDbService: getit.get<ILocalDbService>(),
        ),
      );
      registerIfNotExists<AynaaVersionsRemoteDataSource>(
        StudentVersionsRemoteDataSourceImpl(
          dataBase: getit.get<DataBase>(),
          isarStorageService: getit.get<LocalDbService>(),
        ),
      );
      registerIfNotExists<SubjectsRemoteDataSource>(
        StudentSubjectsRemoteDataSourceImpl(
          dataBase: getit.get<DataBase>(),
          isarStorageService: getit.get<LocalDbService>(),
        ),
      );
      registerIfNotExists<LessonsRemoteDataSource>(
        StudentLessonsRemoteDataSourceImpl(
          dataBase: getit.get<DataBase>(),
          isarStorageService: getit.get<LocalDbService>(),
          storageService: getit.get<StorageService>(),
          fileCacheManager: getit.get<ILocalStorageService>(),
        ),
      );

      registerIfNotExists<VersionsRepo>(
        StudentVersionsRepoImpl(
          dataBase: getit.get<DataBase>(),
          storageService: getit.get<StorageService>(),
          remoteDataSource: getit.get<AynaaVersionsRemoteDataSource>(),
          versionsLocalDataSource: getit.get<VersionsLocalDataSource>(),
          backgroundServices: getit.get<DBSyncService<AynaaVersionsEntity>>(),
        ),
      );
      registerIfNotExists<SubjectsRepo>(
        StudentSubjectsRepoImpl(
          dataBase: getit.get<DataBase>(),
          storageService: getit.get<StorageService>(),
          subjectsRemoteDataSource: getit.get<SubjectsRemoteDataSource>(),
          subjectsLocalDataSource: getit.get<SubjectsLocalDataSource>(),
          backgroundDownloadService: getit.get<DBSyncService<SubjectsEntity>>(),
        ),
      );
      registerIfNotExists<LessonsRepo>(
        StudentLessonsRepoImpl(
            dataBase: getit.get<DataBase>(),
            storageService: getit.get<StorageService>(),
            lessonsRemoteDataSource: getit.get<LessonsRemoteDataSource>(),
            lessonsLocalDataSource: getit.get<LessonsLocalDataSource>()),
      );
      break;
  }

  registerIfNotExists<FilePickerHelper>(FilePickerHelper());
}

Future<Isar> _isarInit() async {
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [
      AynaaVersionsEntitySchema,
      LessonEntitySchema,
      SubjectsEntitySchema,
      DeletedItmesEntitySchema,
      ExamEntitySchema,
      SettingsEntitySchema,
    ],
    directory: dir.path,
  );

  return isar;
}

/*setUpServiceLocator({required UserRole userRole}) {
  void registerIfNotExists<T extends Object>(T instance) {
    if (!getit.isRegistered<T>()) {
      getit.registerSingleton<T>(instance);
    }
  }

  /*getit.registerSingleton<LocalCacheService<AynaaVersionsEntity>>(
      BaseHiveCache());
  getit.registerSingleton<LocalCacheService<SubjectsEntity>>(BaseHiveCache());
  getit.registerSingleton<LocalCacheService<LessonEntity>>(BaseHiveCache());*/

  getit.registerSingleton<FileCacheManager>(FileSystemCacheManager());
  getit.registerSingleton<BackgroundServices<LessonEntity>>(
    BackgroundServices(
      fileSystemCacheManager: getit.get<FileCacheManager>(),
      storageService: getit.get<StorageService>(),
      updateLocalDataSource:
          (LessonEntity entity, PostgressEventType eventType) =>
              getit.get<LessonsLocalDataSource>().handleUpdate(
                    lesson: entity,
                    eventType: eventType,
                  ),
    ),
  );
  getit.registerSingleton<BackgroundServices<SubjectsEntity>>(
    BackgroundServices(
      fileSystemCacheManager: getit.get<FileCacheManager>(),
      storageService: getit.get<StorageService>(),
      updateLocalDataSource:
          (SubjectsEntity entity, PostgressEventType eventType) =>
              getit.get<SubjectsLocalDataSource>().handleUpdate(
                    subject: entity,
                    eventType: eventType,
                  ),
    ),
  );
  getit.registerSingleton<BackgroundServices<AynaaVersionsEntity>>(
    BackgroundServices(
      fileSystemCacheManager: getit.get<FileCacheManager>(),
      storageService: getit.get<StorageService>(),
      updateLocalDataSource:
          (AynaaVersionsEntity entity, PostgressEventType eventType) =>
              getit.get<VersionsLocalDataSource>().handleUpdate(
                    version: entity,
                    eventType: eventType,
                  ),
    ),
  );
  switch (userRole) {
    case UserRole.admin:
      getit.registerSingleton<VersionsLocalDataSource>(
        AdminVersionsLocalDataSourceImpl(
          isarStorageService: getit.get<IsarStorageService>(),
        ),
      );
      getit.registerSingleton<SubjectsLocalDataSource>(
        AdminSubjectsLocalDataSourceImpl(
          isarStorageService: getit.get<IsarStorageService>(),
        ),
      );
      getit.registerSingleton<LessonsLocalDataSource>(
        AdminLessonsLocalDataSourceImpl(
          isarStorageService: getit.get<IsarStorageService>(),
        ),
      );
      getit.registerSingleton<AynaaVersionsRemoteDataSource>(
          AdminVersionsRemoteDataSourceImpl(
        dataBase: getit.get<DataBase>(),
        isarStorageService: getit.get<IsarStorageService>(),
      ));
      getit.registerSingleton<SubjectsRemoteDataSource>(
          AdminSubjectsRemoteDataSourceImpl(
        dataBase: getit.get<DataBase>(),
        isarStorageService: getit.get<IsarStorageService>(),
      ));
      getit.registerSingleton<LessonsRemoteDataSource>(
          LessonsRemoteDataSourceImpl(
        dataBase: getit.get<DataBase>(),
        isarStorageService: getit.get<IsarStorageService>(),
        storageService: getit.get<StorageService>(),
        fileCacheManager: getit.get<FileCacheManager>(),
      ));
      getit.registerSingleton<VersionsRepo>(
        AdminVersionsRepoImpl(
          dataBase: getit.get<DataBase>(),
          storageService: getit.get<StorageService>(),
          remoteDataSource: getit.get<AynaaVersionsRemoteDataSource>(),
          versionsLocalDataSource: getit.get<VersionsLocalDataSource>(),
          backgroundServices:
              getit.get<BackgroundServices<AynaaVersionsEntity>>(),
        ),
      );
      getit.registerSingleton<SubjectsRepo>(
        AdminSubjectsRepoImpl(
          dataBase: getit.get<DataBase>(),
          storageService: getit.get<StorageService>(),
          subjectsRemoteDataSource: getit.get<SubjectsRemoteDataSource>(),
          subjectsLocalDataSource: getit.get<SubjectsLocalDataSource>(),
          backgroundDownloadService:
              getit.get<BackgroundServices<SubjectsEntity>>(),
        ),
      );
      getit.registerSingleton<LessonsRepo>(
        AdminLessonsRepoImpl(
            dataBase: getit.get<DataBase>(),
            storageService: getit.get<StorageService>(),
            lessonsRemoteDataSource: getit.get<LessonsRemoteDataSource>(),
            lessonsLocalDataSource: getit.get<LessonsLocalDataSource>()),
      );
      break;
    case UserRole.student:
      getit.registerSingleton<VersionsLocalDataSource>(
        StudentVersionsLocalDataSourceImpl(
          isarStorageService: getit.get<IsarStorageService>(),
        ),
      );
      getit.registerSingleton<SubjectsLocalDataSource>(
        StudentSubjectsLocalDataSourceImpl(
          isarStorageService: getit.get<IsarStorageService>(),
        ),
      );
      getit.registerSingleton<LessonsLocalDataSource>(
        StudentLessonsLocalDataSourceImpl(
          isarStorageService: getit.get<IsarStorageService>(),
        ),
      );
      getit.registerSingleton<AynaaVersionsRemoteDataSource>(
          StudentVersionsRemoteDataSourceImpl(
        dataBase: getit.get<DataBase>(),
        isarStorageService: getit.get<IsarStorageService>(),
      ));
      getit.registerSingleton<SubjectsRemoteDataSource>(
          StudentSubjectsRemoteDataSourceImpl(
        dataBase: getit.get<DataBase>(),
        isarStorageService: getit.get<IsarStorageService>(),
      ));
      getit.registerSingleton<LessonsRemoteDataSource>(
          StudentLessonsRemoteDataSourceImpl(
        dataBase: getit.get<DataBase>(),
        isarStorageService: getit.get<IsarStorageService>(),
        storageService: getit.get<StorageService>(),
        fileCacheManager: getit.get<FileCacheManager>(),
      ));
      getit.registerSingleton<VersionsRepo>(
        StudentVersionsRepoImpl(
          dataBase: getit.get<DataBase>(),
          storageService: getit.get<StorageService>(),
          remoteDataSource: getit.get<AynaaVersionsRemoteDataSource>(),
          versionsLocalDataSource: getit.get<VersionsLocalDataSource>(),
          backgroundServices:
              getit.get<BackgroundServices<AynaaVersionsEntity>>(),
        ),
      );
      getit.registerSingleton<SubjectsRepo>(
        StudentSubjectsRepoImpl(
          dataBase: getit.get<DataBase>(),
          storageService: getit.get<StorageService>(),
          subjectsRemoteDataSource: getit.get<SubjectsRemoteDataSource>(),
          subjectsLocalDataSource: getit.get<SubjectsLocalDataSource>(),
          backgroundDownloadService:
              getit.get<BackgroundServices<SubjectsEntity>>(),
        ),
      );
      getit.registerSingleton<LessonsRepo>(
        StudentLessonsRepoImpl(
            dataBase: getit.get<DataBase>(),
            storageService: getit.get<StorageService>(),
            lessonsRemoteDataSource: getit.get<LessonsRemoteDataSource>(),
            lessonsLocalDataSource: getit.get<LessonsLocalDataSource>()),
      );
  }

  getit.registerSingleton<FilePickerHelper>(FilePickerHelper());
  getit.registerSingleton<DeleteItemsService>(DeleteItemsServiceImpl(
      dataBase: getit.get<DataBase>(),
      storageService: getit.get<StorageService>(),
      isarStorageService: getit.get<IsarStorageService>()));

  /*getit
      .registerSingleton<CachIndexLessonsInBackground>(
          CachIndexLessonsInBackground(
              hiveCache: getit.get<LocalCacheService<LessonEntity>>()))
      .initializeCacheInBackground();*/
}*/
