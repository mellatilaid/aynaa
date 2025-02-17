import 'package:atm_app/core/classes/pick_file.dart';
import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/materials/data/data_source/lessons_data_source/lessons_local_data_source.dart';
import 'package:atm_app/core/materials/data/data_source/lessons_data_source/lessons_remote_data_source.dart';
import 'package:atm_app/core/materials/data/data_source/subjects_data_source/subjects_local_data_source.dart';
import 'package:atm_app/core/materials/data/data_source/subjects_data_source/subjects_remote_data_source.dart';
import 'package:atm_app/core/materials/data/data_source/versions_data_source/versions_local_data_source.dart';
import 'package:atm_app/core/materials/data/data_source/versions_data_source/versions_remote_data_source.dart';
import 'package:atm_app/core/materials/domain/entities/aynaa_versions_entity.dart';
import 'package:atm_app/core/materials/domain/entities/lesson_entity.dart';
import 'package:atm_app/core/materials/domain/entities/subjects_entity.dart';
import 'package:atm_app/core/materials/domain/repos/lessons_repo.dart';
import 'package:atm_app/core/materials/domain/repos/subjects_repo.dart';
import 'package:atm_app/core/materials/domain/repos/versions_repo.dart';
import 'package:atm_app/core/services/background_services.dart';
import 'package:atm_app/core/services/data_base.dart';
import 'package:atm_app/core/services/delete_items_service.dart';
import 'package:atm_app/core/services/file_cach_manager.dart';
import 'package:atm_app/core/services/isar_storage_service.dart';
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
import 'package:atm_app/core/shared_features/exams/domain/repos/exam_sections_repo.dart';
import 'package:atm_app/core/shared_features/exams/domain/repos/exams_repo.dart';
import 'package:atm_app/core/shared_features/exams/domain/repos/question_repo.dart';
import 'package:atm_app/features/admin/exams/data/data_source/exam_sections_data_source/admin_exam_sections_local_data_source_impl.dart';
import 'package:atm_app/features/admin/exams/data/data_source/exam_sections_data_source/admin_exam_sections_remote_data_source_impl.dart';
import 'package:atm_app/features/admin/exams/data/data_source/exams_data_source/admin_exams_local_data_source_impl.dart';
import 'package:atm_app/features/admin/exams/data/data_source/exams_data_source/admin_exams_remote_data_source_impl.dart';
import 'package:atm_app/features/admin/exams/data/data_source/questions_data_source/admin_questions_local_data_source_impl.dart';
import 'package:atm_app/features/admin/exams/data/data_source/questions_data_source/admin_questions_remote_data_source_impl.dart';
import 'package:atm_app/features/admin/exams/data/repos/admin_exam_repo_impl.dart';
import 'package:atm_app/features/admin/exams/data/repos/admin_exam_sections_repo_impl.dart';
import 'package:atm_app/features/admin/exams/data/repos/admin_question_repo_impl.dart';
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

import '../../features/admin/materials/data/data_source/admin_lessons_data_source/admin_lessons_remote_data_source.dart';
import '../../features/admin/materials/data/data_source/admin_subjects_data_source.dart/admin_subjects_remote_data_source.dart';
import '../../features/student/materials/data/repos/student_lessons_repo_impl.dart';
import '../../features/student/materials/data/repos/student_subjects_repo_impl.dart';
import '../../features/student/materials/data/repos/student_versions_repo_impl.dart';

final getit = GetIt.instance;
setUpCoreServiceLocator() {
  getit.registerSingleton<StorageService>(SupaBaseStorage());
  getit.registerSingleton<DataBase>(SupabaseDb());
  getit
      .registerSingleton<ProfileStorage>(ProfileStorageImpl())
      .loadUserProfile();
  getit.registerSingleton<AuthRepo>(
    AuthRepoImpl(
        authServices: SupabaseAuthService(),
        dataBase: SupabaseDb(),
        profileStorage: getit.get<ProfileStorage>()),
  );
  getit.registerSingleton<IsarStorageService>(IsarStorageService());
  getit.registerSingleton<RealtimeSyncService>(RealtimeSyncService());
}

setUpServiceLocator({required UserRole userRole}) {
  void registerIfNotExists<T extends Object>(T instance) {
    if (!getit.isRegistered<T>()) {
      getit.registerSingleton<T>(instance);
    }
  }

  registerIfNotExists<FileCacheManager>(FileSystemCacheManager());

  registerIfNotExists<BackgroundServices<LessonEntity>>(
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

  registerIfNotExists<BackgroundServices<SubjectsEntity>>(
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

  registerIfNotExists<BackgroundServices<AynaaVersionsEntity>>(
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
      registerIfNotExists<VersionsLocalDataSource>(
        AdminVersionsLocalDataSourceImpl(
          isarStorageService: getit.get<IsarStorageService>(),
        ),
      );
      registerIfNotExists<SubjectsLocalDataSource>(
        AdminSubjectsLocalDataSourceImpl(
          isarStorageService: getit.get<IsarStorageService>(),
        ),
      );
      registerIfNotExists<LessonsLocalDataSource>(
        AdminLessonsLocalDataSourceImpl(
          isarStorageService: getit.get<IsarStorageService>(),
        ),
      );
      registerIfNotExists<ExamsLocalDataSource>(
        AdminExamsLocalDataSourceImpl(),
      );
      registerIfNotExists<ExamSectionsLocalDataSource>(
        AdminExamSectionsLocalDataSourceImpl(),
      );
      registerIfNotExists<QuestionsLocalDataSource>(
        AdminQuestionsLocalDataSourceImpl(),
      );
      registerIfNotExists<AynaaVersionsRemoteDataSource>(
        AdminVersionsRemoteDataSourceImpl(
          dataBase: getit.get<DataBase>(),
          isarStorageService: getit.get<IsarStorageService>(),
        ),
      );
      registerIfNotExists<SubjectsRemoteDataSource>(
        AdminSubjectsRemoteDataSourceImpl(
          dataBase: getit.get<DataBase>(),
          isarStorageService: getit.get<IsarStorageService>(),
        ),
      );
      registerIfNotExists<LessonsRemoteDataSource>(
        LessonsRemoteDataSourceImpl(
          dataBase: getit.get<DataBase>(),
          isarStorageService: getit.get<IsarStorageService>(),
          storageService: getit.get<StorageService>(),
          fileCacheManager: getit.get<FileCacheManager>(),
        ),
      );
      registerIfNotExists<ExamsRemoteDataSource>(
        AdminExamsRemoteDataSourceImpl(
          dataBase: getit.get<DataBase>(),
          isarStorageService: getit.get<IsarStorageService>(),
        ),
      );
      registerIfNotExists<ExamSectionsRemoteDataSource>(
        AdminExamSectionsRemoteDataSourceImpl(
          dataBase: getit.get<DataBase>(),
          isarStorageService: getit.get<IsarStorageService>(),
        ),
      );
      registerIfNotExists<QuestionsRemoteDataSource>(
        AdminQuestionsRemoteDataSourceImpl(
          dataBase: getit.get<DataBase>(),
          isarStorageService: getit.get<IsarStorageService>(),
        ),
      );

      registerIfNotExists<VersionsRepo>(
        AdminVersionsRepoImpl(
          dataBase: getit.get<DataBase>(),
          storageService: getit.get<StorageService>(),
          remoteDataSource: getit.get<AynaaVersionsRemoteDataSource>(),
          versionsLocalDataSource: getit.get<VersionsLocalDataSource>(),
          backgroundServices:
              getit.get<BackgroundServices<AynaaVersionsEntity>>(),
        ),
      );
      registerIfNotExists<SubjectsRepo>(
        AdminSubjectsRepoImpl(
          dataBase: getit.get<DataBase>(),
          storageService: getit.get<StorageService>(),
          subjectsRemoteDataSource: getit.get<SubjectsRemoteDataSource>(),
          subjectsLocalDataSource: getit.get<SubjectsLocalDataSource>(),
          backgroundDownloadService:
              getit.get<BackgroundServices<SubjectsEntity>>(),
        ),
      );
      registerIfNotExists<LessonsRepo>(
        AdminLessonsRepoImpl(
            dataBase: getit.get<DataBase>(),
            storageService: getit.get<StorageService>(),
            lessonsRemoteDataSource: getit.get<LessonsRemoteDataSource>(),
            lessonsLocalDataSource: getit.get<LessonsLocalDataSource>()),
      );
      registerIfNotExists<ExamsRepo>(
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
      );

      break;
    case UserRole.student:
      registerIfNotExists<VersionsLocalDataSource>(
        StudentVersionsLocalDataSourceImpl(
          isarStorageService: getit.get<IsarStorageService>(),
        ),
      );
      registerIfNotExists<SubjectsLocalDataSource>(
        StudentSubjectsLocalDataSourceImpl(
          isarStorageService: getit.get<IsarStorageService>(),
        ),
      );
      registerIfNotExists<LessonsLocalDataSource>(
        StudentLessonsLocalDataSourceImpl(
          isarStorageService: getit.get<IsarStorageService>(),
        ),
      );
      registerIfNotExists<AynaaVersionsRemoteDataSource>(
        StudentVersionsRemoteDataSourceImpl(
          dataBase: getit.get<DataBase>(),
          isarStorageService: getit.get<IsarStorageService>(),
        ),
      );
      registerIfNotExists<SubjectsRemoteDataSource>(
        StudentSubjectsRemoteDataSourceImpl(
          dataBase: getit.get<DataBase>(),
          isarStorageService: getit.get<IsarStorageService>(),
        ),
      );
      registerIfNotExists<LessonsRemoteDataSource>(
        StudentLessonsRemoteDataSourceImpl(
          dataBase: getit.get<DataBase>(),
          isarStorageService: getit.get<IsarStorageService>(),
          storageService: getit.get<StorageService>(),
          fileCacheManager: getit.get<FileCacheManager>(),
        ),
      );

      registerIfNotExists<VersionsRepo>(
        StudentVersionsRepoImpl(
          dataBase: getit.get<DataBase>(),
          storageService: getit.get<StorageService>(),
          remoteDataSource: getit.get<AynaaVersionsRemoteDataSource>(),
          versionsLocalDataSource: getit.get<VersionsLocalDataSource>(),
          backgroundServices:
              getit.get<BackgroundServices<AynaaVersionsEntity>>(),
        ),
      );
      registerIfNotExists<SubjectsRepo>(
        StudentSubjectsRepoImpl(
          dataBase: getit.get<DataBase>(),
          storageService: getit.get<StorageService>(),
          subjectsRemoteDataSource: getit.get<SubjectsRemoteDataSource>(),
          subjectsLocalDataSource: getit.get<SubjectsLocalDataSource>(),
          backgroundDownloadService:
              getit.get<BackgroundServices<SubjectsEntity>>(),
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
  registerIfNotExists<DeleteItemsService>(
    DeleteItemsServiceImpl(
      dataBase: getit.get<DataBase>(),
      storageService: getit.get<StorageService>(),
      isarStorageService: getit.get<IsarStorageService>(),
    ),
  );
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
