import 'package:get/get.dart';

import 'profiladmin_controller.dart';

class ProfilAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfilAdminController());
  }
}
