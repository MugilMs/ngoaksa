import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/text_styles.dart';
import '../utils/responsive_helper.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color? iconColor;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: AppColors.cardGradient,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primaryGreenOpacity20,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: ResponsiveHelper.getIconSize(context, 24),
                color: iconColor ?? AppColors.primaryGreen,
              ),
              const Spacer(),
              Text(
                value,
                style: AppTextStyles.heading2.copyWith(
                  color: AppColors.primaryGreen,
                  fontSize: ResponsiveHelper.getResponsiveFontSize(context, 24),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: AppTextStyles.bodySecondaryMedium.copyWith(
              fontSize: ResponsiveHelper.getResponsiveFontSize(context, 14),
            ),
          ),
        ],
      ),
    );
  }
}
