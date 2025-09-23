import 'package:flutter/material.dart';

class ResponsiveHelper {
  static double getScreenWidth(BuildContext context) => MediaQuery.of(context).size.width;
  static double getScreenHeight(BuildContext context) => MediaQuery.of(context).size.height;
  
  // Legacy compatibility methods
  double get screenWidth => 0; // Will be overridden with context
  double wp(double percentage) => percentage; // Width percentage - simplified
  double hp(double percentage) => percentage; // Height percentage - simplified
  
  // Screen size breakpoints
  static bool isSmallPhone(BuildContext context) => getScreenWidth(context) < 360;
  static bool isStandardPhone(BuildContext context) => getScreenWidth(context) >= 360 && getScreenWidth(context) < 600;
  static bool isLargePhone(BuildContext context) => getScreenWidth(context) >= 600 && getScreenWidth(context) < 900;
  static bool isTablet(BuildContext context) => getScreenWidth(context) >= 900;
  
  // Responsive padding
  static EdgeInsets getHorizontalPadding(BuildContext context) {
    double width = getScreenWidth(context);
    if (width > 600) return const EdgeInsets.symmetric(horizontal: 40);
    if (width > 360) return const EdgeInsets.symmetric(horizontal: 24);
    return const EdgeInsets.symmetric(horizontal: 20);
  }
  
  static EdgeInsets getScreenPadding(BuildContext context) {
    double width = getScreenWidth(context);
    if (width > 600) return const EdgeInsets.all(32);
    if (width > 360) return const EdgeInsets.all(24);
    return const EdgeInsets.all(20);
  }
  
  // Responsive card sizing
  static double getCardHeight(BuildContext context) {
    double height = getScreenHeight(context);
    return height * 0.25; // 25% of screen height
  }
  
  static double getOpportunityCardHeight(BuildContext context) {
    double height = getScreenHeight(context);
    if (isTablet(context)) return height * 0.3;
    return height * 0.35;
  }
  
  // Responsive font sizes
  static double getResponsiveFontSize(BuildContext context, double baseSize) {
    double width = getScreenWidth(context);
    if (width > 600) return baseSize * 1.1;
    if (width < 360) return baseSize * 0.9;
    return baseSize;
  }
  
  // Grid layout helpers
  static int getGridCrossAxisCount(BuildContext context) {
    double width = getScreenWidth(context);
    if (width > 900) return 3;
    if (width > 600) return 2;
    return 1;
  }
  
  static double getGridChildAspectRatio(BuildContext context) {
    if (isTablet(context)) return 1.2;
    if (isLargePhone(context)) return 1.1;
    return 0.8;
  }
  
  // Bottom navigation sizing
  static double getBottomNavHeight(BuildContext context) {
    if (isTablet(context)) return 80;
    return 70;
  }
  
  // App bar sizing
  static double getAppBarHeight(BuildContext context) {
    if (isTablet(context)) return 70;
    return 60;
  }
  
  // Button sizing
  static double getButtonHeight(BuildContext context) {
    if (isTablet(context)) return 56;
    if (isSmallPhone(context)) return 44;
    return 48;
  }
  
  // Icon sizing
  static double getIconSize(BuildContext context, double baseSize) {
    if (isTablet(context)) return baseSize * 1.2;
    if (isSmallPhone(context)) return baseSize * 0.9;
    return baseSize;
  }
  
  // Safe area helpers
  static EdgeInsets getSafeAreaPadding(BuildContext context) {
    return MediaQuery.of(context).padding;
  }
  
  static double getStatusBarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }
  
  static double getBottomSafeArea(BuildContext context) {
    return MediaQuery.of(context).padding.bottom;
  }
}
