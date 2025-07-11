import 'package:cornerstone_app/core/language/language_manager.dart';
import 'package:cornerstone_app/features/app.dart' show CornerStoneApp;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(LanguageManager(child: CornerStoneApp()));
}
