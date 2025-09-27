import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user.dart' as app_user;
import '../data/dummy_data.dart';

class AuthProvider extends ChangeNotifier {
  app_user.User? _currentUser;
  bool _isLoggedIn = false;
  bool _isLoading = false;

  app_user.User? get currentUser => _currentUser;
  bool get isLoggedIn => _isLoggedIn;
  bool get isLoading => _isLoading;

  AuthProvider() {
    _loadUserData();
    _setupAuthListener();
  }

  void _setupAuthListener() {
    Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      final AuthChangeEvent event = data.event;
      final Session? session = data.session;
      
      debugPrint('Auth state changed: $event');
      
      if (event == AuthChangeEvent.signedIn && session?.user != null) {
        _handleSignedIn(session!.user);
      } else if (event == AuthChangeEvent.signedOut) {
        _handleSignedOut();
      }
    });
  }

  Future<void> _handleSignedIn(User user) async {
    try {
      // Try to fetch user profile, but don't fail if table doesn't exist
      Map<String, dynamic>? userProfile;
      try {
        userProfile = await Supabase.instance.client
            .from('users')
            .select()
            .eq('id', user.id)
            .maybeSingle();
      } catch (e) {
        debugPrint('Users table not found or error fetching profile: $e');
        userProfile = null;
      }

      if (userProfile != null) {
        // User profile exists
        final profile = userProfile as Map<String, dynamic>;
        _currentUser = app_user.User(
          id: user.id,
          email: profile['email'] ?? user.email ?? '',
          fullName: profile['full_name'] ?? 'User',
          role: app_user.UserRole.values.firstWhere(
            (role) => role.name == (profile['role'] ?? 'volunteer'),
            orElse: () => app_user.UserRole.volunteer,
          ),
          createdAt: DateTime.tryParse(profile['created_at'] ?? '') ?? DateTime.now(),
          profileImageUrl: profile['profile_image_url'],
        );
      } else {
        // Create user profile from auth metadata or use defaults
        final metadata = user.userMetadata;
        final fullName = metadata?['full_name'] ?? user.email?.split('@')[0] ?? 'New User';
        final role = metadata?['role'] ?? 'volunteer';
        
        // Try to create user profile, but don't fail if table doesn't exist
        try {
          await Supabase.instance.client.from('users').insert({
            'id': user.id,
            'email': user.email,
            'full_name': fullName,
            'role': role,
            'profile_image_url': DummyData.sampleUser.profileImageUrl,
          });
        } catch (e) {
          debugPrint('Could not create user profile (table may not exist): $e');
        }

        _currentUser = app_user.User(
          id: user.id,
          email: user.email ?? '',
          fullName: fullName,
          role: app_user.UserRole.values.firstWhere(
            (r) => r.name == role,
            orElse: () => app_user.UserRole.volunteer,
          ),
          createdAt: DateTime.now(),
          profileImageUrl: DummyData.sampleUser.profileImageUrl,
        );
      }
      
      _isLoggedIn = true;
      notifyListeners();
    } catch (e) {
      debugPrint('Error handling signed in user: $e');
      // Even if there's an error, create a basic user profile from auth data
      _currentUser = app_user.User(
        id: user.id,
        email: user.email ?? '',
        fullName: user.email?.split('@')[0] ?? 'User',
        role: app_user.UserRole.volunteer,
        createdAt: DateTime.now(),
        profileImageUrl: DummyData.sampleUser.profileImageUrl,
      );
      _isLoggedIn = true;
      notifyListeners();
    }
  }

  void _handleSignedOut() {
    _currentUser = null;
    _isLoggedIn = false;
    notifyListeners();
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<void> _loadUserData() async {
    _setLoading(true);
    
    try {
      // Check if user is already logged in with Supabase
      final session = Supabase.instance.client.auth.currentSession;
      
      if (session?.user != null) {
        // Try to fetch user profile from the users table
        try {
          final userProfile = await Supabase.instance.client
              .from('users')
              .select()
              .eq('id', session!.user.id)
              .maybeSingle();

          if (userProfile != null) {
            // Create local user object
            final profile = userProfile as Map<String, dynamic>;
            _currentUser = app_user.User(
              id: session.user.id,
              email: profile['email'] ?? session.user.email ?? '',
              fullName: profile['full_name'] ?? 'User',
              role: app_user.UserRole.values.firstWhere(
                (role) => role.name == (profile['role'] ?? 'volunteer'),
                orElse: () => app_user.UserRole.volunteer,
              ),
              createdAt: DateTime.tryParse(profile['created_at'] ?? '') ?? DateTime.now(),
              profileImageUrl: profile['profile_image_url'],
            );
          } else {
            // Create basic user from session data
            _currentUser = app_user.User(
              id: session.user.id,
              email: session.user.email ?? '',
              fullName: session.user.email?.split('@')[0] ?? 'User',
              role: app_user.UserRole.volunteer,
              createdAt: DateTime.now(),
              profileImageUrl: DummyData.sampleUser.profileImageUrl,
            );
          }
        } catch (e) {
          debugPrint('Error fetching user profile, using session data: $e');
          // Create basic user from session data
          _currentUser = app_user.User(
            id: session!.user.id,
            email: session.user.email ?? '',
            fullName: session.user.email?.split('@')[0] ?? 'User',
            role: app_user.UserRole.volunteer,
            createdAt: DateTime.now(),
            profileImageUrl: DummyData.sampleUser.profileImageUrl,
          );
        }
        
        _isLoggedIn = true;
      } else {
        _isLoggedIn = false;
        _currentUser = null;
      }
    } catch (e) {
      debugPrint('Error loading user data: $e');
      // Ensure we're in a safe state even if loading fails
      _isLoggedIn = false;
      _currentUser = null;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _saveUserData() async {
    await Future.delayed(const Duration(milliseconds: 100));
    debugPrint('User data saved (demo mode)');
  }

  Future<bool> signIn(String email, String password) async {
    _setLoading(true);
    
    try {
      // Sign in with Supabase Auth
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user != null) {
        // Try to fetch user profile from the users table
        try {
          final userProfile = await Supabase.instance.client
              .from('users')
              .select()
              .eq('id', response.user!.id)
              .maybeSingle();

          if (userProfile != null) {
            // Create local user object
            final profile = userProfile as Map<String, dynamic>;
            _currentUser = app_user.User(
              id: response.user!.id,
              email: profile['email'] ?? response.user!.email ?? '',
              fullName: profile['full_name'] ?? 'User',
              role: app_user.UserRole.values.firstWhere(
                (role) => role.name == (profile['role'] ?? 'volunteer'),
                orElse: () => app_user.UserRole.volunteer,
              ),
              createdAt: DateTime.tryParse(profile['created_at'] ?? '') ?? DateTime.now(),
              profileImageUrl: profile['profile_image_url'],
            );
          } else {
            // Create basic user from auth response
            _currentUser = app_user.User(
              id: response.user!.id,
              email: response.user!.email ?? '',
              fullName: response.user!.email?.split('@')[0] ?? 'User',
              role: app_user.UserRole.volunteer,
              createdAt: DateTime.now(),
              profileImageUrl: DummyData.sampleUser.profileImageUrl,
            );
          }
        } catch (e) {
          debugPrint('Error fetching user profile, using auth data: $e');
          // Create basic user from auth response
          _currentUser = app_user.User(
            id: response.user!.id,
            email: response.user!.email ?? '',
            fullName: response.user!.email?.split('@')[0] ?? 'User',
            role: app_user.UserRole.volunteer,
            createdAt: DateTime.now(),
            profileImageUrl: DummyData.sampleUser.profileImageUrl,
          );
        }
        
        _isLoggedIn = true;
        await _saveUserData();
        return true;
      }
      
      return false;
    } catch (e) {
      debugPrint('Sign in error: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> signUp({
    required String email,
    required String password,
    required String fullName,
    required app_user.UserRole role,
  }) async {
    _setLoading(true);

    try {
      // Sign up with Supabase Auth including metadata
      final response = await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
        data: {
          'full_name': fullName,
          'role': role.name,
        },
      );

      if (response.user != null) {
        // Check if email confirmation is required
        if (response.session == null) {
          // Email confirmation required
          debugPrint('Email confirmation required for: $email');
          return true; // Return true but don't set as logged in yet
        }

        // If we have a session, try to create/update the user profile
        try {
          await Supabase.instance.client.from('users').upsert({
            'id': response.user!.id,
            'email': email,
            'full_name': fullName,
            'role': role.name,
            'profile_image_url': DummyData.sampleUser.profileImageUrl,
          });
        } catch (profileError) {
          debugPrint('Profile creation error (will retry): $profileError');
          // Don't fail registration if profile creation fails - it might be handled by trigger
        }

        // Create local user object
        _currentUser = app_user.User(
          id: response.user!.id,
          email: email,
          fullName: fullName,
          role: role,
          createdAt: DateTime.now(),
          profileImageUrl: DummyData.sampleUser.profileImageUrl,
        );
        
        _isLoggedIn = true;
        await _saveUserData();
        return true;
      }
      
      return false;
    } catch (e) {
      debugPrint('Sign up error: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> signInWithGoogle() async {
    _setLoading(true);
    
    try {
      // Simulate Google sign in
      await Future.delayed(const Duration(seconds: 1));
      
      _currentUser = app_user.User(
        id: 'google_${DateTime.now().millisecondsSinceEpoch}',
        email: 'user@gmail.com',
        fullName: 'Google User',
        role: app_user.UserRole.volunteer,
        createdAt: DateTime.now(),
        profileImageUrl: DummyData.sampleUser.profileImageUrl,
      );
      
      _isLoggedIn = true;
      await _saveUserData();
      return true;
    } catch (e) {
      debugPrint('Google sign in error: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signOut() async {
    _setLoading(true);
    
    try {
      await Supabase.instance.client.auth.signOut();
      _currentUser = null;
      _isLoggedIn = false;
      await _saveUserData();
    } catch (e) {
      debugPrint('Sign out error: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> updateProfile({
    String? fullName,
    String? profileImageUrl,
  }) async {
    if (_currentUser == null) return false;
    
    _setLoading(true);
    
    try {
      await Future.delayed(const Duration(seconds: 1));
      
      _currentUser = app_user.User(
        id: _currentUser!.id,
        email: _currentUser!.email,
        fullName: fullName ?? _currentUser!.fullName,
        profileImageUrl: profileImageUrl ?? _currentUser!.profileImageUrl,
        role: _currentUser!.role,
        createdAt: _currentUser!.createdAt,
      );
      
      await _saveUserData();
      return true;
    } catch (e) {
      debugPrint('Update profile error: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }
}
