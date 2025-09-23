import 'package:flutter/material.dart';
import '../models/opportunity.dart';
import '../utils/colors.dart';
import '../utils/text_styles.dart';
import '../utils/responsive_helper.dart';

class SimpleOpportunityCard extends StatelessWidget {
  final Opportunity opportunity;
  final VoidCallback? onTap;

  const SimpleOpportunityCard({
    super.key,
    required this.opportunity,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: responsive.screenWidth * 0.8,
        margin: EdgeInsets.only(right: responsive.wp(4)),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image placeholder
            Container(
              height: responsive.hp(20),
              decoration: BoxDecoration(
                color: AppColors.primaryGreen.withOpacity(0.1),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.volunteer_activism,
                  size: responsive.wp(12),
                  color: AppColors.primaryGreen,
                ),
              ),
            ),
            
            Padding(
              padding: EdgeInsets.all(responsive.wp(4)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    opportunity.title,
                    style: AppTextStyles.heading3.copyWith(
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: responsive.hp(1)),
                  
                  Text(
                    opportunity.organization,
                    style: AppTextStyles.body2.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: responsive.hp(1)),
                  
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: responsive.wp(4),
                        color: AppColors.textSecondary,
                      ),
                      SizedBox(width: responsive.wp(1)),
                      Expanded(
                        child: Text(
                          opportunity.location,
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.textSecondary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: responsive.hp(1)),
                  
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: responsive.wp(4),
                        color: AppColors.textSecondary,
                      ),
                      SizedBox(width: responsive.wp(1)),
                      Text(
                        '${opportunity.duration} hours',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: responsive.wp(2),
                          vertical: responsive.hp(0.5),
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryGreen.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          opportunity.category,
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.primaryGreen,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
