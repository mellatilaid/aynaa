import 'package:atm_app/features/admin/admin_bottom_nav_view.dart';
import 'package:atm_app/features/auth/presentation/views/sign_in_view.dart';
import 'package:go_router/go_router.dart';

import '../../features/admin/posts/presentation/views/home_view.dart';
import '../../features/student/student_view.dart';

abstract class AppRouter {
  static const String studentHomeView = '/student';
  static const String adminHomeView = '/home';
  static const String adminNavBarView = '/adminNavBar';
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
          routes: [
            GoRoute(
              path: adminHomeView,
              builder: (context, state) => const HomeView(),
            ),
          ]),
    ],
  );
}
