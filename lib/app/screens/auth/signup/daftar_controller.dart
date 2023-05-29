import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DaftarController extends GetxController {
  TextEditingController emailsignupC = TextEditingController();
  TextEditingController namasignupC = TextEditingController();
  TextEditingController rtsignupC = TextEditingController();
  TextEditingController rwsignupC = TextEditingController();
  TextEditingController wasignupC = TextEditingController();
  TextEditingController passwordsignupC = TextEditingController();
  TextEditingController confirmpasswordsignupC = TextEditingController();

  @override
  void onClose() {
    emailsignupC.dispose();
    namasignupC.dispose();
    rtsignupC.dispose();
    rwsignupC.dispose();
    wasignupC.dispose();
    passwordsignupC.dispose();
    confirmpasswordsignupC.dispose();
    super.onClose();
  }
}
