import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../providers/auth_provider.dart';
import '../../providers/opportunity_provider.dart';
import '../../widgets/opportunity_card.dart';
import '../../widgets/stat_card.dart';
import '../../utils/colors.dart';
import '../../utils/text_styles.dart';
import '../../utils/responsive_helper.dart';
import '../../data/dummy_data.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await Provider.of<OpportunityProvider>(context, listen: false)
                .refreshOpportunities();
          },
          color: AppColors.primaryGreen,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                const SizedBox(height: 24),
                _buildFeaturedOpportunity(context),
                const SizedBox(height: 32),
                _buildQuickStats(context),
                const SizedBox(height: 32),
                _buildTrendingCauses(context),
                const SizedBox(height: 32),
                _buildUrgentNeeds(context),
                const SizedBox(height: 100), // Bottom padding for nav bar
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        return Padding(
          padding: ResponsiveHelper.getHorizontalPadding(context).copyWith(top: 16),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'For You',
                    style: AppTextStyles.heading1,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Hello, ${authProvider.currentUser?.fullName ?? 'User'}',
                    style: AppTextStyles.bodySecondary,
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  // TODO: Implement notifications
                },
                icon: const Icon(
                  Icons.notifications_outlined,
                  color: AppColors.textPrimary,
                  size: 28,
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  // TODO: Navigate to profile
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.primaryGreen,
                      width: 2,
                    ),
                  ),
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: authProvider.currentUser?.profileImageUrl ?? 
                                DummyData.sampleUser.profileImageUrl!,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: AppColors.inputBackground,
                        child: const Icon(
                          Icons.person,
                          color: AppColors.textSecondary,
                          size: 20,
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: AppColors.inputBackground,
                        child: const Icon(
                          Icons.person,
                          color: AppColors.textSecondary,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFeaturedOpportunity(BuildContext context) {
    final featuredOpportunity = DummyData.featuredOpportunities.first;
    
    return Container(
      margin: ResponsiveHelper.getHorizontalPadding(context),
      height: ResponsiveHelper.getOpportunityCardHeight(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CachedNetworkImage(
              imageUrl: featuredOpportunity.imageUrl,
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: AppColors.inputBackground,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryGreen,
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black87,
                ],
              ),
            ),
          ),
          Positioned(
            top: 16,
            left: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primaryGreen,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                featuredOpportunity.type.displayName,
                style: AppTextStyles.badge,
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  featuredOpportunity.title,
                  style: AppTextStyles.heading3,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  featuredOpportunity.description,
                  style: AppTextStyles.bodySecondaryMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 16,
                      color: AppColors.primaryGreen,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      featuredOpportunity.organization,
                      style: AppTextStyles.captionSmall.copyWith(
                        color: AppColors.primaryGreen,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      featuredOpportunity.formattedDate,
                      style: AppTextStyles.captionSmall,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: () {
                      Provider.of<OpportunityProvider>(context, listen: false)
                          .applyToOpportunity(featuredOpportunity.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Application submitted!'),
                          backgroundColor: AppColors.successGreen,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryGreen,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                    ),
                    child: Text(
                      'Apply Now',
                      style: AppTextStyles.buttonMedium,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats(BuildContext context) {
    final stats = DummyData.userStats;
    
    return Padding(
      padding: ResponsiveHelper.getHorizontalPadding(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Impact',
            style: AppTextStyles.heading3,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: StatCard(
                  title: 'Hours Volunteered',
                  value: stats['hoursVolunteered'].toString(),
                  icon: Icons.access_time,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: StatCard(
                  title: 'Services Accessed',
                  value: stats['servicesAccessed'].toString(),
                  icon: Icons.volunteer_activism,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTrendingCauses(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: ResponsiveHelper.getHorizontalPadding(context),
          child: Text(
            'Trending Causes',
            style: AppTextStyles.heading3,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: ResponsiveHelper.getHorizontalPadding(context),
            itemCount: DummyData.trendingCauses.length,
            itemBuilder: (context, index) {
              final cause = DummyData.trendingCauses[index];
              return Container(
                width: 200,
                margin: EdgeInsets.only(
                  right: index < DummyData.trendingCauses.length - 1 ? 16 : 0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadowColor,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: CachedNetworkImage(
                        imageUrl: cause.imageUrl,
                        height: double.infinity,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: AppColors.inputBackground,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black87,
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 12,
                      left: 12,
                      right: 12,
                      child: Text(
                        cause.name,
                        style: AppTextStyles.heading4,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildUrgentNeeds(BuildContext context) {
    return Consumer<OpportunityProvider>(
      builder: (context, opportunityProvider, child) {
        final urgentOpportunities = opportunityProvider.getUrgentOpportunities();
        
        if (urgentOpportunities.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: ResponsiveHelper.getHorizontalPadding(context),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.emergencyRed,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'EMERGENCY',
                      style: AppTextStyles.emergencyBadge,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Urgent Needs',
                    style: AppTextStyles.heading3,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ...urgentOpportunities.map(
              (opportunity) => OpportunityCard(
                opportunity: opportunity,
                onApply: () {
                  opportunityProvider.applyToOpportunity(opportunity.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Emergency application submitted!'),
                      backgroundColor: AppColors.successGreen,
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
