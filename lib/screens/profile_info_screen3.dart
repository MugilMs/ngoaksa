import 'package:flutter/material.dart';
import 'main_app_screen.dart';

class ProfileInfoScreen3 extends StatefulWidget {
  const ProfileInfoScreen3({super.key});

  @override
  State<ProfileInfoScreen3> createState() => _ProfileInfoScreen3State();
}

class _ProfileInfoScreen3State extends State<ProfileInfoScreen3> {
  Map<String, dynamic>? _userProfile;
  bool _isLoading = false;

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
          'Review Profile',
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
                    color: const Color(0xFF38E07B),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 24,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFF38E07B),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Profile Complete!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Your profile has been successfully created. You can now start exploring opportunities and connecting with NGOs.',
              style: TextStyle(
                color: Color(0xFF9EB7A8),
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            const Icon(
              Icons.check_circle,
              color: Color(0xFF38E07B),
              size: 120,
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _isLoading ? null : () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainAppScreen(),
                    ),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF38E07B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
                child: const Text(
                  'Get Started',
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
}
