import 'package:flutter/material.dart';
import 'routes.dart';
import 'theme.dart';

class ClimbCoachApp extends StatelessWidget {
  const ClimbCoachApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Climb Coach',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: '/',
      routes: AppRoutes.routes,
    );
  }
}
