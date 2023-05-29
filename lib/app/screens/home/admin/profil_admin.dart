import 'package:aplikasi_sampah/app/constant/color.dart';
import 'package:aplikasi_sampah/app/constant/fontStyle.dart';
import 'package:aplikasi_sampah/app/constant/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'profiladmin_controller.dart';

class ProfilAdmin extends StatefulWidget {
  const ProfilAdmin({super.key});

  @override
  State<ProfilAdmin> createState() => _ProfilAdminState();
}

class _ProfilAdminState extends State<ProfilAdmin> {
  final ProfilAdminController profilAdminC = Get.put(ProfilAdminController());
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
            stream: profilAdminC.streamAdmin(),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(color: colorPrimary));
              }
              if (snap.hasData) {
                Map<String, dynamic> data = snap.data!.data()!;
                profilAdminC.emailAdminC.text = data['email'];
                profilAdminC.namaAdminC.text = data['nama_lengkap'];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          const Text("Admin", style: appFontHeding1),
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
                      controller: profilAdminC.emailAdminC,
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
                      controller: profilAdminC.namaAdminC,
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
