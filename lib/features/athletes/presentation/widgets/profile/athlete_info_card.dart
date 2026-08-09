import 'package:flutter/material.dart';

import '../../../domain/models/athlete.dart';

class AthleteInfoCard extends StatelessWidget {

  final Athlete athlete;

  const AthleteInfoCard({
    super.key,
    required this.athlete,
  });

  Widget buildRow(
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),

      child: Row(
        children: [

          SizedBox(
            width: 90,
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Expanded(
            child: Text(value),
          ),

        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Card(

      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(

          children: [

            buildRow(
              "نام",
              athlete.firstName,
            ),

            buildRow(
              "نام خانوادگی",
              athlete.lastName,
            ),

            buildRow(
              "سن",
              athlete.age?.toString() ?? "-",
            ),

            buildRow(
              "قد",
              athlete.height?.toString() ?? "-",
            ),

            buildRow(
              "وزن",
              athlete.weight?.toString() ?? "-",
            ),

            buildRow(
              "جنسیت",
              athlete.gender ?? "-",
            ),

          ],
        ),
      ),
    );
  }
}