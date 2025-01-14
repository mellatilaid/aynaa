import 'package:atm_app/features/admin/admin_bottom_nav_view.dart';
import 'package:atm_app/features/admin/materials/domain/entities/aynaa_versions_entity.dart';
import 'package:atm_app/features/admin/materials/presentation/views/subjects_view.dart';
import 'package:atm_app/features/auth/presentation/views/sign_in_view.dart';
import 'package:go_router/go_router.dart';

import '../../features/student/student_view.dart';

abstract class AdminAppRouter {
  static const String adminHomeView = '/home';
  static const String adminNavBarView = '/adminNavBar';
  static const String versionSubjectsView = '/versionSubjects';
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const AdminBottomNavView(),
      ),
      GoRoute(
        path: versionSubjectsView,
        builder: (context, state) {
          final data = state.extra as AynaaVersionsEntity;
          return SubjectsView(
            aynaaVersionsEntity: data,
          );
        },
      ),
    ],
  );
}

abstract class StudentAppRouter {
  static const String studentHomeView = '/student';

  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: studentHomeView,
        builder: (context, state) => const SignInView(),
      ),
      GoRoute(
        path: studentHomeView,
        builder: (context, state) => const StudentView(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const AdminBottomNavView(),
      ),
    ],
  );
}
