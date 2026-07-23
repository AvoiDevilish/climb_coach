import 'package:flutter/material.dart';

class ClimbCoachApp extends StatelessWidget {
  const ClimbCoachApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Climb Coach',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
        ),
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Center(
          child: Text(
            'Climb Coach Started',
          ),
        ),
      ),
    );
  }
}