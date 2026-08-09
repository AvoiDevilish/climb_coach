import 'package:flutter/material.dart';

import '../../domain/models/assessment.dart';
import '../controllers/assessment_controller.dart';
import '../widgets/assessment_tile.dart';

class AssessmentBrowserPage extends StatefulWidget {
  const AssessmentBrowserPage({super.key});

  @override
  State<AssessmentBrowserPage> createState() =>
      _AssessmentBrowserPageState();
}

class _AssessmentBrowserPageState
    extends State<AssessmentBrowserPage> {

  final AssessmentController controller =
      AssessmentController();

  void showMessage(String message) {

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );

  }

  @override
  Widget build(BuildContext context) {

    final List<Assessment> assessments =
        controller.assessments;

    return Scaffold(

      appBar: AppBar(
        title: const Text("آزمون‌ها"),
      ),

      body: assessments.isEmpty

          ? const Center(
              child: Text(
                "هنوز آزمونی تعریف نشده است.",
              ),
            )

          : ListView.builder(

              padding: const EdgeInsets.all(16),

              itemCount: assessments.length,

              itemBuilder: (context, index) {

                final assessment =
                    assessments[index];

                return Padding(

                  padding:
                      const EdgeInsets.only(bottom: 12),

                  child: AssessmentTile(

                    assessment: assessment,

                    onTap: () {

                      Navigator.pushNamed(

                        context,

                        "/assessment/detail",

                        arguments: assessment,

                      );

                    },

                  ),

                );

              },

            ),

      floatingActionButton:
          FloatingActionButton(

            onPressed: () {

              showMessage(
                "ساخت آزمون در Sprint بعدی اضافه می‌شود.",
              );

            },

            child: const Icon(
              Icons.add,
            ),

          ),

    );

  }

}