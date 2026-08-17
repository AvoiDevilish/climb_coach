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

  String _measurementLabel() {
    switch (movement.measurementType) {
      case 'reps':
        return 'تکرار';

      case 'time':
        return 'زمان';

      case 'weight':
        return 'وزن';

      case 'distance':
        return 'مسافت';

      case 'angle':
        return 'زاویه';

      default:
        return movement.measurementUnit;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(Icons.fitness_center),
        ),

        title: Text(
          movement.name,
        ),

        subtitle: Text(
          '${movement.bodyRegion} • '
          '${_measurementLabel()} '
          '(${movement.measurementUnit})',
        ),

        trailing: const Icon(
          Icons.chevron_right,
        ),

        onTap: onTap,
      ),
    );
  }
}