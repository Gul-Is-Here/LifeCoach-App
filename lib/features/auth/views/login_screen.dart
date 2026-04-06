// LAYER: UI (Layer 1) — Feature: Auth
// PURPOSE: Login screen. Owns its own TextEditingControllers and FormKey.
//          Business logic delegated to AuthController via Get.find().
//          No loading spinner on the button — instant tap feedback only.

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../shared/constants/app_colors.dart';
import '../controller/auth_controller.dart';
import '../widgets/auth_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _passwordVisible = false;

  AuthController get _ctrl => Get.find<AuthController>();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    _ctrl.signIn(_emailCtrl.text.trim(), _passwordCtrl.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: AuthShell(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Header ──────────────────────────────────────────────────────
            const AuthHeader(
              emoji: '👋',
              title: 'Welcome back',
              subtitle: 'Sign in to continue your journey',
            ),
            const SizedBox(height: 36),

            // ── Form ─────────────────────────────────────────────────────────
            Form(
              key: _formKey,
              child: Column(
                children: [
                  AuthEmailField(controller: _emailCtrl),
                  const SizedBox(height: 16),
                  StatefulBuilder(
                    builder: (_, setS) => AuthPasswordField(
                      controller: _passwordCtrl,
                      label: 'Password',
                      visible: _passwordVisible,
                      onToggle: () =>
                          setS(() => _passwordVisible = !_passwordVisible),
                    ),
                  ),
                ],
              ),
            ),

            // ── Forgot password link ─────────────────────────────────────────
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Get.toNamed(AppRoutes.forgotPassword),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.primaryLight,
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  'Forgot password?',
                  style: TextStyle(fontSize: 13),
                ),
              ),
            ),
            const SizedBox(height: 8),

            // ── Error banner ─────────────────────────────────────────────────
            Obx(() => AuthErrorBanner(message: _ctrl.errorMessage.value)),
            const SizedBox(height: 8),

            // ── Sign in button ───────────────────────────────────────────
            Obx(
              () => AuthPrimaryButton(
                label: 'Sign In',
                isLoading: _ctrl.isLoading.value,
                onTap: _submit,
              ),
            ),
            const SizedBox(height: 20),

            // ── Google ───────────────────────────────────────────────────────
            const AuthOrDivider(),
            const SizedBox(height: 20),
            AuthGoogleButton(onTap: _ctrl.signInWithGoogle),
            const SizedBox(height: 32),

            // ── Switch to Register ───────────────────────────────────────────
            AuthSwitchRow(
              question: "Don't have an account?",
              actionLabel: 'Sign Up',
              onTap: () => Get.offNamed(AppRoutes.register),
            ),
          ],
        ),
      ),
    );
  }
}
