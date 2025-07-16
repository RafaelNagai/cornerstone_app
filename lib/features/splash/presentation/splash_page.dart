import 'package:cornerstone_app/core/http/dio_manager.dart';
import 'package:cornerstone_app/features/signin/presentation/providers/signin_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AppSplashPage extends ConsumerStatefulWidget {
  const AppSplashPage({super.key});

  @override
  ConsumerState<AppSplashPage> createState() => _AppSplashPageState();
}

class _AppSplashPageState extends ConsumerState<AppSplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true); // anima vai e volta

    _animation = Tween<double>(
      begin: 0.95,
      end: 1.05,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await DioManager().init();
      final notifier = ref.read(authProvider.notifier);
      final isLoggedIn = await notifier.autoLogin();

      await Future.delayed(const Duration(seconds: 1)); // tempo pra animação
      if (mounted) {
        context.go(isLoggedIn ? '/student' : '/signin');
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // sempre dispose do controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF002855),
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child: Image.asset(
            'assets/images/logo_12.png',
            width: 280,
            height: 280,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
