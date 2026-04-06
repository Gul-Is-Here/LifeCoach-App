// LAYER: Controller (Layer 2) — Feature: Auth
// PURPOSE: Pure business-logic controller. TextEditingControllers and
//          GlobalKey<FormState> live in each screen's State — NOT here —
//          so they are disposed with the widget and never cause
//          "used after dispose" crashes during route transitions.

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../services/auth_service.dart';

class AuthController extends GetxController {
  // ── DI ────────────────────────────────────────────────────────────────────
  final _authService = Get.find<AuthService>();

  // ── Rx state ──────────────────────────────────────────────────────────────
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final resetEmailSent = false.obs;

  // ── Sign In ───────────────────────────────────────────────────────────────
  Future<void> signIn(String email, String password) async {
    _start();
    try {
      await _authService.signInWithEmail(email, password);
      Get.offAllNamed(AppRoutes.dashboard);
    } on FirebaseAuthException catch (e) {
      errorMessage.value = _friendly(e.code);
    } catch (_) {
      errorMessage.value = 'Something went wrong. Please try again.';
    } finally {
      _stop();
    }
  }

  // ── Register ──────────────────────────────────────────────────────────────
  Future<void> register(
    String email,
    String password,
    String displayName,
  ) async {
    _start();
    try {
      await _authService.registerWithEmail(email, password, displayName);
      Get.offAllNamed(AppRoutes.dashboard);
    } on FirebaseAuthException catch (e) {
      errorMessage.value = _friendly(e.code);
    } catch (_) {
      errorMessage.value = 'Something went wrong. Please try again.';
    } finally {
      _stop();
    }
  }

  // ── Google Sign In ────────────────────────────────────────────────────────
  Future<void> signInWithGoogle() async {
    _start();
    try {
      final result = await _authService.signInWithGoogle();
      if (result != null) Get.offAllNamed(AppRoutes.dashboard);
    } on FirebaseAuthException catch (e) {
      errorMessage.value = _friendly(e.code);
    } catch (_) {
      errorMessage.value = 'Google sign-in failed. Please try again.';
    } finally {
      _stop();
    }
  }

  // ── Forgot Password ───────────────────────────────────────────────────────
  Future<void> sendPasswordReset(String email) async {
    _start();
    try {
      await _authService.sendPasswordResetEmail(email);
      resetEmailSent.value = true;
      errorMessage.value = '';
    } on FirebaseAuthException catch (e) {
      errorMessage.value = _friendly(e.code);
    } catch (_) {
      errorMessage.value = 'Something went wrong. Please try again.';
    } finally {
      _stop();
    }
  }

  // ── Sign Out ──────────────────────────────────────────────────────────────
  Future<void> signOut() async {
    await _authService.signOut();
    Get.offAllNamed(AppRoutes.login);
  }

  // ── Helpers ───────────────────────────────────────────────────────────────
  void clearError() => errorMessage.value = '';
  void _start() {
    errorMessage.value = '';
    isLoading.value = true;
  }

  void _stop() => isLoading.value = false;

  String _friendly(String code) {
    switch (code) {
      case 'user-not-found':
        return 'No account found with this email.';
      case 'wrong-password':
      case 'invalid-credential':
        return 'Incorrect email or password.';
      case 'email-already-in-use':
        return 'This email is already registered.';
      case 'weak-password':
        return 'Password must be at least 6 characters.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'too-many-requests':
        return 'Too many attempts. Please wait and try again.';
      case 'network-request-failed':
        return 'No internet connection.';
      default:
        return 'Authentication failed. Please try again.';
    }
  }
}
