import 'package:cornerstone_app/features/login/presentation/login_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter routerConfiguration = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => LoginPage()),
    GoRoute(path: '/details', builder: (context, state) => LoginPage()),
  ],
);
