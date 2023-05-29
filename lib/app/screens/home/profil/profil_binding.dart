import 'package:aplikasi_sampah/app/screens/home/profil/profil_controller.dart';
import 'package:get/get.dart';

class ProfilBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => (ProfilController()));
  }
}
