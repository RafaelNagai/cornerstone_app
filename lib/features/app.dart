import 'package:cornerstone_app/core/routes/route_manager.dart';
import 'package:cornerstone_app/core/theme/ciccc_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CornerStoneApp extends StatelessWidget {
  const CornerStoneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: routerConfiguration,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: AppTheme.light,
    );
  }
}
