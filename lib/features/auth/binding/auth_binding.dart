// LAYER: App config — Feature: Auth
// PURPOSE: Injects AuthController for login/register/forgotPassword routes.
//          fenix:true — GetX re-creates the instance after it is disposed so
//          navigating back into an auth route always gets a fresh controller
//          without disposing the one still in use on the current route.

import 'package:get/get.dart';
import '../controller/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
  }
}
