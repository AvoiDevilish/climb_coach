import 'package:flutter/material.dart';

import '../../../../core/widgets/uog_card.dart';
import '../../../../core/design/app_text_styles.dart';
import '../../../../core/design/app_spacing.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  Widget buildCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String? route,
    bool enabled = true,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: UOGCard(
        onTap: enabled && route != null
            ? () => Navigator.pushNamed(context, route)
            : null,
        child: SizedBox(
          height: 80,
          child: Row(
            children: [
              Icon(
                icon,
                size: 34,
              ),

              const SizedBox(width: AppSpacing.md),

              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.headline,
                ),
              ),

              if (!enabled)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.orange.shade100,
                  ),
                  child: const Text(
                    "به‌زودی",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Eye Club"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: ListView(
          children: [
            buildCard(
              context: context,
              icon: Icons.people,
              title: "ورزشکاران",
              route: "/athletes",
            ),

            buildCard(
              context: context,
              icon: Icons.sports_gymnastics,
              title: "بانک حرکات",
              route: "/movements",
            ),

            buildCard(
              context: context,
              icon: Icons.fitness_center,
              title: "آزمون‌ها",
              route: "/assessments",
            ),

            buildCard(
              context: context,
              icon: Icons.bar_chart,
              title: "گزارش‌ها",
              route: null,
              enabled: false,
            ),

            buildCard(
              context: context,
              icon: Icons.settings,
              title: "تنظیمات",
              route: null,
              enabled: false,
            ),
          ],
        ),
      ),
    );
  }
}