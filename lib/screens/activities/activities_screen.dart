import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../models/activity.dart';
import '../../utils/colors.dart';
import '../../utils/text_styles.dart';
import '../../utils/responsive_helper.dart';
import '../../data/dummy_data.dart';

class ActivitiesScreen extends StatefulWidget {
  const ActivitiesScreen({super.key});

  @override
  State<ActivitiesScreen> createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            _buildTabBar(context),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildUpcomingTab(),
                  _buildCompletedTab(),
                  _buildApplicationsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: ResponsiveHelper.getHorizontalPadding(context).copyWith(
        top: 16,
        bottom: 16,
      ),
      child: Row(
        children: [
          Text(
            'Activities',
            style: AppTextStyles.heading1,
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              // TODO: Implement calendar view
            },
            icon: const Icon(
              Icons.calendar_today,
              color: AppColors.textPrimary,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar(BuildContext context) {
    return Container(
      margin: ResponsiveHelper.getHorizontalPadding(context),
      decoration: BoxDecoration(
        color: AppColors.inputBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: AppColors.primaryGreen,
          borderRadius: BorderRadius.circular(12),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: Colors.black,
        unselectedLabelColor: AppColors.textSecondary,
        labelStyle: AppTextStyles.buttonSmall,
        unselectedLabelStyle: AppTextStyles.buttonSmall,
        tabs: const [
          Tab(text: 'Upcoming'),
          Tab(text: 'Completed'),
          Tab(text: 'Applications'),
        ],
      ),
    );
  }

  Widget _buildUpcomingTab() {
    final upcomingActivities = DummyData.userActivities
        .where((activity) => activity.status == ActivityStatus.upcoming)
        .toList();

    if (upcomingActivities.isEmpty) {
      return _buildEmptyState(
        icon: Icons.event_available,
        title: 'No Upcoming Activities',
        subtitle: 'Your scheduled volunteer activities will appear here',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: upcomingActivities.length,
      itemBuilder: (context, index) {
        final activity = upcomingActivities[index];
        return _buildActivityCard(activity);
      },
    );
  }

  Widget _buildCompletedTab() {
    final completedActivities = DummyData.userActivities
        .where((activity) => activity.status == ActivityStatus.completed)
        .toList();

    if (completedActivities.isEmpty) {
      return _buildEmptyState(
        icon: Icons.check_circle_outline,
        title: 'No Completed Activities',
        subtitle: 'Your completed volunteer work will be tracked here',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: completedActivities.length,
      itemBuilder: (context, index) {
        final activity = completedActivities[index];
        return _buildActivityCard(activity);
      },
    );
  }

  Widget _buildApplicationsTab() {
    final pendingActivities = DummyData.userActivities
        .where((activity) => activity.status == ActivityStatus.pending)
        .toList();

    if (pendingActivities.isEmpty) {
      return _buildEmptyState(
        icon: Icons.pending_actions,
        title: 'No Pending Applications',
        subtitle: 'Your volunteer applications will be shown here',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: pendingActivities.length,
      itemBuilder: (context, index) {
        final activity = pendingActivities[index];
        return _buildActivityCard(activity);
      },
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 64,
            color: AppColors.textTertiary,
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: AppTextStyles.heading4.copyWith(
              color: AppColors.textTertiary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: AppTextStyles.bodySecondary,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildActivityCard(Activity activity) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
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
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor(activity.status),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  activity.status.displayName,
                  style: AppTextStyles.badge.copyWith(
                    color: activity.status == ActivityStatus.completed
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
              const Spacer(),
              if (activity.status == ActivityStatus.upcoming)
                IconButton(
                  onPressed: () {
                    _showActivityOptions(context, activity);
                  },
                  icon: const Icon(
                    Icons.more_vert,
                    color: AppColors.textSecondary,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            activity.title,
            style: AppTextStyles.heading4,
          ),
          const SizedBox(height: 8),
          Text(
            activity.description,
            style: AppTextStyles.bodySecondary,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                Icons.business,
                size: 16,
                color: AppColors.primaryGreen,
              ),
              const SizedBox(width: 4),
              Text(
                activity.organization,
                style: AppTextStyles.captionSmall.copyWith(
                  color: AppColors.primaryGreen,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.access_time,
                size: 16,
                color: AppColors.textTertiary,
              ),
              const SizedBox(width: 4),
              Text(
                activity.formattedDate,
                style: AppTextStyles.captionSmall,
              ),
              const Spacer(),
              if (activity.hoursLogged > 0)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.successGreen,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${activity.hoursLogged}h logged',
                    style: AppTextStyles.captionSmall.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          if (activity.status == ActivityStatus.upcoming) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      _cancelActivity(activity);
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.emergencyRed),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: AppTextStyles.buttonSmall.copyWith(
                        color: AppColors.emergencyRed,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _markAsCompleted(activity);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Mark Complete',
                      style: AppTextStyles.buttonSmall,
                    ),
                  ),
                ),
              ],
            ),
          ],
          if (activity.status == ActivityStatus.completed) ...[
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  _shareActivity(activity);
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.primaryBlue),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: Icon(
                  Icons.share,
                  color: AppColors.primaryBlue,
                  size: 16,
                ),
                label: Text(
                  'Share Achievement',
                  style: AppTextStyles.buttonSmall.copyWith(
                    color: AppColors.primaryGreen,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Color _getStatusColor(ActivityStatus status) {
    switch (status) {
      case ActivityStatus.pending:
        return AppColors.warningYellow;
      case ActivityStatus.upcoming:
        return AppColors.primaryGreen;
      case ActivityStatus.completed:
        return AppColors.successGreen;
      case ActivityStatus.cancelled:
        return AppColors.emergencyRed;
    }
  }

  void _showActivityOptions(BuildContext context, Activity activity) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.cardBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              activity.title,
              style: AppTextStyles.heading4,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ListTile(
              leading: const Icon(
                Icons.info_outline,
                color: AppColors.primaryGreen,
              ),
              title: Text(
                'View Details',
                style: AppTextStyles.bodyMedium,
              ),
              onTap: () {
                Navigator.pop(context);
                // TODO: Navigate to activity details
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.edit,
                color: AppColors.textSecondary,
              ),
              title: Text(
                'Edit Activity',
                style: AppTextStyles.bodyMedium,
              ),
              onTap: () {
                Navigator.pop(context);
                // TODO: Navigate to edit activity
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.cancel,
                color: AppColors.emergencyRed,
              ),
              title: Text(
                'Cancel Activity',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.emergencyRed,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                _cancelActivity(activity);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _cancelActivity(Activity activity) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardBackground,
        title: Text(
          'Cancel Activity',
          style: AppTextStyles.heading4,
        ),
        content: Text(
          'Are you sure you want to cancel "${activity.title}"?',
          style: AppTextStyles.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Keep',
              style: AppTextStyles.link,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${activity.title} cancelled'),
                  backgroundColor: AppColors.emergencyRed,
                ),
              );
            },
            child: Text(
              'Cancel',
              style: AppTextStyles.link.copyWith(
                color: AppColors.emergencyRed,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _markAsCompleted(Activity activity) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardBackground,
        title: Text(
          'Mark as Completed',
          style: AppTextStyles.heading4,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'How many hours did you volunteer for "${activity.title}"?',
              style: AppTextStyles.bodyMedium,
            ),
            const SizedBox(height: 16),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Hours (e.g., 4.5)',
                filled: true,
                fillColor: AppColors.inputBackground,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: AppTextStyles.link,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${activity.title} marked as completed!'),
                  backgroundColor: AppColors.successGreen,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryGreen,
            ),
            child: Text(
              'Complete',
              style: AppTextStyles.buttonSmall,
            ),
          ),
        ],
      ),
    );
  }

  void _shareActivity(Activity activity) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Shared ${activity.title} achievement!'),
        backgroundColor: AppColors.successGreen,
      ),
    );
  }
}
