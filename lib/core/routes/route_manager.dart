import 'package:cornerstone_app/features/signin/presentation/signin_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter routerConfiguration = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => SignInPage()),
    GoRoute(path: '/details', builder: (context, state) => SignInPage()),
  ],
);
