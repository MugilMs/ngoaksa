import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../models/user.dart';
import '../../utils/colors.dart';
import '../../utils/text_styles.dart';
import '../../utils/responsive_helper.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _acceptTerms = false;
  UserRole _selectedRole = UserRole.volunteer;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    
    if (!_acceptTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please accept the terms and conditions'),
          backgroundColor: AppColors.emergencyRed,
        ),
      );
      return;
    }

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final success = await authProvider.signUp(
      email: _emailController.text.trim(),
      password: _passwordController.text,
      fullName: _nameController.text.trim(),
      role: _selectedRole,
    );

    if (!success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registration failed. Please try again.'),
          backgroundColor: AppColors.emergencyRed,
        ),
      );
    }
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
                  const SizedBox(height: 40),
                  _buildHeader(context),
                  const SizedBox(height: 40),
                  _buildCreateAccountText(),
                  const SizedBox(height: 32),
                  _buildNameField(),
                  const SizedBox(height: 16),
                  _buildEmailField(),
                  const SizedBox(height: 16),
                  _buildPasswordField(),
                  const SizedBox(height: 16),
                  _buildConfirmPasswordField(),
                  const SizedBox(height: 24),
                  _buildRoleSelection(),
                  const SizedBox(height: 24),
                  _buildTermsCheckbox(),
                  const SizedBox(height: 32),
                  _buildRegisterButton(context),
                  const SizedBox(height: 16),
                  _buildLoginLink(),
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
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.textPrimary,
          ),
        ),
        const Spacer(),
        Icon(
          Icons.favorite,
          color: AppColors.primaryGreen,
          size: ResponsiveHelper.getIconSize(context, 32),
        ),
        const SizedBox(width: 8),
        Text(
          'NGO Connect',
          style: AppTextStyles.heading3.copyWith(
            fontSize: ResponsiveHelper.getResponsiveFontSize(context, 24),
          ),
        ),
        const Spacer(),
        const SizedBox(width: 48), // Balance the back button
      ],
    );
  }

  Widget _buildCreateAccountText() {
    return Column(
      children: [
        Text(
          'Create Account',
          style: AppTextStyles.heading2,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Join our community and make a difference',
          style: AppTextStyles.bodySecondary,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      controller: _nameController,
      style: AppTextStyles.inputText,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.inputBackground,
        hintText: 'Full Name',
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
        if (value == null || value.trim().isEmpty) {
          return 'Please enter your full name';
        }
        if (value.trim().length < 2) {
          return 'Name must be at least 2 characters';
        }
        return null;
      },
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
          return 'Please enter a password';
        }
        if (value.length < 6) {
          return 'Password must be at least 6 characters';
        }
        return null;
      },
    );
  }

  Widget _buildConfirmPasswordField() {
    return TextFormField(
      controller: _confirmPasswordController,
      obscureText: _obscureConfirmPassword,
      style: AppTextStyles.inputText,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.inputBackground,
        hintText: 'Confirm Password',
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
            _obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
            color: AppColors.textTertiary,
          ),
          onPressed: () {
            setState(() {
              _obscureConfirmPassword = !_obscureConfirmPassword;
            });
          },
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please confirm your password';
        }
        if (value != _passwordController.text) {
          return 'Passwords do not match';
        }
        return null;
      },
    );
  }

  Widget _buildRoleSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Your Role',
          style: AppTextStyles.heading4,
        ),
        const SizedBox(height: 12),
        ...UserRole.values.map((role) => _buildRoleOption(role)),
      ],
    );
  }

  Widget _buildRoleOption(UserRole role) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedRole = role;
          });
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _selectedRole == role 
                ? AppColors.primaryGreenOpacity10 
                : AppColors.inputBackground,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _selectedRole == role 
                  ? AppColors.primaryGreen 
                  : AppColors.dividerColor,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                _selectedRole == role 
                    ? Icons.radio_button_checked 
                    : Icons.radio_button_unchecked,
                color: _selectedRole == role 
                    ? AppColors.primaryGreen 
                    : AppColors.textTertiary,
              ),
              const SizedBox(width: 12),
              Text(
                role.displayName,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: _selectedRole == role 
                      ? AppColors.primaryGreen 
                      : AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTermsCheckbox() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          value: _acceptTerms,
          onChanged: (value) {
            setState(() {
              _acceptTerms = value ?? false;
            });
          },
          activeColor: AppColors.primaryGreen,
          checkColor: Colors.black,
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _acceptTerms = !_acceptTerms;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: RichText(
                text: TextSpan(
                  style: AppTextStyles.bodySecondaryMedium,
                  children: [
                    const TextSpan(text: 'I agree to the '),
                    TextSpan(
                      text: 'Terms and Conditions',
                      style: AppTextStyles.link,
                    ),
                    const TextSpan(text: ' and '),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: AppTextStyles.link,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterButton(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        return SizedBox(
          width: double.infinity,
          height: ResponsiveHelper.getButtonHeight(context),
          child: ElevatedButton(
            onPressed: authProvider.isLoading ? null : _register,
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
                : Text(
                    'Create Account',
                    style: AppTextStyles.buttonLarge,
                  ),
          ),
        );
      },
    );
  }

  Widget _buildLoginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account? ',
          style: AppTextStyles.bodySecondaryMedium,
        ),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Text(
            'Login',
            style: AppTextStyles.link,
          ),
        ),
      ],
    );
  }
}
