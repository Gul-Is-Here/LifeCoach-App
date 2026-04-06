// LAYER: Controller (Layer 2) — Splash
// PURPOSE: Decides the initial route after a short brand delay.
//          Logic:
//            1. Wait 2 seconds (brand moment)
//            2. Check GetStorage 'appInstalled' flag.
//               • Not set → this is a genuine first launch after install.
//                 Sign out silently (clears stale iOS Keychain token from a
//                 previous install), write 'appInstalled' = true, go to
//                 onboarding.
//            3. If already installed:
//               a. Firebase currentUser != null → dashboard
//               b. currentUser == null → check 'onboardingDone'
//                  • true  → login
//                  • false → onboarding
// NOTE: iOS Keychain persists Firebase tokens across app uninstalls.
//       The 'appInstalled' flag in GetStorage does NOT persist across
//       uninstalls (storage is wiped), so it reliably detects a fresh
//       install even when the Keychain still holds a stale token.
// REGISTERED: in SplashBinding, listed in AppPages as the initial route ('/')

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../app/routes/app_routes.dart';
import '../../services/auth_service.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigate();
  }

  Future<void> _navigate() async {
    try {
      // 2-second brand delay
      await Future.delayed(const Duration(seconds: 2));

      final auth = Get.find<AuthService>();
      final storage = GetStorage();

      // ── Detect fresh install ─────────────────────────────────────────────
      // GetStorage is cleared on uninstall; iOS Keychain is NOT.
      // If 'appInstalled' is absent it means the app was just installed
      // (or reinstalled), so we force sign-out to clear the stale Keychain
      // token before continuing.
      final appInstalled = storage.read<bool>('appInstalled') ?? false;
      if (!appInstalled) {
        await auth.signOut(); // silently clears stale Keychain token
        await storage.write('appInstalled', true);
        Get.offAllNamed(AppRoutes.onboarding);
        return;
      }

      // ── Returning user ───────────────────────────────────────────────────
      if (auth.currentUser != null) {
        Get.offAllNamed(AppRoutes.dashboard);
      } else {
        final onboardingDone = storage.read<bool>('onboardingDone') ?? false;
        if (onboardingDone) {
          Get.offAllNamed(AppRoutes.login);
        } else {
          Get.offAllNamed(AppRoutes.onboarding);
        }
      }
    } catch (e) {
      // If anything fails, fall back to onboarding so the app never gets stuck
      debugPrint('SplashController error: $e');
      Get.offAllNamed(AppRoutes.onboarding);
    }
  }
}
