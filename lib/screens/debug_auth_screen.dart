import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../providers/auth_provider.dart';
import '../utils/colors.dart';
import '../utils/text_styles.dart';

class DebugAuthScreen extends StatelessWidget {
  const DebugAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Debug Auth State'),
        backgroundColor: AppColors.primaryGreen,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<AuthProvider>(
          builder: (context, authProvider, child) {
            final supabaseUser = Supabase.instance.client.auth.currentUser;
            final session = Supabase.instance.client.auth.currentSession;
            
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSection('AuthProvider State', [
                    'Is Logged In: ${authProvider.isLoggedIn}',
                    'Is Loading: ${authProvider.isLoading}',
                    'Current User: ${authProvider.currentUser?.fullName ?? 'null'}',
                    'User Email: ${authProvider.currentUser?.email ?? 'null'}',
                    'User Role: ${authProvider.currentUser?.role.name ?? 'null'}',
                  ]),
                  const SizedBox(height: 20),
                  _buildSection('Supabase Auth State', [
                    'User ID: ${supabaseUser?.id ?? 'null'}',
                    'User Email: ${supabaseUser?.email ?? 'null'}',
                    'Email Confirmed: ${supabaseUser?.emailConfirmedAt != null}',
                    'Session: ${session != null ? 'Active' : 'null'}',
                    'Access Token: ${session?.accessToken != null ? 'Present' : 'null'}',
                  ]),
                  const SizedBox(height: 20),
                  _buildSection('User Metadata', [
                    if (supabaseUser?.userMetadata != null)
                      ...supabaseUser!.userMetadata!.entries.map(
                        (e) => '${e.key}: ${e.value}',
                      )
                    else
                      'No metadata',
                  ]),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () => _testDatabaseConnection(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryGreen,
                    ),
                    child: const Text('Test Database Connection'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => _refreshAuthState(context, authProvider),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                    ),
                    child: const Text('Refresh Auth State'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.heading4.copyWith(
            color: AppColors.primaryGreen,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.inputBackground,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.dividerColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: items.map((item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Text(
                item,
                style: AppTextStyles.bodyMedium,
              ),
            )).toList(),
          ),
        ),
      ],
    );
  }

  Future<void> _testDatabaseConnection(BuildContext context) async {
    try {
      final response = await Supabase.instance.client
          .from('users')
          .select('count')
          .count();
      
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Database connection successful! Users count: ${response.count}'),
            backgroundColor: AppColors.successGreen,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Database connection failed: $e'),
            backgroundColor: AppColors.emergencyRed,
          ),
        );
      }
    }
  }

  Future<void> _refreshAuthState(BuildContext context, AuthProvider authProvider) async {
    try {
      // Try to refresh session
      await Supabase.instance.client.auth.refreshSession();
      
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Auth state refreshed'),
            backgroundColor: AppColors.successGreen,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to refresh: $e'),
            backgroundColor: AppColors.emergencyRed,
          ),
        );
      }
    }
  }
}