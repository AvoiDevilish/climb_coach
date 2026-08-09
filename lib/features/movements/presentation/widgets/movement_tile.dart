import 'package:flutter/material.dart';

import '../../domain/models/movement.dart';

class MovementTile extends StatelessWidget {
  final Movement movement;
  final VoidCallback? onTap;

  const MovementTile({
    super.key,
    required this.movement,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,

      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(Icons.fitness_center),
        ),

        title: Text(
          movement.title,
        ),

        subtitle: Text(
          movement.unit,
        ),

        trailing: const Icon(
          Icons.chevron_right,
        ),

        onTap: onTap,
      ),
    );
  }
}