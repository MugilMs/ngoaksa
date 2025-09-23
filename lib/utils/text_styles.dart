import 'package:flutter/material.dart';
import 'colors.dart';

class AppTextStyles {
  // Headings
  static const TextStyle heading1 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.2,
  );
  
  static const TextStyle heading2 = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.3,
  );
  
  static const TextStyle heading3 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.3,
  );
  
  static const TextStyle heading4 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.4,
  );
  
  // Body Text
  static const TextStyle body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    height: 1.5,
  );
  
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    height: 1.4,
  );
  
  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    height: 1.3,
  );
  
  // Secondary Text
  static const TextStyle bodySecondary = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    height: 1.5,
  );
  
  static const TextStyle bodySecondaryMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    height: 1.4,
  );
  
  static const TextStyle bodySecondarySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    height: 1.3,
  );
  
  // Caption Text
  static const TextStyle caption = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textTertiary,
    height: 1.3,
  );
  
  static const TextStyle captionSmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textTertiary,
    height: 1.2,
  );
  
  // Button Text
  static const TextStyle buttonLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.black,
    height: 1.2,
  );
  
  static const TextStyle buttonMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.black,
    height: 1.2,
  );
  
  static const TextStyle buttonSmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: Colors.black,
    height: 1.2,
  );
  
  // Special Text Styles
  static const TextStyle badge = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    letterSpacing: 0.5,
  );
  
  static const TextStyle emergencyBadge = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    letterSpacing: 0.5,
  );
  
  static const TextStyle link = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryBlue,
    decoration: TextDecoration.underline,
  );

  // Legacy compatibility - add missing body2 style
  static const TextStyle body2 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    height: 1.4,
  );
  
  static const TextStyle navLabel = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.2,
  );
  
  // Input Text Styles
  static const TextStyle inputText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    height: 1.4,
  );
  
  static const TextStyle inputHint = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textTertiary,
    height: 1.4,
  );
  
  static const TextStyle inputLabel = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    height: 1.3,
  );
}
