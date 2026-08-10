import 'package:flutter/material.dart';

import '../../../../core/widgets/uog_card.dart';
import '../../../../core/design/app_spacing.dart';
import '../../../../core/design/app_text_styles.dart';


class DashboardSessions extends StatelessWidget {
  const DashboardSessions({
    super.key,
  });


  @override
  Widget build(BuildContext context) {

    return UOGCard(
      child: Padding(
        padding: const EdgeInsets.all(
          AppSpacing.md,
        ),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            const Text(
              'سانس‌های امروز',
              style: AppTextStyles.headline,
            ),


            const SizedBox(
              height: 16,
            ),


            const Center(
              child: Text(
                'هنوز سانسی ثبت نشده است.',
                style: AppTextStyles.body,
              ),
            ),

          ],
        ),
      ),
    );
  }
}