import 'package:get/get.dart';

import 'profilpetugas_controller.dart';

class ProfilPetugasBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfilPetugasController());
  }
}
