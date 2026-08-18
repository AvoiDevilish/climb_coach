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

    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
      crossAxisAlignment:
          CrossAxisAlignment.center,
      children: [
        Text(
          DateHelper.weekDayName(now),
          style: AppTextStyles.body.copyWith(
            fontSize: 13,
          ),
        ),

        Text(
          DateHelper.persianDate(now),
          style: AppTextStyles.body.copyWith(
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}