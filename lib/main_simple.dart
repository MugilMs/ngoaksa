import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
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
        ChangeNotifierProvider(create: (_) => AuthProvider()),
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
        home: const SimpleAuthWrapper(),
      ),
    );
  }
}

class SimpleAuthWrapper extends StatelessWidget {
  const SimpleAuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        // For demo purposes, show login screen initially
        if (!authProvider.isLoggedIn) {
          return const LoginScreen();
        }
        return const MainScreen();
      },
    );
  }
}
