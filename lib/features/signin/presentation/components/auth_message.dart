import 'package:cornerstone_app/features/signin/presentation/states/signin_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AuthMessage extends StatelessWidget {
  final AuthState state;

  const AuthMessage({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    if (state is AuthError) {
      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Color.fromARGB(255, 199, 5, 41),
          ),
          padding: const EdgeInsets.all(8),
          child: Text(
            (state as AuthError).message,
            key: const ValueKey('error'),
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
