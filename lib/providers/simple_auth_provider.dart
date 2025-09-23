import 'package:flutter/material.dart';
import '../models/user.dart';
import '../data/dummy_data.dart';

class SimpleAuthProvider extends ChangeNotifier {
  User? _currentUser;
  bool _isLoggedIn = false;
  bool _isLoading = false;

  User? get currentUser => _currentUser;
  bool get isLoggedIn => _isLoggedIn;
  bool get isLoading => _isLoading;

  Future<bool> signIn(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));

      // For demo purposes, accept any email/password
      if (email.isNotEmpty && password.isNotEmpty) {
        _currentUser = DummyData.sampleUser;
        _isLoggedIn = true;
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Error signing in: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
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
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        email: email,
        fullName: fullName,
        role: role,
        profileImageUrl: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150',
        createdAt: DateTime.now(),
      );
      _isLoggedIn = true;
      return true;
    } catch (e) {
      debugPrint('Error signing up: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> signInWithGoogle() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate Google sign-in delay
      await Future.delayed(const Duration(seconds: 2));

      _currentUser = User(
        id: 'google_user_123',
        email: 'user@gmail.com',
        fullName: 'Google User',
        role: UserRole.volunteer,
        profileImageUrl: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150',
        createdAt: DateTime.now(),
      );
      _isLoggedIn = true;
      return true;
    } catch (e) {
      debugPrint('Error with Google sign-in: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    _isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(milliseconds: 500));
      _currentUser = null;
      _isLoggedIn = false;
    } catch (e) {
      debugPrint('Error signing out: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateProfile({
    String? fullName,
  }) async {
    if (_currentUser == null) return false;

    _isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(milliseconds: 500));
      
      _currentUser = _currentUser!.copyWith(
        fullName: fullName ?? _currentUser!.fullName,
        updatedAt: DateTime.now(),
      );
      
      return true;
    } catch (e) {
      debugPrint('Error updating profile: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
