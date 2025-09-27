import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors - Green Scheme
  static const Color primaryGreen = Color.fromRGBO(113, 221, 133, 1.0); // #71DD85
  static const Color primaryDark = Color(0xFF52B366);
  static const Color primaryLight = Color(0xFFB2F7C1);
  static const Color accent = Color(0xFF71DD85);
  
  // Background Colors
  static const Color backgroundColor = Color(0xFFFFFFFF); // Card and surface colors
  static const Color cardBackground = Color(0xFFb7e4c7);
  static const Color surfaceColor = Color(0xFFF8F9FA);
  
  // Text Colors
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textTertiary = Color(0xFF94A3B8);
  static const Color textLight = Color(0xFFCBD5E1);
  
  // Status Colors
  static const Color emergencyRed = Color(0xFFEF4444);
  static const Color warningOrange = Color(0xFFF59E0B);
  static const Color successGreen = Color(0xFF10B981);
  static const Color infoBlue = Color(0xFF3B82F6);
  
  // UI Element Colors
  static const Color inputBackground = Color(0xFFF8FAFC);
  static const Color inputBorder = Color(0xFFE2E8F0);
  static const Color dividerColor = Color(0xFFE2E8F0);
  static const Color shadowColor = Color(0x0F000000);
  
  // Gradient Colors
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFFFFFFF),
      Color(0xFFF8FAFC),
    ],
  );
  
  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFFFFFF),
      Color(0xFFF8FAFC),
    ],
  );
  
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF71DD85),
      Color(0xFFB2F7C1),
    ],
  );
  
  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF71DD85),
      Color(0xFF52B366),
    ],
  );
  
  // Opacity Variants
  static Color get primaryGreenOpacity10 => primaryGreen.withOpacity(0.1);
  static Color get primaryGreenOpacity20 => primaryGreen.withOpacity(0.2);
  static Color get primaryGreenOpacity50 => primaryGreen.withOpacity(0.5);
  
  static Color get textPrimaryOpacity60 => textPrimary.withOpacity(0.6);
  static Color get textPrimaryOpacity80 => textPrimary.withOpacity(0.8);
  
  // Legacy compatibility (will be removed)
  static Color get secondaryGreen => primaryLight;
  static Color get darkGreen => primaryDark;
  static Color get primaryBlue => primaryGreen; // For backward compatibility
  static Color get primaryBlueOpacity10 => primaryGreenOpacity10;
  static Color get primaryBlueOpacity20 => primaryGreenOpacity20;
  static Color get primaryBlueOpacity50 => primaryGreenOpacity50;
  static Color get warningYellow => warningOrange;
}
