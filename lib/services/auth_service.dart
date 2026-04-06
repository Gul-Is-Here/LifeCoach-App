// LAYER: Services (Layer 3)
// PURPOSE: Wraps FirebaseAuth + GoogleSignIn v7 — exposes authStateChanges stream,
//          email/password, Google, and password-reset flows.
//          Controllers call these methods; screens never touch FirebaseAuth directly.

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // google_sign_in v7 uses a singleton via GoogleSignIn.instance
  final _google = GoogleSignIn.instance;

  // ── State ──────────────────────────────────────────────────────────────────
  Stream<User?> get authStateChanges => _auth.authStateChanges();
  User? get currentUser => _auth.currentUser;
  String? get uid => _auth.currentUser?.uid;

  // ── Email / Password ───────────────────────────────────────────────────────
  Future<UserCredential> signInWithEmail(String email, String password) =>
      _auth.signInWithEmailAndPassword(email: email, password: password);

  Future<UserCredential> registerWithEmail(
    String email,
    String password,
    String displayName,
  ) async {
    final cred = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await cred.user?.updateDisplayName(displayName);
    await cred.user?.sendEmailVerification();
    return cred;
  }

  Future<void> signOut() async {
    await _google.signOut();
    await _auth.signOut();
  }

  // ── Password reset ─────────────────────────────────────────────────────────
  Future<void> sendPasswordResetEmail(String email) =>
      _auth.sendPasswordResetEmail(email: email);

  // ── Google Sign-In (google_sign_in v7) ────────────────────────────────────
  Future<UserCredential?> signInWithGoogle() async {
    // v7: initialize once (safe to call multiple times — idempotent on iOS/Android)
    await _google.initialize();
    final googleUser = await _google.authenticate();
    final googleAuth = googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );
    return _auth.signInWithCredential(credential);
  }
}
