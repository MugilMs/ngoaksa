import 'package:flutter/material.dart';
import 'profile_info_screen3.dart';

class ProfileInfoScreen2 extends StatefulWidget {
  const ProfileInfoScreen2({super.key});

  @override
  State<ProfileInfoScreen2> createState() => _ProfileInfoScreen2State();
}

class _ProfileInfoScreen2State extends State<ProfileInfoScreen2> {
  final _skillsController = TextEditingController();
  final _interestsController = TextEditingController();
  String? _availability;
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
          'Skills & Interests',
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
                    color: const Color(0xFF29382F),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView(
                children: [
                  const Text(
                    'Skills',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _skillsController,
                    maxLines: 3,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFF29382F),
                      hintText: 'List your skills (e.g., Teaching, Healthcare, IT)',
                      hintStyle: const TextStyle(color: Color(0xFF9EB7A8)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Interests',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _interestsController,
                    maxLines: 3,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFF29382F),
                      hintText: 'What causes are you passionate about?',
                      hintStyle: const TextStyle(color: Color(0xFF9EB7A8)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Availability',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...['Weekdays', 'Weekends', 'Flexible'].map((option) => 
                    RadioListTile<String>(
                      title: Text(
                        option,
                        style: const TextStyle(color: Colors.white),
                      ),
                      value: option,
                      groupValue: _availability,
                      onChanged: (value) {
                        setState(() {
                          _availability = value;
                        });
                      },
                      activeColor: const Color(0xFF38E07B),
                    ),
                  ).toList(),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _isLoading ? null : () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileInfoScreen3(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF38E07B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
                child: const Text(
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

  @override
  void dispose() {
    _skillsController.dispose();
    _interestsController.dispose();
    super.dispose();
  }
}
