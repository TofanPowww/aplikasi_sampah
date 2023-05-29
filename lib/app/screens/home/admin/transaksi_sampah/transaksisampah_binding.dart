import 'package:get/get.dart';

import 'transaksisampah_controller.dart';

class TransaksiSampahBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TransaksiSampahController());
  }
}
