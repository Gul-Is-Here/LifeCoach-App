// LAYER: App config
// PURPOSE: String constants for every named route.
//          Never hardcode route strings anywhere else — always use AppRoutes.xxx
// USED BY: AppPages (maps these to screens+bindings), Get.toNamed() calls in controllers

abstract class AppRoutes {
  static const splash = '/';
  static const onboarding = '/onboarding';
  static const login = '/login';
  static const register = '/register';
  static const forgotPassword = '/forgot-password';
  static const dashboard = '/dashboard';
  static const habits = '/habits';
  static const health = '/health';
  static const finance = '/finance';
  static const goals = '/goals';
  static const planner = '/planner';
  static const aiCoach = '/ai-coach';
  static const profile = '/profile';
}
