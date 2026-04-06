// LAYER: Controller (Layer 2) — Onboarding
// PURPOSE: Manages the 4-page onboarding PageView.
//          On finish: writes 'onboardingDone' = true to GetStorage, navigates to login.
//          No Firebase calls — purely local.

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../app/routes/app_routes.dart';

class OnboardingController extends GetxController {
  final pageController = PageController();
  final currentPage = 0.obs;

  // Total number of onboarding pages
  static const int totalPages = 4;

  void onPageChanged(int index) => currentPage.value = index;

  void nextPage() {
    if (currentPage.value < totalPages - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      finish();
    }
  }

  void skip() => finish();

  void finish() {
    GetStorage().write('onboardingDone', true);
    Get.offAllNamed(AppRoutes.login);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
