// LAYER: App config
// PURPOSE: InitialBinding — registered once at app start via GetMaterialApp(initialBinding:).
//          Only truly global services go here. Feature controllers go in their own XxxBinding.
// RULE: fenix:true → GetX re-creates the instance if it is garbage-collected.

import 'package:get/get.dart';
import '../../services/auth_service.dart';
import '../../services/firestore_service.dart';
import '../../services/cloud_functions_service.dart';
import '../../services/storage_service.dart';
import '../../services/notification_service.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // AuthService must be eager (Get.put) — SplashController calls Get.find<AuthService>()
    // immediately on init. lazyPut would not have instantiated it in time.
    Get.put<AuthService>(AuthService(), permanent: true);

    // Remaining services are safe as lazy — they are only accessed after a route transition.
    Get.lazyPut<FirestoreService>(() => FirestoreService(), fenix: true);
    Get.lazyPut<CloudFunctionsService>(
      () => CloudFunctionsService(),
      fenix: true,
    );
    Get.lazyPut<StorageService>(() => StorageService(), fenix: true);
    Get.lazyPut<NotificationService>(() => NotificationService(), fenix: true);
  }
}
