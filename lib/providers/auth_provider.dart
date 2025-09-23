import 'package:flutter/material.dart';
import '../models/user.dart';
import '../data/dummy_data.dart';

class AuthProvider extends ChangeNotifier {
  User? _currentUser;
  bool _isLoggedIn = false;
  bool _isLoading = false;

  User? get currentUser => _currentUser;
  bool get isLoggedIn => _isLoggedIn;
  bool get isLoading => _isLoading;

  AuthProvider() {
    _loadAuthState();
  }

  Future<void> _loadAuthState() async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      
      if (_isLoggedIn) {
        // Load user data from preferences or use dummy data
        _currentUser = DummyData.sampleUser;
      }
    } catch (e) {
      debugPrint('Error loading auth state: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _loadUserData() async {
    // Simulate loading user data for demo
    await Future.delayed(const Duration(milliseconds: 500));
    // For demo purposes, we'll keep user logged out initially
    _isLoggedIn = false;
    _currentUser = null;
    notifyListeners();
  }

  Future<void> _saveUserData() async {
    // Simulate saving user data for demo
    await Future.delayed(const Duration(milliseconds: 100));
    debugPrint('User data saved (demo mode)');
  }

  Future<bool> signIn(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));

      // For demo purposes, accept any email/password
      if (email.isNotEmpty && password.isNotEmpty) {
        _currentUser = DummyData.sampleUser.copyWith(email: email);
        _isLoggedIn = true;
        
        // Save auth state
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('userEmail', email);
        
        _isLoading = false;
        notifyListeners();
        return true;
      }
      
      _isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      debugPrint('Sign in error: $e');
      return false;
    }
  }

  Future<bool> signUp({
    required String email,
    required String password,
    required String fullName,
    required UserRole role,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));

      // Create new user
      _currentUser = User(
        id: 'user_${DateTime.now().millisecondsSinceEpoch}',
        email: email,
        fullName: fullName,
        role: role,
        createdAt: DateTime.now(),
      );
      _isLoggedIn = true;
      
      // Save auth state
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('userEmail', email);
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      debugPrint('Sign up error: $e');
      return false;
    }
  }

  Future<bool> signInWithGoogle() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate Google sign in delay
      await Future.delayed(const Duration(seconds: 2));

      // For demo purposes, create a Google user
      _currentUser = DummyData.sampleUser.copyWith(
        email: 'google.user@gmail.com',
        fullName: 'Google User',
      );
      _isLoggedIn = true;
      
      // Save auth state
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('userEmail', 'google.user@gmail.com');
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      debugPrint('Google sign in error: $e');
      return false;
    }
  }

  Future<void> signOut() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Clear auth state
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      
      _currentUser = null;
      _isLoggedIn = false;
    } catch (e) {
      debugPrint('Sign out error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateProfile({
    String? fullName,
    String? profileImageUrl,
  }) async {
    if (_currentUser == null) return;

    try {
      _currentUser = _currentUser!.copyWith(
        fullName: fullName ?? _currentUser!.fullName,
        profileImageUrl: profileImageUrl ?? _currentUser!.profileImageUrl,
        updatedAt: DateTime.now(),
      );
      notifyListeners();
    } catch (e) {
      debugPrint('Update profile error: $e');
    }
  }
}
