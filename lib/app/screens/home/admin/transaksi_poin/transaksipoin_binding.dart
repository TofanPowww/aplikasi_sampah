import 'package:get/get.dart';
import 'transaksipoin_controller.dart';

class TransaksiPoinBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TransaksiPoinController());
  }
}
