import 'package:cornerstone_app/features/signin/presentation/components/animated_formfield.dart';
import 'package:cornerstone_app/features/signin/presentation/components/animated_logo.dart';
import 'package:cornerstone_app/features/signin/presentation/components/auth_message.dart';
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
    emailController.text = "2024003178";
    passwordController.text = "qIaBpKI8";
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

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AnimatedLogo(),
                const SizedBox(height: 24),

                Text(
                  'Student Portal'.tr(),
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),

                AnimatedFormField(
                  index: 0,
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person),
                      labelText: 'User ID'.tr(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                AnimatedFormField(
                  index: 1,
                  child: TextField(
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
                ),
                const SizedBox(height: 24),

                AnimatedFormField(
                  index: 2,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: isLoading
                        ? const CircularProgressIndicator()
                        : SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.login),
                              label: Text('Enter'.tr()),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: _login,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 16),

                AuthMessage(state: state),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
