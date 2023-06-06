// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls
import 'dart:io';
import 'package:aplikasi_sampah/app/constant/color.dart';
import 'package:aplikasi_sampah/app/data/models/users_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:aplikasi_sampah/routes/links.dart';
import 'signup/daftar_controller.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  final c = Get.put(DaftarController());
  var isLoading = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  Stream<User?> get streamAuthStatus => auth.userChanges();
  Rx user = UsersModel().obs;

  //Get current user data
  Future getCurrentUser() async {
    return auth.currentUser!;
  }

  //Routing
  toSignup() => Get.toNamed(AppLinks.SIGNUP);
  toLogin() => Get.offAllNamed(AppLinks.LOGIN);

  //Dropdown Button//
  var option = ['Warga'];
  var currentItemSelected = "Warga";
  var rool = "Warga";

  //Image Picker//
  File? imageProfil;
  String? imageProfilUrl;
  //End Image PIcker//

  //Daftar//
  Future<void> daftar(String rool, String email, String nama, String rt,
      String rw, String wa, String password, String konfirpass) async {
    isLoading.value = true;    
    if (c.emailsignupC.text.isNotEmpty &&
        c.namasignupC.text.isNotEmpty &&
        c.rtsignupC.text.isNotEmpty &&
        c.rwsignupC.text.isNotEmpty &&
        c.passwordsignupC.text.isEmpty &&
        c.confirmpasswordsignupC.text.isNotEmpty) {
      if (password == konfirpass) {
        try {
          await auth
              .createUserWithEmailAndPassword(email: email, password: password)
              .then((value) => postDetailsToFirestore(
                  rool, email, nama, rt, rw, wa, password));
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

  //Login//
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

  //Simpan Data User di Firestore//
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
      'email': c.emailsignupC.text,
      'nama_lengkap': c.namasignupC.text,
      'rt': c.rtsignupC.text,
      'rw': c.rwsignupC.text,
      'wa': c.wasignupC.text,
      'password': c.passwordsignupC.text,
      'foto_profil': imageProfilUrl,
      'poin': 0
    });

    final currUser = await users.doc(auth.currentUser!.email).get();
    final currUserData = currUser.data() as Map<String, dynamic>;

    user(UsersModel.fromJson(currUserData));

    user(UsersModel(
        uid: currUser.id,
        email: currUserData["email"],
        namaLengkap: currUserData["nama_lengkap"],
        rt: currUserData["rt"],
        rw: currUserData["rw"],
        wa: currUserData["wa"],
        poin: currUserData['poin'],
        fotoProfil: currUserData["foto_profil"],
        rool: currUserData["rool"],
        password: currUserData["password"]));

    Get.offNamed(AppLinks.LOGIN);
  }

  //Direct to Home Page
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

        user(UsersModel(
            uid: currUser.id,
            email: currUserData["email"],
            namaLengkap: currUserData["nama_lengkap"],
            rt: currUserData["rt"],
            rw: currUserData["rw"],
            wa: currUserData["wa"],
            poin: currUserData['poin'],
            fotoProfil: currUserData["foto_profil"],
            rool: currUserData["rool"],
            password: currUserData["password"]));

        print(currUserData);
        user.refresh();
        Get.offNamed(AppLinks.HOME);
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  //Logout
  Future<void> logOut() async {
    await auth.signOut();
    Get.offAllNamed(AppLinks.LOGIN);
  }
}
