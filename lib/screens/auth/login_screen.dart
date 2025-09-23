import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/simple_auth_provider.dart';
import '../../utils/colors.dart';
import '../../utils/text_styles.dart';
import '../../utils/responsive_helper.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signInWithEmail() async {
    if (!_formKey.currentState!.validate()) return;

    final authProvider = Provider.of<SimpleAuthProvider>(context, listen: false);
    final success = await authProvider.signIn(
      _emailController.text.trim(),
      _passwordController.text,
    );

    if (!success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid email or password'),
          backgroundColor: AppColors.emergencyRed,
        ),
      );
    }
  }

  Future<void> _signInWithGoogle() async {
    final authProvider = Provider.of<SimpleAuthProvider>(context, listen: false);
    final success = await authProvider.signInWithGoogle();

    if (!success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Google sign in failed'),
          backgroundColor: AppColors.emergencyRed,
        ),
      );
    }
  }

  void _navigateToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RegisterScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: ResponsiveHelper.getScreenPadding(context),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: ResponsiveHelper.getScreenHeight(context) * 0.1),
                  _buildHeader(context),
                  const SizedBox(height: 60),
                  _buildWelcomeText(),
                  const SizedBox(height: 40),
                  _buildEmailField(),
                  const SizedBox(height: 16),
                  _buildPasswordField(),
                  const SizedBox(height: 8),
                  _buildForgotPassword(),
                  const SizedBox(height: 32),
                  _buildLoginButton(context),
                  const SizedBox(height: 16),
                  _buildRegisterButton(context),
                  const SizedBox(height: 32),
                  _buildDivider(),
                  const SizedBox(height: 32),
                  _buildGoogleButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.favorite,
          color: AppColors.primaryGreen,
          size: ResponsiveHelper.getIconSize(context, 48),
        ),
        const SizedBox(width: 12),
        Text(
          'NGO Connect',
          style: AppTextStyles.heading1.copyWith(
            fontSize: ResponsiveHelper.getResponsiveFontSize(context, 32),
          ),
        ),
      ],
    );
  }

  Widget _buildWelcomeText() {
    return Text(
      'Welcome Back',
      style: AppTextStyles.heading2,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      style: AppTextStyles.inputText,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.inputBackground,
        hintText: 'Email',
        hintStyle: AppTextStyles.inputHint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: AppColors.primaryGreen,
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
          return 'Please enter a valid email';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: _obscurePassword,
      style: AppTextStyles.inputText,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.inputBackground,
        hintText: 'Password',
        hintStyle: AppTextStyles.inputHint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: AppColors.primaryGreen,
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility : Icons.visibility_off,
            color: AppColors.textTertiary,
          ),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        if (value.length < 6) {
          return 'Password must be at least 6 characters';
        }
        return null;
      },
    );
  }

  Widget _buildForgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          // TODO: Implement forgot password
        },
        child: Text(
          'Forgot Password?',
          style: AppTextStyles.link,
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        return SizedBox(
          width: double.infinity,
          height: ResponsiveHelper.getButtonHeight(context),
          child: ElevatedButton(
            onPressed: authProvider.isLoading ? null : _signInWithEmail,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryGreen,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              elevation: 0,
            ),
            child: authProvider.isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.black,
                      strokeWidth: 2,
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Login',
                      style: AppTextStyles.buttonLarge,
                    ),
                  ),
          ),
        );
      },
    );
  }

  Widget _buildRegisterButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: ResponsiveHelper.getButtonHeight(context),
      child: OutlinedButton(
        onPressed: _navigateToRegister,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(
            color: AppColors.primaryGreen,
            width: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        child: Text(
          'Register',
          style: AppTextStyles.buttonLarge.copyWith(
            color: AppColors.primaryGreen,
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Row(
      children: [
        Expanded(
          child: Divider(color: AppColors.dividerColor),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Or continue with',
            style: AppTextStyles.bodySecondaryMedium,
          ),
        ),
        Expanded(
          child: Divider(color: AppColors.dividerColor),
        ),
      ],
    );
  }

  Widget _buildGoogleButton(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        return SizedBox(
          width: double.infinity,
          height: ResponsiveHelper.getButtonHeight(context),
          child: OutlinedButton(
            onPressed: authProvider.isLoading ? null : _signInWithGoogle,
            style: OutlinedButton.styleFrom(
              backgroundColor: AppColors.inputBackground,
              side: const BorderSide(
                color: AppColors.dividerColor,
                width: 1,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.g_mobiledata,
                  size: 24,
                  color: AppColors.textPrimary,
                ),
                const SizedBox(width: 12),
                Text(
                  'Continue with Google',
                  style: AppTextStyles.buttonLarge.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
