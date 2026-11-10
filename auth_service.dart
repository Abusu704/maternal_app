import 'package:flutter/material.dart';

class AuthService {
  // ==================== MOCK AUTH (bypasses Supabase for testing) ====================

  String? _mockEmail;
  bool _isSignedIn = false;

  /// "Sign in" without any real authentication - just stores the email
  Future<bool> signInWithEmail(String email, String password) async {
    _mockEmail = email;
    _isSignedIn = true;
    debugPrint('Mock sign in as: $email');
    return true;
  }

  Future<bool> signUpWithEmail(
    String email,
    String password, {
    String? name,
  }) async {
    _mockEmail = email;
    _isSignedIn = true;
    debugPrint('Mock sign up as: $email');
    return true;
  }

  String? get currentUserEmail => _mockEmail;
  bool get isSignedIn => _isSignedIn;

  Future<void> signOut() async {
    _mockEmail = null;
    _isSignedIn = false;
  }
}