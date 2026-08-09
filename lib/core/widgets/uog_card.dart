import 'package:flutter/material.dart';

import '../design/app_colors.dart';
import '../design/app_radius.dart';

class UOGCard extends StatelessWidget {
  final Widget child;

  final VoidCallback? onTap;

  final EdgeInsetsGeometry padding;

  const UOGCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(18),
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,

      color: AppColors.surface,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          AppRadius.large,
        ),
      ),

      child: InkWell(
        borderRadius: BorderRadius.circular(
          AppRadius.large,
        ),

        onTap: onTap,

        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
