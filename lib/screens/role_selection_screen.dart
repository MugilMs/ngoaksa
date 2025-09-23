import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/auth_service.dart';
import 'profile_info_screen1.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  String? _selectedRole;
  bool _isLoading = false;

  Future<void> _saveUserRole() async {
    if (_selectedRole == null) return;
    
    final user = AuthService.currentUser;
    if (user == null) return;
    
    setState(() {
      _isLoading = true;
    });
    
    try {
      await Supabase.instance.client
          .from('user_profiles')
          .upsert({
            'id': user.id,
            'role': _selectedRole,
            'updated_at': DateTime.now().toIso8601String(),
          });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ProfileInfoScreen1(),
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error saving role: $error'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'NGO Connect',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Choose Your Role',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Center(
              child: Text(
                'Select the role that best describes you.',
                style: TextStyle(
                  color: Color(0xFF9EB7A8),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView(
                children: [
                  _buildRoleCard(
                    icon: Icons.business,
                    title: 'NGO Administrator',
                    description:
                        'Manage your organization, post opportunities, and connect with volunteers.',
                    value: 'ngo',
                  ),
                  const SizedBox(height: 16),
                  _buildRoleCard(
                    icon: Icons.volunteer_activism,
                    title: 'Volunteer',
                    description:
                        'Find and apply for opportunities that match your skills and interests.',
                    value: 'volunteer',
                  ),
                  const SizedBox(height: 16),
                  _buildRoleCard(
                    icon: Icons.support_agent,
                    title: 'Service Seeker',
                    description:
                        'Request assistance from NGOs and volunteers for specific needs.',
                    value: 'service_seeker',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 56,
          child: ElevatedButton(
            onPressed: _selectedRole != null && !_isLoading ? _saveUserRole : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF38E07B),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
            ),
            child: _isLoading
                ? const CircularProgressIndicator(
                    color: Colors.black,
                    strokeWidth: 2,
                  )
                : const Text(
                    'Continue',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCard({
    required IconData icon,
    required String title,
    required String description,
    required String value,
  }) {
    return Card(
      color: const Color(0xFF1C2620),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: _selectedRole == value
              ? const Color(0xFF38E07B)
              : const Color(0xFF374A3F),
        ),
      ),
      child: RadioListTile(
        value: value,
        groupValue: _selectedRole,
        onChanged: (String? value) {
          setState(() {
            _selectedRole = value;
          });
        },
        activeColor: const Color(0xFF38E07B),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          description,
          style: const TextStyle(
            color: Color(0xFF9EB7A8),
          ),
        ),
        secondary: Icon(
          icon,
          color: _selectedRole == value
              ? const Color(0xFF38E07B)
              : Colors.white,
        ),
      ),
    );
  }
}
