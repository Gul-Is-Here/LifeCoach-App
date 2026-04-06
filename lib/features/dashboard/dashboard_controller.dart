// LAYER: Controller (Layer 2) — Feature: Dashboard
// PURPOSE: App shell controller. Manages tab selection, greeting, and the Daily Life Score.
//          Lazily references sub-controllers via Get.find<>() — does NOT own their state.
// BUILT: Week 2 (score wired fully in Week 9)

import 'package:get/get.dart';

class DashboardController extends GetxController {
  // ─── Tab navigation ───────────────────────────────────────────────────────
  // 0=Home 1=Habits 2=AI Coach 3=Health 4=Finance
  final selectedTab = 0.obs;

  void changeTab(int index) => selectedTab.value = index;

  // ─── Greeting ─────────────────────────────────────────────────────────────
  String get greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  // ─── Daily Life Score (0-100) ─────────────────────────────────────────────
  // Formula: habits*35 + sleep*20 + water*15 + budget*20 + goals*10
  // Each sub-score is a 0.0–1.0 ratio pulled from the relevant controller.
  // Obx() on the Dashboard re-reads this getter whenever any dependency changes.
  int get dailyScore {
    // TODO Week 9: wire real values from HabitController, HealthController, etc.
    return 0;
  }

  // ─── Pull-to-refresh ──────────────────────────────────────────────────────
  final isLoading = false.obs;

  @override
  Future<void> refresh() async {
    isLoading.value = true;
    // TODO Week 9: Future.wait([habitsCtrl.refresh(), healthCtrl.refresh(), ...])
    await Future.delayed(const Duration(milliseconds: 300));
    isLoading.value = false;
  }
}
