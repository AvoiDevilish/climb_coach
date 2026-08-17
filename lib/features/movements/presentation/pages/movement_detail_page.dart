import 'package:flutter/material.dart';

import '../../domain/models/movement.dart';

class MovementDetailPage extends StatelessWidget {
  const MovementDetailPage({
    super.key,
  });

  String measurementLabel(
    String type,
  ) {
    switch (type) {
      case 'reps':
        return 'تکرار';

      case 'time':
        return 'زمان';

      case 'weight':
        return 'وزنه';

      case 'distance':
        return 'مسافت';

      case 'angle':
        return 'زاویه';

      default:
        return type;
    }
  }

  IconData measurementIcon(
    String type,
  ) {
    switch (type) {
      case 'reps':
        return Icons.repeat;

      case 'time':
        return Icons.timer_outlined;

      case 'weight':
        return Icons.fitness_center;

      case 'distance':
        return Icons.straighten;

      case 'angle':
        return Icons.architecture;

      default:
        return Icons.analytics_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final argument =
        ModalRoute.of(context)?.settings.arguments;

    if (argument is! Movement) {
      return const Scaffold(
        body: Center(
          child: Text(
            'اطلاعات حرکت قابل بارگذاری نیست',
          ),
        ),
      );
    }

    final movement = argument;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'جزئیات حرکت',
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .surfaceContainerHighest,
              borderRadius:
                  BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Icon(
                  measurementIcon(
                    movement.measurementType,
                  ),
                  size: 48,
                ),
                const SizedBox(height: 16),
                Text(
                  movement.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  movement.bodyRegion,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(
                        color:
                            Colors.grey.shade700,
                      ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            'اطلاعات حرکت',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          _InfoRow(
            label: 'نوع معیار',
            value: measurementLabel(
              movement.measurementType,
            ),
          ),

          _InfoRow(
            label: 'واحد ثبت',
            value: movement.measurementUnit,
          ),

          _InfoRow(
            label: 'ناحیه بدن',
            value: movement.bodyRegion,
          ),

          const SizedBox(height: 20),

          if (movement.primaryMuscles.isNotEmpty) ...[
            const Text(
              'عضلات اصلی درگیر',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: movement.primaryMuscles
                  .map<Widget>(
                    (muscle) => Chip(
                      label: Text(
                        muscle.toString(),
                      ),
                    ),
                  )
                  .toList(),
            ),

            const SizedBox(height: 24),
          ],

          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context)
                    .showSnackBar(
                  const SnackBar(
                    content: Text(
                      'ثبت عملکرد این حرکت در مرحله بعد اضافه می‌شود',
                    ),
                  ),
                );
              },
              icon: const Icon(
                Icons.add_chart,
              ),
              label: const Text(
                'ثبت عملکرد',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(
        bottom: 8,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 13,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}