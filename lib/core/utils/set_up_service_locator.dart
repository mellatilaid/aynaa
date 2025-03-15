import 'dart:developer';

import 'package:atm_app/core/classes/pick_file.dart';
import 'package:atm_app/core/common/entitiy.dart';
import 'package:atm_app/core/common/settings_entity.dart';
import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/services/auth_service/supabase_auth_service.dart';
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
import 'package:atm_app/core/services/remote_db_service/i_remote_d_b_service.dart';
import 'package:atm_app/core/services/remote_db_service/supabase_db.dart';
import 'package:atm_app/core/services/remote_storage_service/i_remote_storage_service.dart';
import 'package:atm_app/core/services/remote_storage_service/supabase_storage.dart';
import 'package:atm_app/features/auth/data/repos/auth_repo_impl.dart';
import 'package:atm_app/features/auth/domain/repos/auth_repo.dart';
import 'package:atm_app/features/common/exams/data/data_source/exam_sections_data_source/exam_sections_local_data_source.dart';
import 'package:atm_app/features/common/exams/data/data_source/exam_sections_data_source/exam_sections_remote_data_source.dart';
import 'package:atm_app/features/common/exams/data/data_source/exams_data_source/exams_local_data_source.dart';
import 'package:atm_app/features/common/exams/data/data_source/exams_data_source/exams_remote_data_source.dart';
import 'package:atm_app/features/common/exams/data/data_source/questions_data_source/questions_local_data_source.dart';
import 'package:atm_app/features/common/exams/data/data_source/questions_data_source/questions_remote_data_source.dart';
import 'package:atm_app/features/common/exams/data/repos/exam_repo_impl.dart';
import 'package:atm_app/features/common/exams/domain/entities/exam_entity.dart';
import 'package:atm_app/features/common/exams/domain/entities/exam_sections_entity.dart';
import 'package:atm_app/features/common/exams/domain/entities/question_entity.dart';
import 'package:atm_app/features/common/exams/domain/repos/exam_sections_repo.dart';
import 'package:atm_app/features/common/exams/domain/repos/exams_repo.dart';
import 'package:atm_app/features/common/exams/domain/repos/question_repo.dart';
import 'package:atm_app/features/common/versions/data/data_source/lessons_data_source/lessons_local_data_source.dart';
import 'package:atm_app/features/common/versions/data/data_source/lessons_data_source/lessons_remote_data_source.dart';
import 'package:atm_app/features/common/versions/data/data_source/subjects_data_source/subjects_local_data_source.dart';
import 'package:atm_app/features/common/versions/data/data_source/subjects_data_source/subjects_remote_data_source.dart';
import 'package:atm_app/features/common/versions/data/data_source/versions_data_source/versions_local_data_source.dart';
import 'package:atm_app/features/common/versions/data/data_source/versions_data_source/versions_remote_data_source.dart';
import 'package:atm_app/features/common/versions/data/repos/versions_repo_impl.dart';
import 'package:atm_app/features/common/versions/domain/entities/aynaa_versions_entity.dart';
import 'package:atm_app/features/common/versions/domain/entities/deleted_itmes_entity.dart';
import 'package:atm_app/features/common/versions/domain/entities/lesson_entity.dart';
import 'package:atm_app/features/common/versions/domain/entities/subjects_entity.dart';
import 'package:atm_app/features/common/versions/domain/repos/lessons_repo.dart';
import 'package:atm_app/features/common/versions/domain/repos/subjects_repo.dart';
import 'package:atm_app/features/common/versions/domain/repos/versions_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../features/common/exams/data/repos/exam_sections_repo_impl.dart';
import '../../features/common/exams/data/repos/question_repo_impl.dart';
import '../../features/common/versions/data/repos/lessons_repo_impl.dart';
import '../../features/common/versions/data/repos/subjects_repo_impl.dart';
import '../services/local_db_service/i_local_db_service.dart';
import '../services/local_storage_service/i_local_storage_service.dart';

final getit = GetIt.instance;
setUpCoreServiceLocator() async {
  getit
    ..registerSingleton<IRemoteStorageService>(SupaBaseStorage())
    ..registerSingleton<IRemoteDBService>(SupabaseDb())
    ..registerSingleton<ProfileStorage>(ProfileStorageImpl()).loadUserProfile()
    ..registerSingletonAsync<Isar>(() async {
      try {
        final isar = await _isarInit();
        return isar;
      } catch (e) {
        rethrow;
      }
    })
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
            lastTimeExamsFetched: null,
            lastTimeSectionsFetched: null,
            lastTimeQuestionsFetched: null,
          ),
        ),
    );
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
      storageService: getit.get<IRemoteStorageService>(),
      updateLocalDataSource:
          (Entity entity, PostgressEventType eventType) async {
        return await null;
      },
      dataBase: getit.get<IRemoteDBService>(),
    ),
  );
  registerIfNotExists<VersionsLocalDataSource>(
    VersionsLocalDataSourceImpl(
      iLocalDbService: getit.get<ILocalDbService>(),
      iStorageSyncService: getit.get<IDBSyncService>(),
    ),
  );
  registerIfNotExists<SubjectsLocalDataSource>(
    SubjectsLocalDataSourceImpl(
      iLocalDbService: getit.get<ILocalDbService>(),
      iDBSyncService: getit.get<IDBSyncService>(),
    ),
  );
  registerIfNotExists<LessonsLocalDataSource>(
    LessonsLocalDataSourceImpl(
      iLocalDbService: getit.get<ILocalDbService>(),
      idbSyncService: getit.get<IDBSyncService>(),
    ),
  );
  registerIfNotExists<ExamsLocalDataSource>(
    ExamsLocalDataSourceImpl(
      iLocalDbService: getit.get<ILocalDbService>(),
      idbSyncService: getit.get<IDBSyncService>(),
    ),
  );
  registerIfNotExists<ExamSectionsLocalDataSource>(
    ExamSectionsLocalDataSourceImpl(
      iLocalDbService: getit.get<ILocalDbService>(),
      idbSyncService: getit.get<IDBSyncService>(),
    ),
  );
  registerIfNotExists<QuestionsLocalDataSource>(
    QuestionsLocalDataSourceImpl(
      iLocalDbService: getit.get<ILocalDbService>(),
    ),
  );
  registerIfNotExists<AynaaVersionsRemoteDataSource>(
    VersionsRemoteDataSourceImpl(
      dataBase: getit.get<IRemoteDBService>(),
      localDB: getit.get<ILocalDbService>(),
      iLocalSettingsService: getit.get<ILocalSettingsService>(),
      iStorageSyncService: getit.get<IDBSyncService>(),
    ),
  );
  registerIfNotExists<SubjectsRemoteDataSource>(
    SubjectsRemoteDataSourceImpl(
      dataBase: getit.get<IRemoteDBService>(),
      iLocalDbService: getit.get<ILocalDbService>(),
      storageSyncService: getit.get<IDBSyncService>(),
      iLocalSettingsService: getit.get<ILocalSettingsService>(),
    ),
  );
  registerIfNotExists<LessonsRemoteDataSource>(
    LessonsRemoteDataSourceImpl(
      dataBase: getit.get<IRemoteDBService>(),
      iLocalDbService: getit.get<ILocalDbService>(),
      storageSyncService: getit.get<IDBSyncService>(),
      iLocalSettingsService: getit.get<ILocalSettingsService>(),
    ),
  );
  registerIfNotExists<ExamsRemoteDataSource>(
    ExamsRemoteDataSourceImpl(
      dataBase: getit.get<IRemoteDBService>(),
      iLocalDbService: getit.get<ILocalDbService>(),
      iLocalSettingsService: getit.get<ILocalSettingsService>(),
      idbSyncService: getit.get<IDBSyncService>(),
    ),
  );
  registerIfNotExists<ExamSectionsRemoteDataSource>(
    ExamSectionsRemoteDataSourceImpl(
      dataBase: getit.get<IRemoteDBService>(),
      idbSyncService: getit.get<IDBSyncService>(),
      iLocalDbService: getit.get<ILocalDbService>(),
      iLocalSettingsService: getit.get<ILocalSettingsService>(),
    ),
  );
  registerIfNotExists<QuestionsRemoteDataSource>(
    QuestionsRemoteDataSourceImpl(
      dataBase: getit.get<IRemoteDBService>(),
      iLocalDbService: getit.get<ILocalDbService>(),
      idbSyncService: getit.get<IDBSyncService>(),
      iLocalSettingsService: getit.get<ILocalSettingsService>(),
    ),
  );

  registerIfNotExists<VersionsRepo>(
    VersionsRepoImpl(
      dataBase: getit.get<IRemoteDBService>(),
      storageService: getit.get<IRemoteStorageService>(),
      remoteDataSource: getit.get<AynaaVersionsRemoteDataSource>(),
      versionsLocalDataSource: getit.get<VersionsLocalDataSource>(),
      dbSyncService: getit.get<IDBSyncService>(),
      networkStateService: getit.get<INetworkStateService>(),
    ),
  );
  registerIfNotExists<SubjectsRepo>(
    SubjectsRepoImpl(
      dataBase: getit.get<IRemoteDBService>(),
      storageService: getit.get<IRemoteStorageService>(),
      subjectsRemoteDataSource: getit.get<SubjectsRemoteDataSource>(),
      subjectsLocalDataSource: getit.get<SubjectsLocalDataSource>(),
      iDBSyncService: getit.get<IDBSyncService>(),
      iNetworkStateService: getit.get<INetworkStateService>(),
    ),
  );
  registerIfNotExists<LessonsRepo>(
    LessonsRepoImpl(
        dataBase: getit.get<IRemoteDBService>(),
        iNetworkStateService: getit.get<INetworkStateService>(),
        storageService: getit.get<IRemoteStorageService>(),
        idbSyncService: getit.get<IDBSyncService>(),
        lessonsRemoteDataSource: getit.get<LessonsRemoteDataSource>(),
        lessonsLocalDataSource: getit.get<LessonsLocalDataSource>()),
  );
  registerIfNotExists<ExamsRepo>(
    ExamRepoImpl(
      dataBase: getit.get<IRemoteDBService>(),
      storageService: getit.get<IRemoteStorageService>(),
      iNetworkStateService: getit.get<INetworkStateService>(),
      examsRemoteDataSource: getit.get<ExamsRemoteDataSource>(),
      examsLocalDataSource: getit.get<ExamsLocalDataSource>(),
      idbSyncService: getit.get<IDBSyncService>(),
    ),
  );

  registerIfNotExists<ExamSectionsRepo>(
    ExamSectionsRepoImpl(
      dataBase: getit.get<IRemoteDBService>(),
      storageService: getit.get<IRemoteStorageService>(),
      remoteDataSource: getit.get<ExamSectionsRemoteDataSource>(),
      idbSyncService: getit.get<IDBSyncService>(),
      localDataSource: getit.get<ExamSectionsLocalDataSource>(),
      iNetworkStateService: getit.get<INetworkStateService>(),
    ),
  );
  registerIfNotExists<QuestionRepo>(
    QuestionRepoImpl(
      dataBase: getit.get<IRemoteDBService>(),
      storageService: getit.get<IRemoteStorageService>(),
      remoteDataSource: getit.get<QuestionsRemoteDataSource>(),
      localDataSource: getit.get<QuestionsLocalDataSource>(),
      idbSyncService: getit.get<IDBSyncService>(),
      iNetworkStateService: getit.get<INetworkStateService>(),
    ),
  );
  registerIfNotExists<FilePickerHelper>(FilePickerHelper());
}

Future<Isar> _isarInit() async {
  try {
    final dir = await getApplicationDocumentsDirectory();

    final isar = await Isar.open(
      [
        AynaaVersionsEntitySchema,
        LessonEntitySchema,
        SubjectsEntitySchema,
        DeletedItmesEntitySchema,
        ExamEntitySchema,
        SettingsEntitySchema,
        ExamSectionsEntitySchema,
        QuestionEntitySchema,
      ],
      directory: dir.path,
    );

    return isar;
  } catch (e, stackTrace) {
    log('Error creating Isar instance: $e', stackTrace: stackTrace);
    rethrow;
  }
}
