import 'package:flutter/material.dart';
import '../utils/colors.dart';
import 'admin_page.dart';
import 'student_page.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  String? _selectedRole;
  bool _isLoading = false;

  void _navigateToRolePage() {
    if (_selectedRole == null) return;
    
    setState(() {
      _isLoading = true;
    });
    
    // Navigate based on selected role
    Widget targetPage;
    if (_selectedRole == 'admin') {
      targetPage = const AdminPage();
    } else {
      targetPage = const StudentPage();
    }
    
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => targetPage,
      ),
    );
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
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Choose Your Role',
                style: TextStyle(
                    color: Colors.black,
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
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView(
                children: [
                  _buildRoleCard(
                    icon: Icons.admin_panel_settings,
                    title: 'Admin',
                    description:
                        'Manage events, post opportunities, and oversee activities.',
                    value: 'admin',
                  ),
                  const SizedBox(height: 16),
                  _buildRoleCard(
                    icon: Icons.school,
                    title: 'Student',
                    description:
                        'Discover and join events that match your interests.',
                    value: 'student',
                  ),
                ],
              ),
            ),
          ],
        ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 56,
          child: ElevatedButton(
            onPressed: _selectedRole != null && !_isLoading ? _navigateToRolePage : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(113, 221, 133, 1.0),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
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
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: _selectedRole == value
              ? const Color.fromRGBO(113, 221, 133, 1.0)
              : Colors.grey.shade300,
        ),
      ),
      elevation: 2,
      child: RadioListTile(
        value: value,
        groupValue: _selectedRole,
        onChanged: (String? value) {
          setState(() {
            _selectedRole = value;
          });
        },
        activeColor: const Color.fromRGBO(113, 221, 133, 1.0),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          description,
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
        secondary: Icon(
          icon,
          color: _selectedRole == value
              ? const Color.fromRGBO(113, 221, 133, 1.0)
              : Colors.grey,
        ),
      ),
    );
  }
}
