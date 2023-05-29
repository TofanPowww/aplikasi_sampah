import 'package:get/get.dart';

class AuthorizationService extends GetxService {
  late final bool isPetugas;

  @override
  void onInit() {
    isPetugas = true;
    super.onInit();
  }

  upgradeRole() {
    isPetugas = true;
  }
}