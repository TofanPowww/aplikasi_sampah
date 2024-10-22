// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls
import 'dart:io';
import 'package:aplikasi_sampah/app/constant/color.dart';
import 'package:aplikasi_sampah/app/data/models/users_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:aplikasi_sampah/routes/links.dart';
import '../app/screens/auth/daftar/daftar_controller.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  final c = Get.put(DaftarController());
  var isLoading = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  Rx user = UsersModel().obs;

  //?Get current user data//
  Future getCurrentUser() async {
    return auth.currentUser!;
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamRole() async* {
    String? email = auth.currentUser!.email;
    yield* db.collection("users").doc(email).snapshots();
  }

  //?Routing//
  toSignup() => Get.toNamed(AppLinks.SIGNUP);
  toLogin() => Get.offAllNamed(AppLinks.LOGIN);

  //?Dropdown Button//
  var option = ['Warga'];
  var currentItemSelected = "Warga";
  var rool = "Warga";

  //?Image Picker//
  File? imageProfil;
  String? imageProfilUrl;

  //?Daftar//
  Future<void> daftar(String rool, String email, String nama, String rt,
      String rw, String wa, String password, String konfirpass) async {
    isLoading.value = true;
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) =>
              postDetailsToFirestore(rool, email, nama, rt, rw, wa, password));
      isLoading.value = false;
      Get.snackbar(
        "Berhasil mendaftar",
        "akun berhasil didaftarkan",
        backgroundColor: appSuccess,
        snackPosition: SnackPosition.TOP,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        isLoading.value = false;
        Get.snackbar(
          "Gagal Mendaftar",
          "Email sudah digunakan",
          backgroundColor: appDanger,
          snackPosition: SnackPosition.TOP,
        );
      } else if (e.code == 'weak-password') {
        print("Weak Password");
        isLoading.value = false;
        Get.snackbar(
          "Gagal Mendaftar",
          "Password kurang aman",
          backgroundColor: appDanger,
          snackPosition: SnackPosition.TOP,
        );
      }
    }
  }

  //?Login//
  Future<void> login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      toHome();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("User not found");
        Get.snackbar(
          "Gagal masuk",
          "User tidak ditemukan",
          snackPosition: SnackPosition.TOP,
          colorText: appBackgroundSecondary,
          backgroundColor: appDanger,
        );
      } else if (e.code == 'wrong-password') {
        print("Wrong password");
        Get.snackbar("Gagal masuk", "Password salah",
            snackPosition: SnackPosition.TOP,
            backgroundColor: appDanger,
            colorText: appBackgroundSecondary);
      }
    }
  }

  //?Simpan Data User di Firestore//
  Future<void> postDetailsToFirestore(String rool, String email, String nama,
      String rt, String rw, String wa, String password) async {
    final ref = FirebaseStorage.instance
        .ref()
        .child('foto_profil_user')
        .child('imageP_$email.jpg');
    await ref.putFile(File(imageProfil!.path));
    imageProfilUrl = await ref.getDownloadURL();

    CollectionReference users = FirebaseFirestore.instance.collection('users');
    await users.doc(email).set({
      'uid': auth.currentUser!.uid,
      'rool': rool,
      'email': email,
      'nama_lengkap': nama,
      'rt': rt,
      'rw': rw,
      'no_wa': wa,
      'password': password,
      'foto_profil': imageProfilUrl,
      'poin': 0
    });

    final currUser = await users.doc(auth.currentUser!.email).get();
    final currUserData = currUser.data() as Map<String, dynamic>;
    print(currUserData);
    await auth.signOut();
    Get.until((route) => Get.currentRoute == AppLinks.LOGIN);
  }

  //?Direct to Home Page//
  Future<void> toHome() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.email)
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      if (documentSnapshot.exists) {
        CollectionReference users =
            FirebaseFirestore.instance.collection('users');
        final currUser = await users.doc(auth.currentUser!.email).get();
        final currUserData = currUser.data() as Map<String, dynamic>;

        print(currUserData);
        user.refresh();
        Get.offNamed(AppLinks.HOME);
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  //?Logout//
  Future<void> logOut() async {
    await auth.signOut();
    Get.offAllNamed(AppLinks.LOGIN);
  }
}
