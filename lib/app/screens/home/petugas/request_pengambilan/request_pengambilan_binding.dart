import 'package:get/get.dart';
import 'request_pengambilan_controller.dart';

class RequestPengambilanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RequestPengambilanController());
  }
}
