// // LAYER: UI (Layer 1) — Feature: Auth
// // PURPOSE: Three screens — Login, Register, ForgotPassword.
// //          Each is a StatefulWidget that owns its own TextEditingControllers
// //          and FormKey and disposes them in dispose() — never in GetxController.
// //          Business logic (Firebase calls) lives in AuthController.

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../app/routes/app_routes.dart';
// import '../../shared/constants/app_colors.dart';
// import '../../shared/constants/app_sizes.dart';
// import 'controller/auth_controller.dart';

// // ═══════════════════════════════════════════════════════════════════════════════
// // LOGIN SCREEN
// // ═══════════════════════════════════════════════════════════════════════════════
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _emailCtrl = TextEditingController();
//   final _passwordCtrl = TextEditingController();
//   bool _passwordVisible = false;

//   AuthController get _ctrl => Get.find<AuthController>();

//   @override
//   void dispose() {
//     _emailCtrl.dispose();
//     _passwordCtrl.dispose();
//     super.dispose();
//   }

//   void _submit() {
//     if (!_formKey.currentState!.validate()) return;
//     _ctrl.signIn(_emailCtrl.text.trim(), _passwordCtrl.text);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.backgroundDark,
//       body: _AuthShell(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             const _AuthHeader(
//               emoji: '👋',
//               title: 'Welcome back',
//               subtitle: 'Sign in to continue your journey',
//             ),
//             const SizedBox(height: 36),
//             Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   _EmailField(controller: _emailCtrl),
//                   const SizedBox(height: 16),
//                   StatefulBuilder(
//                     builder: (_, setS) => _PasswordField(
//                       controller: _passwordCtrl,
//                       label: 'Password',
//                       visible: _passwordVisible,
//                       onToggle: () =>
//                           setS(() => _passwordVisible = !_passwordVisible),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Align(
//               alignment: Alignment.centerRight,
//               child: TextButton(
//                 onPressed: () => Get.toNamed(AppRoutes.forgotPassword),
//                 style: TextButton.styleFrom(
//                   foregroundColor: AppColors.primaryLight,
//                   padding: EdgeInsets.zero,
//                   tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                 ),
//                 child: const Text('Forgot password?',
//                     style: TextStyle(fontSize: 13)),
//               ),
//             ),
//             const SizedBox(height: 8),
//             Obx(() => _ErrorBanner(message: _ctrl.errorMessage.value)),
//             const SizedBox(height: 8),
//             Obx(() => _PrimaryButton(
//                   label: 'Sign In',
//                   isLoading: _ctrl.isLoading.value,
//                   onTap: _submit,
//                 )),
//             const SizedBox(height: 20),
//             const _OrDivider(),
//             const SizedBox(height: 20),
//             _GoogleButton(onTap: _ctrl.signInWithGoogle),
//             const SizedBox(height: 32),
//             _SwitchAuthRow(
//               question: "Don't have an account?",
//               actionLabel: 'Sign Up',
//               onTap: () => Get.offNamed(AppRoutes.register),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // ═══════════════════════════════════════════════════════════════════════════════
// // REGISTER SCREEN
// // ═══════════════════════════════════════════════════════════════════════════════
// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({super.key});
//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameCtrl = TextEditingController();
//   final _emailCtrl = TextEditingController();
//   final _passwordCtrl = TextEditingController();
//   final _confirmCtrl = TextEditingController();
//   bool _passwordVisible = false;
//   bool _confirmVisible = false;

//   AuthController get _ctrl => Get.find<AuthController>();

//   @override
//   void dispose() {
//     _nameCtrl.dispose();
//     _emailCtrl.dispose();
//     _passwordCtrl.dispose();
//     _confirmCtrl.dispose();
//     super.dispose();
//   }

//   void _submit() {
//     if (!_formKey.currentState!.validate()) return;
//     _ctrl.register(
//       _emailCtrl.text.trim(),
//       _passwordCtrl.text,
//       _nameCtrl.text.trim(),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.backgroundDark,
//       body: _AuthShell(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             const _AuthHeader(
//               emoji: '🚀',
//               title: 'Create account',
//               subtitle: 'Start your coaching journey today',
//             ),
//             const SizedBox(height: 32),
//             Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   _NameField(controller: _nameCtrl),
//                   const SizedBox(height: 16),
//                   _EmailField(controller: _emailCtrl),
//                   const SizedBox(height: 16),
//                   StatefulBuilder(
//                     builder: (_, setS) => _PasswordField(
//                       controller: _passwordCtrl,
//                       label: 'Password',
//                       visible: _passwordVisible,
//                       onToggle: () =>
//                           setS(() => _passwordVisible = !_passwordVisible),
//                       validator: (v) {
//                         if (v == null || v.isEmpty) return 'Enter a password';
//                         if (v.length < 6) return 'Minimum 6 characters';
//                         return null;
//                       },
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   StatefulBuilder(
//                     builder: (_, setS) => _PasswordField(
//                       controller: _confirmCtrl,
//                       label: 'Confirm Password',
//                       visible: _confirmVisible,
//                       onToggle: () =>
//                           setS(() => _confirmVisible = !_confirmVisible),
//                       validator: (v) {
//                         if (v != _passwordCtrl.text) {
//                           return 'Passwords do not match';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 12),
//             Obx(() => _ErrorBanner(message: _ctrl.errorMessage.value)),
//             const SizedBox(height: 8),
//             Obx(() => _PrimaryButton(
//                   label: 'Create Account',
//                   isLoading: _ctrl.isLoading.value,
//                   onTap: _submit,
//                 )),
//             const SizedBox(height: 20),
//             const _OrDivider(),
//             const SizedBox(height: 20),
//             _GoogleButton(onTap: _ctrl.signInWithGoogle),
//             const SizedBox(height: 32),
//             _SwitchAuthRow(
//               question: 'Already have an account?',
//               actionLabel: 'Sign In',
//               onTap: () => Get.offNamed(AppRoutes.login),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // ═══════════════════════════════════════════════════════════════════════════════
// // FORGOT PASSWORD SCREEN
// // ═══════════════════════════════════════════════════════════════════════════════
// class ForgotPasswordScreen extends StatefulWidget {
//   const ForgotPasswordScreen({super.key});
//   @override
//   State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
// }

// class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _emailCtrl = TextEditingController();

//   AuthController get _ctrl => Get.find<AuthController>();

//   @override
//   void dispose() {
//     _emailCtrl.dispose();
//     super.dispose();
//   }

//   void _submit() {
//     if (!_formKey.currentState!.validate()) return;
//     _ctrl.sendPasswordReset(_emailCtrl.text.trim());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.backgroundDark,
//       body: _AuthShell(
//         showBack: true,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             const _AuthHeader(
//               emoji: '🔐',
//               title: 'Reset password',
//               subtitle: "Enter your email and we'll send a reset link",
//             ),
//             const SizedBox(height: 36),
//             Obx(() {
//               if (_ctrl.resetEmailSent.value) {
//                 return _SuccessCard(email: _emailCtrl.text.trim());
//               }
//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Form(
//                     key: _formKey,
//                     child: _EmailField(controller: _emailCtrl),
//                   ),
//                   const SizedBox(height: 12),
//                   Obx(() => _ErrorBanner(message: _ctrl.errorMessage.value)),
//                   const SizedBox(height: 12),
//                   Obx(() => _PrimaryButton(
//                         label: 'Send Reset Link',
//                         isLoading: _ctrl.isLoading.value,
//                         onTap: _submit,
//                       )),
//                 ],
//               );
//             }),
//             const SizedBox(height: 32),
//             _SwitchAuthRow(
//               question: 'Remember your password?',
//               actionLabel: 'Sign In',
//               onTap: () => Get.offAllNamed(AppRoutes.login),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // ═══════════════════════════════════════════════════════════════════════════════
// // SHARED WIDGETS
// // ═══════════════════════════════════════════════════════════════════════════════

// // ─── Shell ────────────────────────────────────────────────────────────────────
// class _AuthShell extends StatelessWidget {
//   const _AuthShell({required this.child, this.showBack = false});
//   final Widget child;
//   final bool showBack;

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Positioned.fill(
//           child: DecoratedBox(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: [
//                   const Color(0xFF1A0533),
//                   AppColors.backgroundDark,
//                   const Color(0xFF0A0A1A),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         Positioned(
//           top: -80,
//           right: -80,
//           child: _Blob(color: AppColors.primary, size: 280),
//         ),
//         Positioned(
//           bottom: -60,
//           left: -60,
//           child: _Blob(color: const Color(0xFF2563EB), size: 200),
//         ),
//         SafeArea(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(
//               horizontal: AppSizes.pagePadding,
//               vertical: 24,
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 if (showBack) ...[
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: _BackButton(),
//                   ),
//                   const SizedBox(height: 8),
//                 ],
//                 child,
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// // ─── Back button ──────────────────────────────────────────────────────────────
// class _BackButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => Get.back(),
//       child: Container(
//         width: 40,
//         height: 40,
//         decoration: BoxDecoration(
//           color: Colors.white.withValues(alpha: 0.07),
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
//         ),
//         child: const Icon(
//           Icons.arrow_back_ios_new_rounded,
//           color: AppColors.textSecondary,
//           size: 16,
//         ),
//       ),
//     );
//   }
// }

// // ─── Auth header ──────────────────────────────────────────────────────────────
// class _AuthHeader extends StatelessWidget {
//   const _AuthHeader({
//     required this.emoji,
//     required this.title,
//     required this.subtitle,
//   });
//   final String emoji;
//   final String title;
//   final String subtitle;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             Container(
//               width: 44,
//               height: 44,
//               decoration: BoxDecoration(
//                 gradient: const LinearGradient(
//                   colors: [AppColors.primary, Color(0xFF5B21B6)],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 borderRadius: BorderRadius.circular(12),
//                 boxShadow: [
//                   BoxShadow(
//                     color: AppColors.primary.withValues(alpha: 0.4),
//                     blurRadius: 16,
//                     offset: const Offset(0, 6),
//                   ),
//                 ],
//               ),
//               child: const Center(
//                 child: Text('🧠', style: TextStyle(fontSize: 22)),
//               ),
//             ),
//             const SizedBox(width: 10),
//             const Text(
//               'LifeCoach AI',
//               style: TextStyle(
//                 color: AppColors.textPrimary,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w700,
//                 letterSpacing: 0.3,
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 40),
//         Text(emoji, style: const TextStyle(fontSize: 40)),
//         const SizedBox(height: 12),
//         Text(
//           title,
//           style: const TextStyle(
//             color: AppColors.textPrimary,
//             fontSize: 32,
//             fontWeight: FontWeight.w800,
//             height: 1.1,
//             letterSpacing: -0.5,
//           ),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           subtitle,
//           style: const TextStyle(
//             color: AppColors.textSecondary,
//             fontSize: 15,
//             height: 1.5,
//           ),
//         ),
//       ],
//     );
//   }
// }

// // ─── Name field ───────────────────────────────────────────────────────────────
// class _NameField extends StatelessWidget {
//   const _NameField({required this.controller});
//   final TextEditingController controller;

//   @override
//   Widget build(BuildContext context) {
//     return _AuthField(
//       controller: controller,
//       label: 'Full Name',
//       icon: Icons.person_outline_rounded,
//       keyboardType: TextInputType.name,
//       validator: (v) {
//         if (v == null || v.trim().isEmpty) return 'Enter your name';
//         return null;
//       },
//     );
//   }
// }

// // ─── Email field ──────────────────────────────────────────────────────────────
// class _EmailField extends StatelessWidget {
//   const _EmailField({required this.controller});
//   final TextEditingController controller;

//   @override
//   Widget build(BuildContext context) {
//     return _AuthField(
//       controller: controller,
//       label: 'Email address',
//       icon: Icons.mail_outline_rounded,
//       keyboardType: TextInputType.emailAddress,
//       validator: (v) {
//         if (v == null || v.trim().isEmpty) return 'Enter your email';
//         if (!GetUtils.isEmail(v.trim())) return 'Enter a valid email';
//         return null;
//       },
//     );
//   }
// }

// // ─── Generic field ────────────────────────────────────────────────────────────
// class _AuthField extends StatelessWidget {
//   const _AuthField({
//     required this.controller,
//     required this.label,
//     required this.icon,
//     this.keyboardType = TextInputType.text,
//     this.validator,
//   });
//   final TextEditingController controller;
//   final String label;
//   final IconData icon;
//   final TextInputType keyboardType;
//   final String? Function(String?)? validator;

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       keyboardType: keyboardType,
//       style: const TextStyle(color: AppColors.textPrimary, fontSize: 15),
//       validator: validator,
//       decoration: _fieldDecoration(label, icon),
//     );
//   }
// }

// // ─── Password field ───────────────────────────────────────────────────────────
// class _PasswordField extends StatelessWidget {
//   const _PasswordField({
//     required this.controller,
//     required this.label,
//     required this.visible,
//     required this.onToggle,
//     this.validator,
//   });
//   final TextEditingController controller;
//   final String label;
//   final bool visible;
//   final VoidCallback onToggle;
//   final String? Function(String?)? validator;

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       obscureText: !visible,
//       style: const TextStyle(color: AppColors.textPrimary, fontSize: 15),
//       validator: validator ??
//           (v) {
//             if (v == null || v.isEmpty) return 'Enter your password';
//             return null;
//           },
//       decoration: _fieldDecoration(
//         label,
//         Icons.lock_outline_rounded,
//         suffix: GestureDetector(
//           onTap: onToggle,
//           child: Icon(
//             visible ? Icons.visibility_off_outlined : Icons.visibility_outlined,
//             color: AppColors.textSecondary,
//             size: 20,
//           ),
//         ),
//       ),
//     );
//   }
// }

// // ─── Shared InputDecoration ───────────────────────────────────────────────────
// InputDecoration _fieldDecoration(String label, IconData icon,
//     {Widget? suffix}) {
//   return InputDecoration(
//     labelText: label,
//     labelStyle:
//         const TextStyle(color: AppColors.textSecondary, fontSize: 14),
//     prefixIcon: Icon(icon, color: AppColors.textSecondary, size: 20),
//     suffixIcon: suffix,
//     filled: true,
//     fillColor: AppColors.surfaceDark,
//     contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
//     border: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(AppSizes.radiusCard),
//       borderSide:
//           BorderSide(color: Colors.white.withValues(alpha: 0.08), width: 1),
//     ),
//     enabledBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(AppSizes.radiusCard),
//       borderSide:
//           BorderSide(color: Colors.white.withValues(alpha: 0.08), width: 1),
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(AppSizes.radiusCard),
//       borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
//     ),
//     errorBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(AppSizes.radiusCard),
//       borderSide: const BorderSide(color: AppColors.error, width: 1.2),
//     ),
//     focusedErrorBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(AppSizes.radiusCard),
//       borderSide: const BorderSide(color: AppColors.error, width: 1.5),
//     ),
//     errorStyle: const TextStyle(color: AppColors.error, fontSize: 12),
//   );
// }

// // ─── Primary gradient button ──────────────────────────────────────────────────
// class _PrimaryButton extends StatelessWidget {
//   const _PrimaryButton({
//     required this.label,
//     required this.isLoading,
//     required this.onTap,
//   });
//   final String label;
//   final bool isLoading;
//   final VoidCallback onTap;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: isLoading ? null : onTap,
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         height: 56,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: isLoading
//                 ? [
//                     AppColors.primary.withValues(alpha: 0.5),
//                     AppColors.primary.withValues(alpha: 0.35)
//                   ]
//                 : [AppColors.primary, const Color(0xFF5B21B6)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           borderRadius: BorderRadius.circular(AppSizes.radiusButton + 2),
//           boxShadow: isLoading
//               ? []
//               : [
//                   BoxShadow(
//                     color: AppColors.primary.withValues(alpha: 0.45),
//                     blurRadius: 20,
//                     offset: const Offset(0, 8),
//                   ),
//                 ],
//         ),
//         child: Center(
//           child: isLoading
//               ? const SizedBox(
//                   width: 22,
//                   height: 22,
//                   child: CircularProgressIndicator(
//                     color: Colors.white,
//                     strokeWidth: 2.5,
//                   ),
//                 )
//               : Text(
//                   label,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w700,
//                     letterSpacing: 0.2,
//                   ),
//                 ),
//         ),
//       ),
//     );
//   }
// }

// // ─── OR divider ───────────────────────────────────────────────────────────────
// class _OrDivider extends StatelessWidget {
//   const _OrDivider();

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: Divider(
//               color: Colors.white.withValues(alpha: 0.10), thickness: 1),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 14),
//           child: Text(
//             'or continue with',
//             style: TextStyle(
//               color: AppColors.textSecondary.withValues(alpha: 0.7),
//               fontSize: 12,
//             ),
//           ),
//         ),
//         Expanded(
//           child: Divider(
//               color: Colors.white.withValues(alpha: 0.10), thickness: 1),
//         ),
//       ],
//     );
//   }
// }

// // ─── Google button ────────────────────────────────────────────────────────────
// class _GoogleButton extends StatelessWidget {
//   const _GoogleButton({required this.onTap});
//   final VoidCallback onTap;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         height: 56,
//         decoration: BoxDecoration(
//           color: AppColors.surfaceDark,
//           borderRadius: BorderRadius.circular(AppSizes.radiusButton + 2),
//           border: Border.all(
//               color: Colors.white.withValues(alpha: 0.10), width: 1),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox(
//               width: 22,
//               height: 22,
//               child: CustomPaint(painter: _GoogleLogoPainter()),
//             ),
//             const SizedBox(width: 12),
//             const Text(
//               'Continue with Google',
//               style: TextStyle(
//                 color: AppColors.textPrimary,
//                 fontSize: 15,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // ─── Google G painter ─────────────────────────────────────────────────────────
// class _GoogleLogoPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final center = Offset(size.width / 2, size.height / 2);
//     final radius = size.width / 2;
//     const pi = 3.14159265358979;

//     final segments = [
//       (0.0, 90.0, const Color(0xFF4285F4)),
//       (90.0, 90.0, const Color(0xFF34A853)),
//       (180.0, 90.0, const Color(0xFFFBBC05)),
//       (270.0, 90.0, const Color(0xFFEA4335)),
//     ];

//     for (final (start, sweep, color) in segments) {
//       canvas.drawArc(
//         Rect.fromCircle(center: center, radius: radius * 0.78),
//         start * pi / 180.0,
//         sweep * pi / 180.0,
//         false,
//         Paint()
//           ..color = color
//           ..style = PaintingStyle.stroke
//           ..strokeWidth = size.width * 0.18
//           ..strokeCap = StrokeCap.butt,
//       );
//     }

//     canvas.drawLine(
//       Offset(center.dx, center.dy),
//       Offset(center.dx + radius * 0.75, center.dy),
//       Paint()
//         ..color = Colors.white
//         ..strokeWidth = size.height * 0.18
//         ..strokeCap = StrokeCap.square,
//     );
//   }

//   @override
//   bool shouldRepaint(_GoogleLogoPainter old) => false;
// }

// // ─── Switch auth row ──────────────────────────────────────────────────────────
// class _SwitchAuthRow extends StatelessWidget {
//   const _SwitchAuthRow({
//     required this.question,
//     required this.actionLabel,
//     required this.onTap,
//   });
//   final String question;
//   final String actionLabel;
//   final VoidCallback onTap;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(question,
//             style: const TextStyle(
//                 color: AppColors.textSecondary, fontSize: 14)),
//         const SizedBox(width: 4),
//         GestureDetector(
//           onTap: onTap,
//           child: Text(
//             actionLabel,
//             style: const TextStyle(
//               color: AppColors.primaryLight,
//               fontSize: 14,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// // ─── Error banner ─────────────────────────────────────────────────────────────
// class _ErrorBanner extends StatelessWidget {
//   const _ErrorBanner({required this.message});
//   final String message;

//   @override
//   Widget build(BuildContext context) {
//     if (message.isEmpty) return const SizedBox.shrink();
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//       decoration: BoxDecoration(
//         color: AppColors.error.withValues(alpha: 0.12),
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(
//             color: AppColors.error.withValues(alpha: 0.35), width: 1),
//       ),
//       child: Row(
//         children: [
//           const Icon(Icons.error_outline_rounded,
//               color: AppColors.error, size: 16),
//           const SizedBox(width: 8),
//           Expanded(
//             child: Text(
//               message,
//               style: const TextStyle(
//                   color: AppColors.error, fontSize: 13, height: 1.4),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ─── Success card (forgot password) ──────────────────────────────────────────
// class _SuccessCard extends StatelessWidget {
//   const _SuccessCard({required this.email});
//   final String email;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(24),
//       decoration: BoxDecoration(
//         color: AppColors.success.withValues(alpha: 0.08),
//         borderRadius: BorderRadius.circular(AppSizes.radiusCard),
//         border: Border.all(
//             color: AppColors.success.withValues(alpha: 0.30), width: 1),
//       ),
//       child: Column(
//         children: [
//           Container(
//             width: 60,
//             height: 60,
//             decoration: BoxDecoration(
//               color: AppColors.success.withValues(alpha: 0.15),
//               shape: BoxShape.circle,
//             ),
//             child: const Center(
//               child: Icon(Icons.mark_email_read_outlined,
//                   color: AppColors.success, size: 28),
//             ),
//           ),
//           const SizedBox(height: 16),
//           const Text(
//             'Check your inbox',
//             style: TextStyle(
//               color: AppColors.textPrimary,
//               fontSize: 18,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'We sent a password reset link to\n$email',
//             textAlign: TextAlign.center,
//             style: const TextStyle(
//                 color: AppColors.textSecondary, fontSize: 14, height: 1.5),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ─── Blob ─────────────────────────────────────────────────────────────────────
// class _Blob extends StatelessWidget {
//   const _Blob({required this.color, required this.size});
//   final Color color;
//   final double size;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: size,
//       height: size,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         gradient: RadialGradient(
//           colors: [
//             color.withValues(alpha: 0.18),
//             color.withValues(alpha: 0.0),
//           ],
//         ),
//       ),
//     );
//   }
// }
