import 'package:flutter/material.dart';

import '../../../domain/models/athlete.dart';
import '../../../../../core/utils/number_helper.dart';

class AthleteInfoCard extends StatelessWidget {
  final Athlete athlete;

  const AthleteInfoCard({
    super.key,
    required this.athlete,
  });

  String persianNumber(
    String value,
  ) {
    return NumberHelper.toPersian(
      value,
    );
  }

  String valueOrDash(
    String? value,
  ) {
    if (value == null ||
        value.trim().isEmpty) {
      return '-';
    }

    return persianNumber(value);
  }

  Widget buildRow(
    String title,
    String value,
  ) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(
        vertical: 7,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child: Text(
              title,
              style:
                  const TextStyle(
                fontWeight:
                    FontWeight.bold,
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
  Widget build(
    BuildContext context,
  ) {
    return Card(
      child: Padding(
        padding:
            const EdgeInsets.all(16),
        child: Column(
          children: [
            buildRow(
              'نام',
              athlete.firstName,
            ),

            buildRow(
              'نام خانوادگی',
              athlete.lastName,
            ),

            buildRow(
              'سن',
              athlete.age == null
                  ? '-'
                  : persianNumber(
                      athlete.age!
                          .toString(),
                    ),
            ),

            buildRow(
              'قد',
              athlete.height == null
                  ? '-'
                  : '${valueOrDash(athlete.height!.toString())} سانتی‌متر',
            ),

            buildRow(
              'وزن',
              athlete.weight == null
                  ? '-'
                  : '${valueOrDash(athlete.weight!.toString())} کیلوگرم',
            ),

            buildRow(
              'جنسیت',
              athlete.gender ?? '-',
            ),
          ],
        ),
      ),
    );
  }
}