import 'package:aplikasi_sampah/app/screens/home/tukar/tukar_controller.dart';
import 'package:get/get.dart';

class TukarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TukarController());
  }
}
