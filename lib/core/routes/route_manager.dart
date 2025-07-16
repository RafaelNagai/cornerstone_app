import 'package:cornerstone_app/features/signin/presentation/signin_page.dart';
import 'package:cornerstone_app/features/splash/presentation/splash_page.dart';
import 'package:cornerstone_app/features/student/presentation/student_board_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter routerConfiguration = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => AppSplashPage()),
    GoRoute(path: '/signin', builder: (context, state) => SignInPage()),
    GoRoute(path: '/student', builder: (context, state) => StudentBoardPage()),
  ],
);
