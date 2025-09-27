import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../providers/auth_provider.dart';
import '../../models/user.dart';
import '../../utils/colors.dart';
import '../../utils/text_styles.dart';
import '../../utils/responsive_helper.dart';
import '../../data/dummy_data.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: screenHeight - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom,
            ),
            child: Column(
              children: [
                _buildHeader(context),
                _buildProfileInfo(context),
                const SizedBox(height: 24),
                _buildStats(context),
                const SizedBox(height: 24),
                _buildMenuOptions(context),
                SizedBox(height: bottomPadding + 80), // Dynamic bottom padding
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: ResponsiveHelper.getHorizontalPadding(context).copyWith(
        top: 16,
        bottom: 32,
      ),
      decoration: const BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Profile',
                style: AppTextStyles.heading1.copyWith(color: Colors.black),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  _showSettingsBottomSheet(context);
                },
                icon: const Icon(
                  Icons.settings,
                  color: Colors.black,
                  size: 28,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Consumer<AuthProvider>(
            builder: (context, authProvider, child) {
              final user = authProvider.currentUser ?? DummyData.sampleUser;
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      _showProfileImageOptions(context);
                    },
                    child: Stack(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.black,
                              width: 3,
                            ),
                          ),
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: user.profileImageUrl ?? '',
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                color: AppColors.inputBackground,
                                child: const Icon(
                                  Icons.person,
                                  color: AppColors.textSecondary,
                                  size: 40,
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                color: AppColors.inputBackground,
                                child: const Icon(
                                  Icons.person,
                                  color: AppColors.textSecondary,
                                  size: 40,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: AppColors.primaryGreen,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    user.fullName,
                    style: AppTextStyles.heading2.copyWith(color: Colors.black),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      user.role.displayName,
                      style: AppTextStyles.badge.copyWith(color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    user.email,
                    style: AppTextStyles.bodySecondary.copyWith(color: Colors.black87),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProfileInfo(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        final user = authProvider.currentUser ?? DummyData.sampleUser;
        return Container(
          margin: ResponsiveHelper.getHorizontalPadding(context),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: AppColors.shadowColor,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'About Me',
                    style: AppTextStyles.heading4,
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      _showEditProfileDialog(context);
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: AppColors.primaryGreen,
                      size: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                user.bio ?? 'No bio added yet. Tell others about yourself!',
                style: AppTextStyles.bodySecondary,
              ),
              const SizedBox(height: 16),
              if (user.skills?.isNotEmpty == true) ...[
                const Text(
                  'Skills',
                  style: AppTextStyles.heading5,
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: user.skills!.map((skill) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.primaryGreenOpacity10,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.primaryGreen),
                      ),
                      child: Text(
                        skill,
                        style: AppTextStyles.captionSmall.copyWith(
                          color: AppColors.primaryGreen,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildStats(BuildContext context) {
    final stats = DummyData.userStats;
    
    return Container(
      margin: ResponsiveHelper.getHorizontalPadding(context),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'My Impact',
            style: AppTextStyles.heading4,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  'Hours Volunteered',
                  stats['hoursVolunteered'].toString(),
                  Icons.access_time,
                ),
              ),
              Container(
                width: 1,
                height: 40,
                color: AppColors.dividerColor,
              ),
              Expanded(
                child: _buildStatItem(
                  'Services Accessed',
                  stats['servicesAccessed'].toString(),
                  Icons.volunteer_activism,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  'Organizations',
                  stats['organizationsHelped'].toString(),
                  Icons.business,
                ),
              ),
              Container(
                width: 1,
                height: 40,
                color: AppColors.dividerColor,
              ),
              Expanded(
                child: _buildStatItem(
                  'Impact Score',
                  stats['impactScore'].toString(),
                  Icons.star,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: AppColors.primaryGreen,
          size: 24,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: AppTextStyles.heading3,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTextStyles.captionSmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildMenuOptions(BuildContext context) {
    return Container(
      margin: ResponsiveHelper.getHorizontalPadding(context),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildMenuItem(
            icon: Icons.person_outline,
            title: 'Edit Profile',
            subtitle: 'Update your personal information',
            onTap: () => _showEditProfileDialog(context),
          ),
          _buildDivider(),
          _buildMenuItem(
            icon: Icons.notifications_outlined,
            title: 'Notifications',
            subtitle: 'Manage your notification preferences',
            onTap: () => _showNotificationSettings(context),
          ),
          _buildDivider(),
          _buildMenuItem(
            icon: Icons.security,
            title: 'Privacy & Security',
            subtitle: 'Control your privacy settings',
            onTap: () => _showPrivacySettings(context),
          ),
          _buildDivider(),
          _buildMenuItem(
            icon: Icons.help_outline,
            title: 'Help & Support',
            subtitle: 'Get help and contact support',
            onTap: () => _showHelpSupport(context),
          ),
          _buildDivider(),
          _buildMenuItem(
            icon: Icons.info_outline,
            title: 'About',
            subtitle: 'App version and information',
            onTap: () => _showAboutDialog(context),
          ),
          _buildDivider(),
          _buildMenuItem(
            icon: Icons.logout,
            title: 'Sign Out',
            subtitle: 'Sign out of your account',
            onTap: () => _showSignOutDialog(context),
            isDestructive: true,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDestructive ? AppColors.emergencyRed : AppColors.primaryGreen,
        size: 24,
      ),
      title: Text(
        title,
        style: AppTextStyles.bodyMedium.copyWith(
          color: isDestructive ? AppColors.emergencyRed : AppColors.textPrimary,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: AppTextStyles.captionSmall,
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: AppColors.textTertiary,
      ),
      onTap: onTap,
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      color: AppColors.dividerColor,
    );
  }

  void _showProfileImageOptions(BuildContext context) {
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
            const Text(
              'Profile Picture',
              style: AppTextStyles.heading4,
            ),
            const SizedBox(height: 24),
            ListTile(
              leading: const Icon(
                Icons.camera_alt,
                color: AppColors.primaryGreen,
              ),
              title: const Text(
                'Take Photo',
                style: AppTextStyles.bodyMedium,
              ),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Camera feature coming soon!'),
                    backgroundColor: AppColors.warningOrange,
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.photo_library,
                color: AppColors.primaryGreen,
              ),
              title: const Text(
                'Choose from Gallery',
                style: AppTextStyles.bodyMedium,
              ),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Gallery feature coming soon!'),
                    backgroundColor: AppColors.warningYellow,
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.delete,
                color: AppColors.emergencyRed,
              ),
              title: Text(
                'Remove Photo',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.emergencyRed,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Profile picture removed'),
                    backgroundColor: AppColors.successGreen,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showEditProfileDialog(BuildContext context) {
    final nameController = TextEditingController();
    final bioController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardBackground,
        title: const Text(
          'Edit Profile',
          style: AppTextStyles.heading4,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Full Name',
                filled: true,
                fillColor: AppColors.inputBackground,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: bioController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Bio',
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
            child: const Text(
              'Cancel',
              style: AppTextStyles.link,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Profile updated successfully!'),
                  backgroundColor: AppColors.successGreen,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryGreen,
            ),
            child: const Text(
              'Save',
              style: AppTextStyles.buttonSmall,
            ),
          ),
        ],
      ),
    );
  }

  void _showSettingsBottomSheet(BuildContext context) {
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Settings',
              style: AppTextStyles.heading4,
            ),
            const SizedBox(height: 24),
            ListTile(
              leading: const Icon(
                Icons.dark_mode,
                color: AppColors.primaryGreen,
              ),
              title: const Text(
                'Dark Mode',
                style: AppTextStyles.bodyMedium,
              ),
              trailing: Switch(
                value: true,
                onChanged: (value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Theme switching coming soon!'),
                      backgroundColor: AppColors.warningYellow,
                    ),
                  );
                },
                activeColor: AppColors.primaryGreen,
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.language,
                color: AppColors.primaryGreen,
              ),
              title: const Text(
                'Language',
                style: AppTextStyles.bodyMedium,
              ),
              subtitle: const Text(
                'English',
                style: AppTextStyles.captionSmall,
              ),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Language selection coming soon!'),
                    backgroundColor: AppColors.warningYellow,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showNotificationSettings(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Notification settings coming soon!'),
        backgroundColor: AppColors.warningYellow,
      ),
    );
  }

  void _showPrivacySettings(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Privacy settings coming soon!'),
        backgroundColor: AppColors.warningYellow,
      ),
    );
  }

  void _showHelpSupport(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Help & Support coming soon!'),
        backgroundColor: AppColors.warningYellow,
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardBackground,
        title: const Text(
          'About NGO Connect',
          style: AppTextStyles.heading4,
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Version 1.0.0',
              style: AppTextStyles.bodyMedium,
            ),
            SizedBox(height: 8),
            Text(
              'Connecting volunteers with meaningful opportunities to make a difference in their communities.',
              style: AppTextStyles.bodySecondary,
            ),
            SizedBox(height: 16),
            Text(
              '© 2024 NGO Connect. All rights reserved.',
              style: AppTextStyles.captionSmall,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Close',
              style: AppTextStyles.link,
            ),
          ),
        ],
      ),
    );
  }

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardBackground,
        title: const Text(
          'Sign Out',
          style: AppTextStyles.heading4,
        ),
        content: const Text(
          'Are you sure you want to sign out?',
          style: AppTextStyles.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: AppTextStyles.link,
            ),
          ),
          TextButton(
            onPressed: () async {
              try {
                Navigator.pop(context);
                await Provider.of<AuthProvider>(context, listen: false).signOut();
              } catch (e) {
                debugPrint('Error signing out: $e');
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Error signing out. Please try again.'),
                      backgroundColor: AppColors.emergencyRed,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                }
              }
            },
            child: Text(
              'Sign Out',
              style: AppTextStyles.link.copyWith(
                color: AppColors.emergencyRed,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
