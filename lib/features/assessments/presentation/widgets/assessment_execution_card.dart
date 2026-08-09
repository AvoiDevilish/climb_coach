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

  @override
  Widget build(BuildContext context) {
    final movement = executionItem.movement;

    return Card(
      elevation: 3,

      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Text(
              movement.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "نوع ثبت: ${movement.recordType}",
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 30),

            TextField(
              controller: controller,
              keyboardType: TextInputType.number,

              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: movement.unit,
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,

              child: FilledButton(
                onPressed: onNext,

                child: const Text(
                  "ثبت و ادامه",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}