// LAYER: App config — Splash
// PURPOSE: Injects SplashController when the '/' route is loaded.

import 'package:get/get.dart';
import 'splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    // Must be Get.put (not lazyPut) — SplashScreen has no Obx() that would
    // trigger lazy resolution. Get.put creates the controller immediately so
    // onInit() fires and the navigation timer starts.
    Get.put<SplashController>(SplashController());
  }
}
