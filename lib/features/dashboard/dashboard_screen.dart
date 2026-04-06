// LAYER: UI (Layer 1) — Feature: Dashboard
// PURPOSE: App shell — IndexedStack with 5 tabs. BottomNav driven by DashboardController.selectedTab.
//          Each tab body is a separate feature screen.
// BUILT: Week 2

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../shared/constants/app_colors.dart';
import '../../shared/constants/app_strings.dart';
import 'dashboard_controller.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: AppColors.backgroundDark,
        body: IndexedStack(
          index: controller.selectedTab.value,
          children: const [
            _HomeTab(),
            // TODO Week 3: HabitsScreen()
            // TODO Week 7: AiCoachScreen()
            // TODO Week 4: HealthScreen()
            // TODO Week 5: FinanceScreen()
            _HomeTab(), // placeholder 2
            _HomeTab(), // placeholder 3
            _HomeTab(), // placeholder 4
            _HomeTab(), // placeholder 5
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.selectedTab.value,
          onTap: controller.changeTab,
          backgroundColor: AppColors.cardDark,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textSecondary,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.checklist_outlined),
              label: AppStrings.habits,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.auto_awesome),
              label: AppStrings.aiCoach,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline),
              label: AppStrings.health,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet_outlined),
              label: AppStrings.finance,
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Home Tab placeholder ──────────────────────────────────────────────────
class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        '🏠 Home Tab\n— Week 2 —',
        style: TextStyle(color: AppColors.textSecondary),
        textAlign: TextAlign.center,
      ),
    );
  }
}
