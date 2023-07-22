import 'package:aplikasi_sampah/app/screens/home/warga/kirim/kirim_controller.dart';
import 'package:get/get.dart';

class KirimBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => KirimController());
  }
}
