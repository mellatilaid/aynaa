import 'package:atm_app/core/classes/pick_file.dart';
import 'package:atm_app/core/services/data_base.dart';
import 'package:atm_app/core/services/storage_service.dart';
import 'package:atm_app/core/services/supa_base_storage.dart';
import 'package:atm_app/core/services/supabase_DB.dart';
import 'package:atm_app/core/services/supabase_auth_service.dart';
import 'package:atm_app/features/admin/materials/data/data_source/aynaa_versions_data_source.dart/aynaa_versions_remote_data_sourse.dart';
import 'package:atm_app/features/admin/materials/data/data_source/lessons_data_source/lessons_remote_data_source.dart';
import 'package:atm_app/features/admin/materials/data/data_source/subjects_data_source.dart/subjects_remote_data_source.dart';
import 'package:atm_app/features/admin/materials/data/repos/lessons_repo_impl.dart';
import 'package:atm_app/features/admin/materials/data/repos/materials_repo_impl.dart';
import 'package:atm_app/features/admin/materials/data/repos/subjects_repo_impl.dart';
import 'package:atm_app/features/admin/materials/domain/repos/lessons_repo.dart';
import 'package:atm_app/features/admin/materials/domain/repos/materials_repo.dart';
import 'package:atm_app/features/admin/materials/domain/repos/subjects_repo.dart';
import 'package:atm_app/features/auth/data/repos/auth_repo_impl.dart';
import 'package:atm_app/features/auth/domain/repos/auth_repo.dart';
import 'package:get_it/get_it.dart';

final getit = GetIt.instance;

setUpServiceLocator() {
  getit.registerSingleton<AuthRepo>(AuthRepoImpl(
      authServices: SupabaseAuthService(), dataBase: SupabaseDb()));
  getit.registerSingleton<DataBase>(SupabaseDb());
  getit.registerSingleton<StorageService>(SupaBaseStorage());
  getit.registerSingleton<MaterialsRepo>(
    MaterialsRepoImpl(
      dataBase: getit.get<DataBase>(),
      AynaaVersionsRemoteDataSourceImpl(
        dataBase: getit.get<DataBase>(),
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
      lessonsRemoteDataSource: LessonsRemoteDataSourceImpl(
        dataBase: getit.get<DataBase>(),
      ),
    ),
  );
  getit.registerSingleton<FilePickerHelper>(FilePickerHelper());
}
