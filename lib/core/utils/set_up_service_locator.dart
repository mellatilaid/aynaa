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
import 'package:atm_app/features/admin/materials/data/data_source/lessons_data_source/lessons_remote_data_source.dart';
import 'package:atm_app/features/admin/materials/data/data_source/subjects_data_source.dart/subjects_remote_data_source.dart';
import 'package:atm_app/features/admin/materials/data/repos/lessons_repo_impl.dart';
import 'package:atm_app/features/admin/materials/data/repos/subjects_repo_impl.dart';
import 'package:atm_app/features/admin/materials/domain/entities/aynaa_versions_entity.dart';
import 'package:atm_app/features/admin/materials/domain/repos/lessons_repo.dart';
import 'package:atm_app/features/admin/materials/domain/repos/subjects_repo.dart';
import 'package:atm_app/features/admin/materials/domain/repos/versions_repo.dart';
import 'package:atm_app/features/auth/data/repos/auth_repo_impl.dart';
import 'package:atm_app/features/auth/domain/repos/auth_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../features/admin/materials/data/repos/versions_repo_impl.dart';

final getit = GetIt.instance;

setUpServiceLocator() {
  getit.registerSingleton<AuthRepo>(AuthRepoImpl(
      authServices: SupabaseAuthService(), dataBase: SupabaseDb()));
  getit.registerSingleton<DataBase>(SupabaseDb());
  getit.registerSingleton<StorageService>(SupaBaseStorage());
  getit.registerFactory<HiveCache<AynaaVersionsEntity>>(
      () => BaseHiveCache<AynaaVersionsEntity>());
  getit.registerFactoryParam<BaseHiveCache<HiveObject>, String, void>(
    (typeName, _) => BaseHiveCache<HiveObject>(),
  );
  getit.registerSingleton<VersionsRepo>(
    VersionsRepoImpl(
      dataBase: getit.get<DataBase>(),
      storageService: getit.get<StorageService>(),
      AynaaVersionsRemoteDataSourceImpl(
        dataBase: getit.get<DataBase>(),
        hiveCache: getit.get<HiveCache<AynaaVersionsEntity>>(),
      ),
      versionsLocalDataSource: VersionsLocalDataSourceImpl(
        hiveCache: getit.get<HiveCache<AynaaVersionsEntity>>(),
      ),
    ),
  );
  getit.registerSingleton<SubjectsRepo>(
    SubjectsRepoImpl(
      dataBase: getit.get<DataBase>(),
      subjectsRemoteDataSource: subjectsRemoteDataSourceImpl(
        dataBase: getit.get<DataBase>(),
      ),
    ),
  );
  getit.registerSingleton<LessonsRepo>(
    LessonsRepoImpl(
      dataBase: getit.get<DataBase>(),
      storageService: getit.get<StorageService>(),
      lessonsRemoteDataSource: LessonsRemoteDataSourceImpl(
        dataBase: getit.get<DataBase>(),
      ),
    ),
  );
  getit.registerSingleton<FilePickerHelper>(FilePickerHelper());
}
