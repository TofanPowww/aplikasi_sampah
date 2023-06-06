import 'package:aplikasi_sampah/app/constant/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  var isLoading = false.obs;

  //Form Controller
  TextEditingController passLamaC = TextEditingController();
  TextEditingController passBaruC = TextEditingController();
  TextEditingController passKonfirC = TextEditingController();

  //Function Reset Password
  Future<void> resetPass(
      String passLama, String passBaru, String passKonfir) async {
    isLoading.value = true;    
    if (passLamaC.text.isNotEmpty &&
        passBaruC.text.isNotEmpty &&
        passKonfirC.text.isNotEmpty) {
      if (passBaru == passKonfir) {
        try {
          String emailUser = auth.currentUser!.email!;
          await auth.signInWithEmailAndPassword(
              email: emailUser, password: passLama);
          await auth.currentUser!
              .updatePassword(passBaru)
              .then((value) => updateDb(passBaru));
          isLoading.value = false;
          Get.back();
          Get.snackbar("Berhasil", "Password berhasil diperbarui",
              backgroundColor: appSuccess, snackPosition: SnackPosition.TOP);
        } on FirebaseAuthException catch (e) {
          if (e.code == "wrong-password") {
            isLoading.value = false;
            Get.snackbar("Gagal", "Password lama yang dimasukkan salah.",
                backgroundColor: appDanger, snackPosition: SnackPosition.TOP);
          }
        } catch (e) {
          isLoading.value = false;
          Get.snackbar("Gagal", "Tidak dapat memperbarui password",
              backgroundColor: appDanger, snackPosition: SnackPosition.TOP);
        }
      } else {
        isLoading.value = false;
        Get.snackbar("Gagal", "Konfirmasi password salah",
            backgroundColor: appDanger, snackPosition: SnackPosition.TOP);
      }
    } else {
      isLoading.value = false;
      Get.snackbar("Gagal", "Masukkan semua data",
          backgroundColor: appDanger, snackPosition: SnackPosition.TOP);
    }
  }

  //Update User Firestore
  updateDb(String passBaru) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    await users
        .doc(FirebaseAuth.instance.currentUser!.email)
        .update({'password': passBaru});
  }
}
