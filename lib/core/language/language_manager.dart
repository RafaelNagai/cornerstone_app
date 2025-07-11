import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LanguageManager extends StatelessWidget {
  final Widget child;

  const LanguageManager({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: [Locale('en'), Locale('pt')],
      path: 'assets/languages',
      startLocale: Locale('en'),
      fallbackLocale: Locale('en'),
      child: child,
    );
  }
}
