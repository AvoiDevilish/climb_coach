import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'routes.dart';
import 'theme.dart';

class ClimbCoachApp extends StatelessWidget {
  const ClimbCoachApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eye Club',

      debugShowCheckedModeBanner: false,

      theme: AppTheme.light,

      locale: const Locale('fa'),

      supportedLocales: const [
        Locale('fa'),
      ],

      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child ?? const SizedBox.shrink(),
        );
      },

      initialRoute: '/',

      routes: AppRoutes.routes,
    );
  }
}