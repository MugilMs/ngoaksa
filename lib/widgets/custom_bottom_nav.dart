import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/text_styles.dart';
import '../utils/responsive_helper.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ResponsiveHelper.getBottomNavHeight(context) + 
              ResponsiveHelper.getBottomSafeArea(context),
      decoration: BoxDecoration(
        color: AppColors.darkGreen,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(
              context,
              icon: Icons.home_outlined,
              activeIcon: Icons.home,
              label: 'Home',
              index: 0,
            ),
            _buildNavItem(
              context,
              icon: Icons.explore_outlined,
              activeIcon: Icons.explore,
              label: 'Discover',
              index: 1,
            ),
            _buildNavItem(
              context,
              icon: Icons.calendar_today_outlined,
              activeIcon: Icons.calendar_today,
              label: 'Activities',
              index: 2,
            ),
            _buildNavItem(
              context,
              icon: Icons.chat_bubble_outline,
              activeIcon: Icons.chat_bubble,
              label: 'Messages',
              index: 3,
            ),
            _buildNavItem(
              context,
              icon: Icons.person_outline,
              activeIcon: Icons.person,
              label: 'Profile',
              index: 4,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required int index,
  }) {
    final isActive = currentIndex == index;
    
    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                isActive ? activeIcon : icon,
                key: ValueKey(isActive),
                size: ResponsiveHelper.getIconSize(context, 24),
                color: isActive ? AppColors.primaryGreen : AppColors.textTertiary,
              ),
            ),
            const SizedBox(height: 4),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: AppTextStyles.navLabel.copyWith(
                color: isActive ? AppColors.primaryGreen : AppColors.textTertiary,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}
