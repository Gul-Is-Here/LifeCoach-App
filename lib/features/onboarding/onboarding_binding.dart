// LAYER: App config — Onboarding
// PURPOSE: Injects OnboardingController when the '/onboarding' route is loaded.

import 'package:get/get.dart';
import 'onboarding_controller.dart';

class OnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<OnboardingController>(OnboardingController());
  }
}
