import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/simple_auth_provider.dart';
import 'providers/opportunity_provider.dart';
import 'screens/auth/login_screen.dart';
import 'screens/main_screen.dart';
import 'utils/colors.dart';

void main() {
  runApp(const NGOConnectApp());
}

class NGOConnectApp extends StatelessWidget {
  const NGOConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SimpleAuthProvider()),
        ChangeNotifierProvider(create: (_) => OpportunityProvider()),
      ],
      child: MaterialApp(
        title: 'NGO Connect',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
          scaffoldBackgroundColor: AppColors.backgroundColor,
          fontFamily: 'Inter',
        ),
        home: const AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SimpleAuthProvider>(
      builder: (context, authProvider, child) {
        if (authProvider.isLoading) {
          return Scaffold(
            backgroundColor: AppColors.backgroundColor,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: AppColors.primaryGreen,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Loading...',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        if (!authProvider.isLoggedIn) {
          return const LoginScreen();
        }

        return const MainScreen();
      },
    );
  }
}
