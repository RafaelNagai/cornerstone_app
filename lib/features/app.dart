import 'package:cornerstone_app/core/routes/route_manager.dart';
import 'package:flutter/material.dart';

class CornerStoneApp extends StatelessWidget {
  const CornerStoneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: routerConfiguration);
  }
}
