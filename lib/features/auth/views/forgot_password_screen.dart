// LAYER: UI (Layer 1) — Feature: Auth
// PURPOSE: Forgot-password screen. Owns its own TextEditingController and
//          FormKey. Business logic in AuthController.
//          No loading spinner on the button — instant tap feedback only.

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../shared/constants/app_colors.dart';
import '../controller/auth_controller.dart';
import '../widgets/auth_widgets.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();

  AuthController get _ctrl => Get.find<AuthController>();

  @override
  void dispose() {
    _emailCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    _ctrl.sendPasswordReset(_emailCtrl.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: AuthShell(
        showBack: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Header ──────────────────────────────────────────────────────
            const AuthHeader(
              emoji: '🔐',
              title: 'Reset password',
              subtitle: "Enter your email and we'll send a reset link",
            ),
            const SizedBox(height: 36),

            // ── Swap between form and success card ───────────────────────────
            Obx(() {
              if (_ctrl.resetEmailSent.value) {
                return AuthSuccessCard(email: _emailCtrl.text.trim());
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Form(
                    key: _formKey,
                    child: AuthEmailField(controller: _emailCtrl),
                  ),
                  const SizedBox(height: 12),

                  // error banner
                  Obx(() => AuthErrorBanner(message: _ctrl.errorMessage.value)),
                  const SizedBox(height: 12),

                  // Send reset link button
                  Obx(
                    () => AuthPrimaryButton(
                      label: 'Send Reset Link',
                      isLoading: _ctrl.isLoading.value,
                      onTap: _submit,
                    ),
                  ),
                ],
              );
            }),
            const SizedBox(height: 32),

            // ── Back to login ────────────────────────────────────────────────
            AuthSwitchRow(
              question: 'Remember your password?',
              actionLabel: 'Sign In',
              onTap: () => Get.offAllNamed(AppRoutes.login),
            ),
          ],
        ),
      ),
    );
  }
}
