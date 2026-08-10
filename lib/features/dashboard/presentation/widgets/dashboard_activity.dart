import 'package:flutter/material.dart';

import '../../../../core/widgets/uog_card.dart';
import '../../../../core/design/app_spacing.dart';
import '../../../../core/design/app_text_styles.dart';

class DashboardActivity extends StatelessWidget {
  const DashboardActivity({
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
              'آخرین فعالیت‌ها',
              style: AppTextStyles.headline,
            ),

            const SizedBox(height: 16),

            const Text(
              'هنوز فعالیتی ثبت نشده است.',
              style: AppTextStyles.body,
            ),

          ],
        ),
      ),
    );
  }
}