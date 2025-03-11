import 'package:atm_app/core/const/remote_db_const.dart';
import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/services/profile_storage.dart';
import 'package:atm_app/core/utils/app_route.dart';
import 'package:atm_app/core/utils/set_up_service_locator.dart';
import 'package:atm_app/features/auth/domain/repos/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashViewBody(),
    );
  }
}

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getInitialRoute();
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Aynaa App',
        style: TextStyle(
          fontSize: 50,
          color: Colors.blue,
        ),
      ),
    );
  }

  void _getInitialRoute() async {
    final authService = getit.get<AuthRepo>();
    final roleStorage = getit.get<ProfileStorage>();

    // Check if user is already logged in
    Future.delayed(const Duration(seconds: 3), () async {
      if (authService.isLoggedIn()) {
        final userRole = await roleStorage.getCachedRole();
        if (userRole != null) {
          if (userRole == kAdminRole) {
            await setUpServiceLocator(userRole: UserRole.admin);
            return _roleBasedHomeScreen(UserRole.admin);
          } else {
            await setUpServiceLocator(userRole: UserRole.student);
            return _roleBasedHomeScreen(UserRole.student);
          }
        }
      }

      // Show authentication flow for new/unauthenticated users
      if (!mounted) return;
      context.pushReplacement(AppRouter.signInView);
    });
  }

  void _roleBasedHomeScreen(UserRole role) {
    switch (role) {
      case UserRole.admin:
        context.pushReplacement(AppRouter.adminNavBarView);

      case UserRole.student:
        context.pushReplacement(AppRouter.adminNavBarView);
    }
  }
}
