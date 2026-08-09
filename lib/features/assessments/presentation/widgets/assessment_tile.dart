import 'package:flutter/material.dart';

import '../../domain/models/assessment.dart';

class AssessmentTile extends StatelessWidget {

  final Assessment assessment;

  final VoidCallback onTap;

  const AssessmentTile({
    super.key,
    required this.assessment,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return Card(

      child: ListTile(

        leading: const Icon(
          Icons.assignment,
        ),

        title: Text(
          assessment.title,
        ),

        subtitle: Text(
          assessment.description,
        ),

        trailing: const Icon(
          Icons.chevron_right,
        ),

        onTap: onTap,

      ),

    );
  }
}