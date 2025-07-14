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
    DioManager().init();
    super.initState();
    emailController.text = "2024003178";
    passwordController.text = "zrvIYrhZ";
  }

  void _login() {
    ref
        .read(authProvider.notifier)
        .signIn(emailController.text, passwordController.text)
        .onError((error, stackTrace) {
          context.push('/');
        });
    context.push('/student');
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Login'.tr())),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'User ID'.tr()),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'.tr()),
              obscureText: true,
            ),
            SizedBox(height: 20),
            if (state is AuthLoading)
              CircularProgressIndicator()
            else
              ElevatedButton(onPressed: _login, child: Text('Entrar')),
            if (state is AuthError)
              Text(state.message, style: TextStyle(color: Colors.red)),
            if (state is AuthSuccess)
              Text('hello'.tr(), style: TextStyle(color: Colors.green)),
          ],
        ),
      ),
    );
  }
}
