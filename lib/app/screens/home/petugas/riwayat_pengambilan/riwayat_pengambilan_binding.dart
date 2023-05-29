import 'package:get/instance_manager.dart';
import 'riwayat_pengambilan_controller.dart';

class RiwayatPengambilanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RiwayatPengambilanController());
  }
}
