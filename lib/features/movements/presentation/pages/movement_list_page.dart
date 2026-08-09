import 'package:flutter/material.dart';

import '../../domain/models/movement_category.dart';

class MovementListPage extends StatelessWidget {
  const MovementListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final category =
        ModalRoute.of(context)!.settings.arguments
            as MovementCategory;

    return Scaffold(
      appBar: AppBar(
        title: Text(category.title),
      ),
      body: Center(
        child: Text(
          "دسته: ${category.title}",
          style: const TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}