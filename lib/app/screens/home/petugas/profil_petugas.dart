import 'package:aplikasi_sampah/app/constant/color.dart';
import 'package:aplikasi_sampah/app/constant/fontStyle.dart';
import 'package:aplikasi_sampah/app/constant/style.dart';
import 'package:aplikasi_sampah/app/screens/home/petugas/profilpetugas_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilPetugas extends StatefulWidget {
  const ProfilPetugas({super.key});

  @override
  State<ProfilPetugas> createState() => _ProfilPetugasState();
}

class _ProfilPetugasState extends State<ProfilPetugas> {
  final ProfilPetugasController profilPetugasC =
      Get.put(ProfilPetugasController());
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
                  color: colorBackground))),
      body: SafeArea(
          child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: profilPetugasC.streamPetugas(),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(color: colorPrimary));
              }
              if (snap.hasData) {
                Map<String, dynamic> data = snap.data!.data()!;
                profilPetugasC.emailPetugasC.text = data['email'];
                profilPetugasC.namaPetugasC.text = data['nama_lengkap'];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          const Text("Petugas", style: appFontHeding1),
                          const SizedBox(height: 16),
                          CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "https://ui-avatars.com/api/?name=${data['nama_lengkap']}"),
                              radius: 80),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text("Email", style: appFontHeding3a),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: profilPetugasC.emailPetugasC,
                      autocorrect: false,
                      readOnly: true,
                      style: appFontLabelForm,
                      cursorColor: colorPrimary,
                      cursorHeight: 25,
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: colorSecondary,
                          enabledBorder: enableInputBorder,
                          focusedBorder: focusInputBorder),
                    ),
                    const SizedBox(height: 16),
                    const Text("Nama Lengkap", style: appFontHeding3a),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: profilPetugasC.namaPetugasC,
                      autocorrect: false,
                      readOnly: true,
                      style: appFontLabelForm,
                      cursorColor: colorPrimary,
                      cursorHeight: 25,
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: colorSecondary,
                          enabledBorder: enableInputBorder,
                          focusedBorder: focusInputBorder),
                    )
                  ],
                );
              } else {
                return const Text("Data tidak ada");
              }
            }),
      )),
    );
  }
}
