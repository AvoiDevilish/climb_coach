import 'package:flutter/material.dart';

import '../models/assessment_execution_item.dart';

class AssessmentExecutionCard extends StatelessWidget {
  final AssessmentExecutionItem executionItem;

  final TextEditingController controller;

  final VoidCallback onNext;

  const AssessmentExecutionCard({
    super.key,
    required this.executionItem,
    required this.controller,
    required this.onNext,
  });

  String _measurementLabel(String type) {
    switch (type) {
      case 'reps':
        return 'تعداد تکرار';

      case 'time':
        return 'زمان';

      case 'weight':
        return 'وزن';

      case 'distance':
        return 'مسافت';

      case 'angle':
        return 'زاویه';

      default:
        return 'مقدار';
    }
  }

  @override
  Widget build(BuildContext context) {
    final movement = executionItem.movement;

    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              movement.name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              movement.bodyRegion,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'عضلات اصلی: '
              '${movement.primaryMuscles.join('، ')}',
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              'معیار ثبت: '
              '${_measurementLabel(movement.measurementType)}',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 30),

            TextField(
              controller: controller,
              keyboardType:
                  const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                border:
                    const OutlineInputBorder(),
                labelText:
                    movement.measurementUnit,
                suffixText:
                    movement.measurementUnit,
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: onNext,
                child: const Text(
                  'ثبت و ادامه',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}