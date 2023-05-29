import 'package:get/get.dart';
import 'package:aplikasi_sampah/app/screens/auth/login/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}
