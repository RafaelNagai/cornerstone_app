import 'package:cornerstone_app/core/http/dio_manager.dart';
import 'package:cornerstone_app/features/signin/presentation/providers/signin_provider.dart';
import 'package:cornerstone_app/features/signin/presentation/states/signin_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  @override
  ConsumerState<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await DioManager().init();
      final notifier = ref.read(authProvider.notifier);
      final isLoggedIn = await notifier.autoLogin();
      if (isLoggedIn) {
        context.go('/student');
      }
    });
    emailController.text = "2024003178";
    passwordController.text = "zrvIYrhZ";
  }

  void _login() async {
    final notifier = ref.read(authProvider.notifier);
    await notifier.signIn(emailController.text, passwordController.text).then((
      _,
    ) {
      final state = ref.read(authProvider);
      if (state is AuthSuccess) {
        context.go('/student');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authProvider);
    final isLoading = state is AuthLoading;
    final hasError = state is AuthError;

    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo ou imagem ilustrativa
                Image.asset(
                  'assets/images/login_illustration.png',
                  height: 180,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 24),

                Text(
                  'Login'.tr(),
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),

                // User ID
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person),
                    labelText: 'User ID'.tr(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Password
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    labelText: 'Password'.tr(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.login),
                            label: Text(
                              'Entrar',
                              style: const TextStyle(fontSize: 16),
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: _login,
                          ),
                        ),
                ),

                const SizedBox(height: 16),

                // Mensagem de erro ou sucesso
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: hasError
                      ? Text(
                          (state).message,
                          key: const ValueKey('error'),
                          style: const TextStyle(color: Colors.red),
                        )
                      : state is AuthSuccess
                      ? Text(
                          'hello'.tr(),
                          key: const ValueKey('success'),
                          style: const TextStyle(color: Colors.green),
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
