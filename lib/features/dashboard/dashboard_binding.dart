// LAYER: App config — Feature: Dashboard
// PURPOSE: Lazy-injects DashboardController when the dashboard route is pushed.

import 'package:get/get.dart';
import 'dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
  }
}
