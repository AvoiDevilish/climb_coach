import 'package:flutter/material.dart';

import '../../domain/models/assessment.dart';

class AssessmentDetailPage extends StatelessWidget {

  const AssessmentDetailPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final assessment =

        ModalRoute.of(context)!
            .settings
            .arguments as Assessment;

    return Scaffold(

      appBar: AppBar(
        title: Text(
          assessment.title,
        ),
      ),

      body: Center(

        child: Text(

          assessment.description,

          textAlign: TextAlign.center,

        ),

      ),

    );

  }

}