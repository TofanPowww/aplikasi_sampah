import 'package:aplikasi_sampah/app/constant/color.dart';
import 'package:aplikasi_sampah/app/constant/fontStyle.dart';
import 'package:aplikasi_sampah/app/screens/home/admin/add_petugas/add_petugas.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'add_petugas_controller.dart';

class KelolaPetugas extends StatefulWidget {
  const KelolaPetugas({super.key});

  @override
  State<KelolaPetugas> createState() => _KelolaPetugasState();
}

class _KelolaPetugasState extends State<KelolaPetugas> {
  final AddPetugasController petugasC = Get.put(AddPetugasController());
  final Stream<QuerySnapshot> _listPetugas = FirebaseFirestore.instance
      .collection('users')
      .where('rool', isEqualTo: 'Petugas')
      .snapshots();
  @override
  Widget build(BuildContext context) {
    final dataPass = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      backgroundColor: colorBackground,
      appBar: AppBar(
        title: const Text('Petugas', style: appFontTitlePage),
        centerTitle: true,
        backgroundColor: colorPrimary,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: colorBackground)),
        actions: [
          IconButton(
              onPressed: () {
                petugasC.downloadPetugas();
              },
              icon: const Icon(Icons.picture_as_pdf_rounded,
                  color: colorBackground)),
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddPetugas(),
                      settings: RouteSettings(arguments: dataPass)),
                );
              },
              icon:
                  const Icon(Icons.person_add_rounded, color: colorBackground))
        ],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Daftar Petugas Aktif", style: appFontHeding2),
            const SizedBox(height: 16),
            StreamBuilder<QuerySnapshot>(
                stream: _listPetugas,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator(color: colorPrimary));
                  } else if (snapshot.connectionState ==
                          ConnectionState.active ||
                      snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot ds = snapshot.data!.docs[index];
                            return Container(
                              height: 200,
                              width: Get.width,
                              margin: const EdgeInsets.only(bottom: 16),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15)),
                                  border: Border.all(
                                      color: colorPrimary, width: 1.5)),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text("Nama",
                                            style: appFontFormInput),
                                        const SizedBox(height: 4),
                                        Text(ds['nama_lengkap'],
                                            style: appFontHeding3b),
                                        const SizedBox(height: 8),
                                        const Text("Email",
                                            style: appFontFormInput),
                                        const SizedBox(height: 4),
                                        Text(ds['email'],
                                            style: appFontHeding3b),
                                        const SizedBox(height: 8),
                                        const Text("No. WhatsApp",
                                            style: appFontFormInput),
                                        const SizedBox(height: 3),
                                        Text(ds['no_wa'],
                                            style: appFontHeding3b),
                                      ],
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          Get.defaultDialog(
                                              backgroundColor: colorBackground2,
                                              barrierDismissible: false,
                                              title: "Konfirmasi",
                                              content: const Text(
                                                "Apakah yakin ingin menghapus akun?",
                                                style: appFontFormInput,
                                              ),
                                              titleStyle: appFontFormInputa,
                                              titlePadding:
                                                  const EdgeInsets.only(
                                                      top: 16, bottom: 8),
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      bottom: 16,
                                                      right: 16,
                                                      left: 16),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text("Tidak",
                                                        style:
                                                            appFontFormInput)),
                                                ElevatedButton(
                                                    style: const ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStatePropertyAll(
                                                              colorAccent),
                                                    ),
                                                    onPressed: () {
                                                      petugasC.deletePetugas(
                                                          ds['email']
                                                              .toString()
                                                              .trim());
                                                    },
                                                    child: const Text("Ya",
                                                        style: appFontButtonb))
                                              ]);
                                        },
                                        icon: const Icon(Icons.delete_rounded,
                                            color: appDanger))
                                  ],
                                ),
                              ),
                            );
                          });
                    } else {
                      return const Center(
                          child:
                              Text('Tidak ada petugas', style: appFontHeding2));
                    }
                  } else {
                    return Text('State: ${snapshot.connectionState}');
                  }
                })
          ],
        ),
      )),
    );
  }
}
