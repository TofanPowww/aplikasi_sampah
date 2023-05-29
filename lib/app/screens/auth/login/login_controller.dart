// ignore_for_file: avoid_print, unused_local_variable, override_on_non_overriding_member
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import '../../index.dart';

class LoginController extends GetxController {
  TextEditingController emailloginC = TextEditingController();
  TextEditingController passwordloginC = TextEditingController();

  @override
  void onCLose() {
    emailloginC.dispose();
    passwordloginC.dispose();
    super.onClose();
  }

  
}
