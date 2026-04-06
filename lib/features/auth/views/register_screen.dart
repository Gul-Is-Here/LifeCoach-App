// LAYER: UI (Layer 1) — Feature: Auth
// PURPOSE: Register / Sign-up screen. Owns its own TextEditingControllers,
//          FormKey and visibility bools. Business logic in AuthController.
//          No loading spinner on the button — instant tap feedback only.

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../shared/constants/app_colors.dart';
import '../controller/auth_controller.dart';
import '../widgets/auth_widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _passwordVisible = false;
  bool _confirmVisible = false;

  AuthController get _ctrl => Get.find<AuthController>();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    _ctrl.register(
      _emailCtrl.text.trim(),
      _passwordCtrl.text,
      _nameCtrl.text.trim(),
    );
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
              emoji: '🚀',
              title: 'Create account',
              subtitle: 'Start your coaching journey today',
            ),
            const SizedBox(height: 32),

            // ── Form ─────────────────────────────────────────────────────────
            Form(
              key: _formKey,
              child: Column(
                children: [
                  AuthNameField(controller: _nameCtrl),
                  const SizedBox(height: 16),
                  AuthEmailField(controller: _emailCtrl),
                  const SizedBox(height: 16),
                  StatefulBuilder(
                    builder: (_, setS) => AuthPasswordField(
                      controller: _passwordCtrl,
                      label: 'Password',
                      visible: _passwordVisible,
                      onToggle: () =>
                          setS(() => _passwordVisible = !_passwordVisible),
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Enter a password';
                        if (v.length < 6) return 'Minimum 6 characters';
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  StatefulBuilder(
                    builder: (_, setS) => AuthPasswordField(
                      controller: _confirmCtrl,
                      label: 'Confirm Password',
                      visible: _confirmVisible,
                      onToggle: () =>
                          setS(() => _confirmVisible = !_confirmVisible),
                      validator: (v) {
                        if (v != _passwordCtrl.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // ── Error banner ─────────────────────────────────────────────────
            Obx(() => AuthErrorBanner(message: _ctrl.errorMessage.value)),
            const SizedBox(height: 8),

            // ── Create account button ────────────────────────────────────
            Obx(
              () => AuthPrimaryButton(
                label: 'Create Account',
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

            // ── Switch to Login ──────────────────────────────────────────────
            AuthSwitchRow(
              question: 'Already have an account?',
              actionLabel: 'Sign In',
              onTap: () => Get.offNamed(AppRoutes.login),
            ),
          ],
        ),
      ),
    );
  }
}
