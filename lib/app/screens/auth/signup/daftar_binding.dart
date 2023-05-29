import 'package:aplikasi_sampah/app/screens/auth/signup/daftar_controller.dart';
import 'package:get/get.dart';

class DaftarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => (DaftarController()));
  }
}
