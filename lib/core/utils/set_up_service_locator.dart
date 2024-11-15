import 'package:atm_app/core/services/supabase_DB.dart';
import 'package:atm_app/core/services/supabase_auth_service.dart';
import 'package:atm_app/features/auth/data/repos/auth_repo_impl.dart';
import 'package:atm_app/features/auth/domain/repos/auth_repo.dart';
import 'package:get_it/get_it.dart';

final getit = GetIt.instance;

setUpServiceLocator() {
  getit.registerSingleton<AuthRepo>(AuthRepoImpl(
      authServices: SupabaseAuthService(), dataBase: SupabaseDb()));
}
