import 'package:flutter/material.dart';

import '../../../../core/design/app_text_styles.dart';
import '../../../../core/design/app_spacing.dart';


class SessionDayHeader extends StatelessWidget {

  final String weekDay;
  final String date;


  const SessionDayHeader({
    super.key,
    required this.weekDay,
    required this.date,
  });


  @override
  Widget build(BuildContext context) {

    return Padding(

      padding: const EdgeInsets.only(
        bottom: AppSpacing.md,
      ),

      child: Row(

        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,

        children: [

          Text(
            weekDay,
            style: AppTextStyles.headline,
          ),


          Text(
            date,
            style: AppTextStyles.body,
          ),

        ],
      ),

    );

  }
}