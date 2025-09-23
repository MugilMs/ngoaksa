import 'package:flutter/material.dart';
import 'profile_info_screen2.dart';

class ProfileInfoScreen1 extends StatefulWidget {
  const ProfileInfoScreen1({super.key});

  @override
  State<ProfileInfoScreen1> createState() => _ProfileInfoScreen1State();
}

class _ProfileInfoScreen1State extends State<ProfileInfoScreen1> {
  final _nameController = TextEditingController();
  final _contactController = TextEditingController();
  final _emailController = TextEditingController();
  bool _isLoading = false;

  Future<void> _pickImage() async {
    // Simplified - just show a message for demo
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Image picker not available in demo mode'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  Future<void> _saveProfile() async {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your name'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate save delay
    await Future.delayed(const Duration(seconds: 1));

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProfileInfoScreen2(),
      ),
    );

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _contactController.dispose();
    _emailController.dispose();
    super.dispose();
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
          'Complete Profile',
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
          children: [
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 24,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFF38E07B),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 24,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFF29382F),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 24,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFF29382F),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Basic Information',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView(
                children: [
                  _buildTextField(
                    controller: _nameController,
                    label: 'Full Name',
                    hintText: 'Enter your full name',
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _contactController,
                    label: 'Contact Number',
                    hintText: 'Enter your phone number',
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _emailController,
                    label: 'Email',
                    hintText: 'Enter your email',
                    keyboardType: TextInputType.emailAddress,
                    enabled: false,
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Profile Picture',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF29382F),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: const Color(0xFF111714),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.photo_camera,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Upload Photo',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'PNG, JPG, GIF up to 10MB',
                                  style: TextStyle(
                                    color: Color(0xFF9EB7A8),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _saveProfile,
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
                        'Next',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    bool enabled = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          enabled: enabled,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFF29382F),
            hintText: hintText,
            hintStyle: const TextStyle(color: Color(0xFF9EB7A8)),
            border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
      ],
    );
  }
}
