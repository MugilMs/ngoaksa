import 'package:flutter/material.dart';
import 'registration_screen.dart';
import 'main_app_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _signInWithEmail() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate login delay
    await Future.delayed(const Duration(seconds: 1));

    // For demo purposes, navigate directly to main app
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const MainAppScreen(),
      ),
    );

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _signInWithGoogle() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate Google login delay
    await Future.delayed(const Duration(seconds: 1));

    // For demo purposes, navigate directly to main app
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const MainAppScreen(),
      ),
    );

    setState(() {
      _isLoading = false;
    });
  }

  void _navigateToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RegistrationScreen(),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.favorite,
                  color: Color(0xFF38E07B),
                  size: 48,
                ),
                const SizedBox(width: 8),
                const Text(
                  'NGO Connect',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            const Text(
              'Welcome Back',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF29382F),
                hintText: 'Email',
                hintStyle: const TextStyle(color: Color(0xFF9EB7A8)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF29382F),
                hintText: 'Password',
                hintStyle: const TextStyle(color: Color(0xFF9EB7A8)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 8),
            const Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Forgot Password?',
                style: TextStyle(
                  color: Color(0xFF38E07B),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _signInWithEmail,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF38E07B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.black,
                        strokeWidth: 2,
                      )
                    : const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _navigateToRegister,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF29382F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: const Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Row(
              children: [
                Expanded(child: Divider(color: Color(0xFF374A3F))),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Or continue with',
                    style: TextStyle(color: Color(0xFF9EB7A8)),
                  ),
                ),
                Expanded(child: Divider(color: Color(0xFF374A3F))),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _signInWithGoogle,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF29382F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.g_mobiledata, size: 24, color: Colors.white),
                    const SizedBox(width: 8),
                    const Text(
                      'Continue with Google',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
