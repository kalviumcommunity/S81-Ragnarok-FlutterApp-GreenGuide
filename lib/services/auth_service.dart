import 'package:firebase_auth/firebase_auth.dart';

/// Firebase Authentication Service
/// Handles user signup, login, logout, and session persistence.
/// 
/// This service provides a clean abstraction over Firebase Auth,
/// making it easy to integrate authentication throughout the app.
class AuthService {
  static final AuthService _instance = AuthService._internal();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Private constructor for singleton pattern
  AuthService._internal();

  /// Factory constructor to return singleton instance
  factory AuthService() {
    return _instance;
  }

  /// Get current authenticated user
  User? get currentUser => _auth.currentUser;

  /// Get current user UID
  String? get currentUserId => _auth.currentUser?.uid;

  /// Check if user is logged in
  bool get isLoggedIn => _auth.currentUser != null;

  /// Stream of authentication state changes
  /// Useful for listening to login/logout events
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// Sign up with email and password
  /// 
  /// Returns:
  /// - UserCredential on success
  /// - Throws FirebaseAuthException on failure
  /// 
  /// Failure reasons:
  /// - weak-password: Password is not strong enough
  /// - email-already-in-use: Account with this email exists
  /// - invalid-email: Email format is invalid
  Future<UserCredential> signUp({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  /// Login with email and password
  /// 
  /// Returns:
  /// - UserCredential on success
  /// - Throws FirebaseAuthException on failure
  /// 
  /// Failure reasons:
  /// - user-not-found: No account with this email
  /// - wrong-password: Incorrect password
  /// - invalid-email: Email format is invalid
  /// - user-disabled: User account has been disabled
  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  /// Logout current user
  /// 
  /// This clears the session and sets currentUser to null.
  /// User will be redirected to LoginScreen.
  Future<void> logout() async {
    await _auth.signOut();
  }

  /// Reset password for email
  /// 
  /// Sends a password reset email to the user.
  /// User will click link in email to set new password.
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  /// Delete current user account
  /// 
  /// WARNING: This is permanent and cannot be undone.
  /// Requires recent authentication (user must have logged in recently).
  Future<void> deleteAccount() async {
    try {
      await _auth.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  /// Handle Firebase Auth exceptions
  /// Converts Firebase error codes to readable messages
  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return 'Password is too weak. Use 6+ characters.';
      case 'email-already-in-use':
        return 'Email already registered. Try logging in.';
      case 'invalid-email':
        return 'Invalid email format.';
      case 'user-not-found':
        return 'No account found with this email.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'user-disabled':
        return 'User account has been disabled.';
      case 'operation-not-allowed':
        return 'Operation not allowed. Contact support.';
      case 'too-many-requests':
        return 'Too many failed attempts. Try again later.';
      default:
        return 'Authentication error: ${e.message}';
    }
  }
}
