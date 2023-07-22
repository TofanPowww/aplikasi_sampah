import 'package:get/get.dart';
import 'add_petugas_controller.dart';

class AddPetugasBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => (AddPetugasController()));
  }
}
