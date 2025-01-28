import 'package:atm_app/core/classes/pick_file.dart';
import 'package:atm_app/core/services/data_base.dart';
import 'package:atm_app/core/services/hive_base_impl.dart';
import 'package:atm_app/core/services/hive_service.dart';
import 'package:atm_app/core/services/storage_service.dart';
import 'package:atm_app/core/services/supa_base_storage.dart';
import 'package:atm_app/core/services/supabase_DB.dart';
import 'package:atm_app/core/services/supabase_auth_service.dart';
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

final getit = GetIt.instance;

setUpServiceLocator() {
  getit.registerSingleton<AuthRepo>(AuthRepoImpl(
      authServices: SupabaseAuthService(), dataBase: SupabaseDb()));
  getit.registerSingleton<DataBase>(SupabaseDb());
  getit.registerSingleton<StorageService>(SupaBaseStorage());
  getit.registerSingleton<HiveCache<AynaaVersionsEntity>>(BaseHiveCache());
  getit.registerSingleton<HiveCache<SubjectsEntity>>(BaseHiveCache());
  getit.registerSingleton<HiveCache<LessonEntity>>(BaseHiveCache());
  getit.registerSingleton<VersionsLocalDataSource>(
    VersionsLocalDataSourceImpl(
      hiveCache: getit.get<HiveCache<AynaaVersionsEntity>>(),
    ),
  );
  getit.registerSingleton<SubjectsLocalDataSource>(
    SubjectsLocalDataSourceImpl(
      hiveCache: getit.get<HiveCache<SubjectsEntity>>(),
    ),
  );
  getit.registerSingleton<LessonsLocalDataSource>(
    LessonsLocalDataSourceImpl(
      hiveCache: getit.get<HiveCache<LessonEntity>>(),
    ),
  );
  getit.registerSingleton<AynaaVersionsRemoteDataSource>(
      AynaaVersionsRemoteDataSourceImpl(
    dataBase: getit.get<DataBase>(),
    hiveCache: getit.get<HiveCache<AynaaVersionsEntity>>(),
  ));
  getit
      .registerSingleton<SubjectsRemoteDataSource>(SubjectsRemoteDataSourceImpl(
    dataBase: getit.get<DataBase>(),
    hiveCache: getit.get<HiveCache<SubjectsEntity>>(),
  ));
  getit.registerSingleton<LessonsRemoteDataSource>(LessonsRemoteDataSourceImpl(
    dataBase: getit.get<DataBase>(),
    hiveCache: getit.get<HiveCache<LessonEntity>>(),
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
  getit.registerSingleton<FilePickerHelper>(FilePickerHelper());
}
