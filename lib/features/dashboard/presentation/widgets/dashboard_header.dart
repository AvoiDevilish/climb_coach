import 'package:flutter/material.dart';

import '../../../../core/design/app_text_styles.dart';
import '../../../../core/utils/date_helper.dart';


class DashboardHeader extends StatelessWidget {
  const DashboardHeader({
    super.key,
  });


  @override
  Widget build(BuildContext context) {

    final now = DateTime.now();

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [

        Text(
          DateHelper.weekDayName(now),
          style: AppTextStyles.body,
        ),

        const SizedBox(
          height: 4,
        ),

        Text(
          DateHelper.persianDate(now),
          style: AppTextStyles.body,
        ),

      ],
    );
  }
}