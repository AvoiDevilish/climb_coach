import 'package:flutter/material.dart';

class AssessmentExecutionPage extends StatelessWidget {
  const AssessmentExecutionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("اجرای آزمون"),
      ),
      body: const Center(
        child: Text(
          "Assessment Execution",
        ),
      ),
    );
  }
}