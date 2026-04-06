// LAYER: App config
// PURPOSE: Maps every AppRoutes string → (screen widget + binding).
//          GetX reads this list to lazy-load the right controller when a route is pushed.
// RULE: Add a new GetPage here every time a new feature screen is built.

import 'package:get/get.dart';
import 'app_routes.dart';
import '../../features/splash/splash_screen.dart';
import '../../features/splash/splash_binding.dart';
import '../../features/onboarding/onboarding_screen.dart';
import '../../features/onboarding/onboarding_binding.dart';
import '../../features/auth/views/login_screen.dart';
import '../../features/auth/views/register_screen.dart';
import '../../features/auth/views/forgot_password_screen.dart';
import '../../features/auth/binding/auth_binding.dart';
import '../../features/dashboard/dashboard_screen.dart';
import '../../features/dashboard/dashboard_binding.dart';

class AppPages {
  static final pages = <GetPage>[
    // ── Splash (initial route) ───────────────────────────────────────────────
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),

    // ── Onboarding (first install only) ─────────────────────────────────────
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingScreen(),
      binding: OnboardingBinding(),
    ),

    // ── Auth ─────────────────────────────────────────────────────────────────
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => const ForgotPasswordScreen(),
      binding: AuthBinding(),
    ),

    // ── Dashboard shell ───────────────────────────────────────────────────────
    GetPage(
      name: AppRoutes.dashboard,
      page: () => const DashboardScreen(),
      binding: DashboardBinding(),
    ),

    // ── Future features — add as built ───────────────────────────────────────
    // GetPage(name: AppRoutes.habits,  page: () => HabitsScreen(),  binding: HabitBinding()),
    // GetPage(name: AppRoutes.health,  page: () => HealthScreen(),  binding: HealthBinding()),
    // GetPage(name: AppRoutes.finance, page: () => FinanceScreen(), binding: FinanceBinding()),
    // GetPage(name: AppRoutes.goals,   page: () => GoalsScreen(),   binding: GoalBinding()),
    // GetPage(name: AppRoutes.planner, page: () => PlannerScreen(), binding: PlannerBinding()),
    // GetPage(name: AppRoutes.aiCoach, page: () => AiCoachScreen(), binding: AiCoachBinding()),
    // GetPage(name: AppRoutes.profile, page: () => ProfileScreen(), binding: ProfileBinding()),
  ];
}
