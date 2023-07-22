import 'package:aplikasi_sampah/app/constant/fontStyle.dart';
import 'package:aplikasi_sampah/app/constant/style.dart';
import 'package:aplikasi_sampah/service/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aplikasi_sampah/app/constant/color.dart';
import 'profil_controller.dart';

class ProfilView extends GetView<ProfilController> {
  const ProfilView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfilController profilController = Get.put(ProfilController());
    final AuthController authC = Get.put(AuthController());

    return Scaffold(
      backgroundColor: colorBackground,
      appBar: AppBar(
          title: const Text("Profil", style: appFontTitlePage),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: colorBackground)),
          backgroundColor: colorPrimary),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Akun", style: appFontHeding3),
              const SizedBox(height: 16),
              StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  stream: profilController.roleUser(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    String roleUser = snapshot.data!.data()!["rool"];
                    if (roleUser == "Admin") {
                      return GestureDetector(
                          onTap: () => profilController.toProfilAdmin(),
                          child: Container(
                              padding:
                                  const EdgeInsets.only(left: 16, right: 16),
                              height: 56,
                              width: double.infinity,
                              decoration: boxDecorationInputSmall,
                              child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Profil Saya",
                                        style: appFontFormInputc),
                                    Icon(Icons.arrow_forward_ios_rounded,
                                        color: colorPrimary, size: 20)
                                  ])));
                    }
                    if (roleUser == "Petugas") {
                      return GestureDetector(
                          onTap: () => profilController.toProfilPetugas(),
                          child: Container(
                              padding:
                                  const EdgeInsets.only(left: 16, right: 16),
                              height: 56,
                              width: double.infinity,
                              decoration: boxDecorationInputSmall,
                              child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Profil Saya",
                                        style: appFontFormInputc),
                                    Icon(Icons.arrow_forward_ios_rounded,
                                        color: colorPrimary, size: 20)
                                  ])));
                    } else {
                      return GestureDetector(
                          onTap: () => profilController.toProfilSaya(),
                          child: Container(
                              padding:
                                  const EdgeInsets.only(left: 16, right: 16),
                              height: 56,
                              width: double.infinity,
                              decoration: boxDecorationInputSmall,
                              child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Profil Saya",
                                        style: appFontFormInputc),
                                    Icon(Icons.arrow_forward_ios_rounded,
                                        color: colorPrimary, size: 20)
                                  ])));
                    }
                  }),
              const SizedBox(height: 16),
              GestureDetector(
                  onTap: () => profilController.toResetPassword(),
                  child: Container(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      height: 56,
                      width: double.infinity,
                      decoration: boxDecorationInputSmall,
                      child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Reset Password", style: appFontFormInputc),
                            Icon(Icons.arrow_forward_ios_rounded,
                                color: colorPrimary, size: 20)
                          ]))),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => authC.logOut(),
                child: Container(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  height: 56,
                  width: double.infinity,
                  decoration: boxDecorationDanger,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Logout", style: appFontFormInputd),
                      Icon(Icons.logout_rounded, color: appDanger, size: 20)
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                  onPressed: () async {
                    profilController.test1();
                  },
                  child: const Text("Test Workmanager"))
            ],
          ),
        ),
      )),
    );
  }
}
