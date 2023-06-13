// ignore_for_file: avoid_print, unrelated_type_equality_checks, unnecessary_null_comparison, prefer_if_null_operators
import 'dart:io';
import 'package:aplikasi_sampah/app/constant/color.dart';
import 'package:aplikasi_sampah/app/constant/fontStyle.dart';
import 'package:aplikasi_sampah/app/constant/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'profilsaya_controller.dart';

class ProfilSayaView extends StatefulWidget {
  const ProfilSayaView({super.key});
  @override
  State<ProfilSayaView> createState() => _ProfilSayaViewState();
}

class _ProfilSayaViewState extends State<ProfilSayaView> {
  final ProfilSayaController profilsayaC = Get.put(ProfilSayaController());
  RxBool isLoading = false.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      appBar: AppBar(
        title: const Text("Profil Saya", style: appFontTitlePage),
        centerTitle: true,
        backgroundColor: colorPrimary,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: colorBackground)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: profilsayaC.streamUser(),
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator(color: colorPrimary));
                }
                if (snap.hasData) {
                  Map<String, dynamic> data = snap.data!.data()!;
                  profilsayaC.emailC.text = data['email'];
                  profilsayaC.namaC.text = data['nama_lengkap'];
                  profilsayaC.rtC.text = data['rt'];
                  profilsayaC.rwC.text = data['rw'];
                  profilsayaC.waC.text = data['no_wa'];
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Column(
                            children: [
                              const Text("Warga", style: appFontHeding1),
                              const SizedBox(height: 16),
                              CircleAvatar(
                                  backgroundImage: profilsayaC.imageProfil ==
                                          null
                                      ? NetworkImage(data['foto_profil']) != ""
                                          ? NetworkImage(data['foto_profil'])
                                          : NetworkImage(
                                              "https://ui-avatars.com/api/?name=${data['nama_lengkap']}")
                                      : FileImage(File(
                                              profilsayaC.imageProfil!.path))
                                          as ImageProvider,
                                  radius: 80),
                              const SizedBox(height: 16),
                              InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (context) =>
                                            bottomSheet(context));
                                  },
                                  child: const Text(
                                    "Ubah foto profil",
                                    style: appFontButtonText,
                                  ))
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        Form(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              const Text("Email", style: appFontHeding3a),
                              const SizedBox(height: 8),
                              TextFormField(
                                  controller: profilsayaC.emailC,
                                  autocorrect: false,
                                  readOnly: true,
                                  style: appFontLabelForm,
                                  keyboardType: TextInputType.name,
                                  cursorColor: colorPrimary,
                                  cursorHeight: 25,
                                  decoration: const InputDecoration(
                                      filled: true,
                                      fillColor: colorSecondary,
                                      enabledBorder: enableInputBorder,
                                      focusedBorder: focusInputBorder)),
                              const SizedBox(height: 16),
                              const Text("Nama Lengkap",
                                  style: appFontHeding3a),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: profilsayaC.namaC,
                                style: appFontLabelForm,
                                keyboardType: TextInputType.name,
                                cursorColor: colorPrimary,
                                cursorHeight: 25,
                                decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: colorSecondary,
                                    enabledBorder: enableInputBorder,
                                    focusedBorder: focusInputBorder),
                              ),
                              const SizedBox(height: 16),
                              const Text("RT", style: appFontHeding3a),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: profilsayaC.rtC,
                                style: appFontLabelForm,
                                cursorColor: colorPrimary,
                                cursorHeight: 25,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: colorSecondary,
                                    enabledBorder: enableInputBorder,
                                    focusedBorder: focusInputBorder),
                              ),
                              const SizedBox(height: 16),
                              const Text("RW", style: appFontHeding3a),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: profilsayaC.rwC,
                                style: appFontLabelForm,
                                keyboardType: TextInputType.number,
                                cursorColor: colorPrimary,
                                cursorHeight: 25,
                                decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: colorSecondary,
                                    enabledBorder: enableInputBorder,
                                    focusedBorder: focusInputBorder),
                              ),
                              const SizedBox(height: 16),
                              const Text("No. WhatsApp",
                                  style: appFontHeding3a),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: profilsayaC.waC,
                                style: appFontLabelForm,
                                keyboardType: TextInputType.phone,
                                cursorColor: colorPrimary,
                                cursorHeight: 25,
                                decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: colorSecondary,
                                    enabledBorder: enableInputBorder,
                                    focusedBorder: focusInputBorder),
                              ),
                              const SizedBox(height: 32),
                              SizedBox(
                                  width: double.infinity,
                                  height: 56,
                                  child: Obx(() => ElevatedButton(
                                      onPressed: () {
                                        profilsayaC.isLoading.value
                                            ? null
                                            : profilsayaC
                                                .updateProfile(data['email']);
                                      },
                                      style: btnStylePrimary,
                                      child: profilsayaC.isLoading.value
                                          ? const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                CircularProgressIndicator(
                                                    color: colorBackground),
                                                SizedBox(width: 16),
                                                Text("Sedang memuat...",
                                                    style: appFontButton),
                                              ],
                                            )
                                          : const Text(
                                              "Simpan",
                                              style: appFontButton,
                                            ))))
                            ]))
                      ]);
                } else {
                  return const Text("Data tidak ada");
                }
              }),
        ),
      ),
    );
  }

  Widget bottomSheet(BuildContext context) {
    final picker = ImagePicker();
    //Kamera//
    Future kamera() async {
      try {
        final XFile? pick = await picker.pickImage(source: ImageSource.camera);
        setState(() {
          profilsayaC.imageProfil = File(pick!.path);
          profilsayaC.extImageProfil =
              File(pick.name.split(".").last).toString();
        });
      } catch (e) {
        print(e);
      }
    }

    //Galeri//
    Future galeri() async {
      try {
        final XFile? pick = await picker.pickImage(source: ImageSource.gallery);
        setState(() {
          profilsayaC.imageProfil = File(pick!.path);
          profilsayaC.extImageProfil =
              File(pick.name.split(".").last).toString();
        });
      } catch (e) {
        print(e);
      }
    }

    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.17,
      margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        children: [
          const Text("Pilih foto profil", style: appFontHeding2),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.image_search_rounded, color: colorPrimary),
                    SizedBox(height: 16),
                    Text("Gallery", style: appFontFormInput)
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                  galeri();
                },
              ),
              const SizedBox(width: 120),
              InkWell(
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera_alt_rounded, color: colorPrimary),
                    SizedBox(height: 16),
                    Text("Kamera", style: appFontFormInput)
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                  kamera();
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
