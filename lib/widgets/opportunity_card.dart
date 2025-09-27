import 'package:flutter/material.dart';
import '../models/opportunity.dart';
import '../utils/colors.dart';
import '../utils/text_styles.dart';
import '../utils/responsive_helper.dart';

class OpportunityCard extends StatelessWidget {
  final Opportunity opportunity;
  final VoidCallback onApply;
  final bool showFullDescription;

  const OpportunityCard({
    super.key,
    required this.opportunity,
    required this.onApply,
    this.showFullDescription = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: ResponsiveHelper.getHorizontalPadding(context).copyWith(bottom: 16),
      decoration: BoxDecoration(
        gradient: AppColors.cardGradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImageSection(context),
          _buildContentSection(context),
        ],
      ),
    );
  }

  Widget _buildImageSection(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: Container(
            height: ResponsiveHelper.getOpportunityCardHeight(context) * 0.6,
            width: double.infinity,
            color: AppColors.inputBackground,
            child: const Icon(
              Icons.image,
              color: AppColors.textTertiary,
              size: 48,
            ),
          ),
        ),
        Positioned(
          top: 12,
          left: 12,
          child: _buildTypeBadge(),
        ),
        if (opportunity.isUrgent)
          Positioned(
            top: 12,
            right: 12,
            child: _buildUrgentBadge(),
          ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 60,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black54],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTypeBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primaryGreen,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        opportunity.type.displayName,
        style: AppTextStyles.badge,
      ),
    );
  }

  Widget _buildUrgentBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.emergencyRed,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        'EMERGENCY',
        style: AppTextStyles.emergencyBadge,
      ),
    );
  }

  Widget _buildContentSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            opportunity.title,
            style: AppTextStyles.heading4,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Text(
            opportunity.description,
            style: AppTextStyles.bodySecondaryMedium,
            maxLines: showFullDescription ? null : 2,
            overflow: showFullDescription ? null : TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          _buildMetaInfo(),
          if (opportunity.rating != null) ...[
            const SizedBox(height: 8),
            _buildRating(),
          ],
          const SizedBox(height: 16),
          _buildApplyButton(context),
        ],
      ),
    );
  }

  Widget _buildMetaInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.business,
              size: 16,
              color: AppColors.primaryGreen,
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                opportunity.organization,
                style: AppTextStyles.captionSmall.copyWith(
                  color: AppColors.primaryGreen,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            const Icon(
              Icons.location_on,
              size: 16,
              color: AppColors.textTertiary,
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                opportunity.location,
                style: AppTextStyles.captionSmall,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            const Icon(
              Icons.calendar_today,
              size: 16,
              color: AppColors.textTertiary,
            ),
            const SizedBox(width: 4),
            Text(
              '${opportunity.formattedDate}${opportunity.time != null ? ' • ${opportunity.time}' : ''}',
              style: AppTextStyles.captionSmall,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRating() {
    return Row(
      children: [
        const Icon(
          Icons.star,
          size: 16,
          color: AppColors.primaryGreen,
        ),
        const SizedBox(width: 4),
        Text(
          opportunity.rating!.toStringAsFixed(1),
          style: AppTextStyles.captionSmall.copyWith(
            color: AppColors.primaryGreen,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (opportunity.reviewCount != null) ...[
          const SizedBox(width: 4),
          Text(
            '(${opportunity.reviewCount} reviews)',
            style: AppTextStyles.captionSmall,
          ),
        ],
      ],
    );
  }

  Widget _buildApplyButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: ResponsiveHelper.getButtonHeight(context),
      child: ElevatedButton(
        onPressed: onApply,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryGreen,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          elevation: 0,
        ),
        child: Text(
          'Apply Now',
          style: AppTextStyles.buttonMedium,
        ),
      ),
    );
  }
}
