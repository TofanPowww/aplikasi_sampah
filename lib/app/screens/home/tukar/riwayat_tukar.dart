// ignore_for_file: sized_box_for_whitespace, avoid_print

import 'package:aplikasi_sampah/app/constant/color.dart';
import 'package:aplikasi_sampah/app/screens/auth/auth_controller.dart';
import 'package:aplikasi_sampah/app/screens/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../constant/fontStyle.dart';
import '../../../constant/style.dart';
import 'tukar_controller.dart';

class RiwayatTukarView extends StatefulWidget {
  const RiwayatTukarView({super.key});

  @override
  State<RiwayatTukarView> createState() => _RiwayatTukarViewState();
}

class _RiwayatTukarViewState extends State<RiwayatTukarView> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  final TukarController tukarC = Get.put(TukarController());
  final AuthController authC = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      appBar: AppBar(
        title: const Text("Riwayat Penukaran", style: appFontTitlePage),
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
        child: StreamBuilder<QuerySnapshot>(
            stream: tukarC.riwayatTukarStream(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(color: colorAccent));
              } else if (snapshot.connectionState == ConnectionState.active ||
                  snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Error"),
                  );
                } else if (snapshot.hasData) {
                  return ListView(
                    primary: false,
                    shrinkWrap: true,
                    children: snapshot.data!.docs.map((DocumentSnapshot doc) {
                      Map<String, dynamic> data =
                          doc.data()! as Map<String, dynamic>;

                      Future<void> batasWaktu() async {
                        final endTime = DateTime.parse(data['creationTime'])
                            .add(const Duration(days: 3));
                        final endTimeFormat =
                            DateFormat('dd MMMM yyyy - HH:mm:ss', "id_ID")
                                .format(endTime);
                        final today =
                            DateFormat('dd MMMM yyyy - HH:mm:ss', "id_ID")
                                .format(endTime);
                        if (endTimeFormat == today) {
                          User? users = auth.currentUser;
                          CollectionReference userDB = db.collection("users");
                          final tukarUser = userDB
                              .doc(users!.email)
                              .collection("tukar")
                              .doc(data['kode']);
                          try {
                            await tukarUser.update({'status': "Batal"});
                          } catch (e) {
                            print(e);
                          }
                        }
                      }

                      return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const DetailPenukaranView(),
                                    settings: RouteSettings(arguments: data)));
                          },
                          child: data['status'] == 'Batal'
                              ? Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  // color: colorSecondary,
                                  margin: const EdgeInsets.all(8),
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: boxDecorationInput,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Nama Produk",
                                              style: appFontFormInput,
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              data['nama_produk'],
                                              style: appFontHeding3b,
                                            ),
                                            const SizedBox(height: 8),
                                            const Text(
                                              "Poin Produk",
                                              style: appFontFormInput,
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              data['poin_produk'].toString(),
                                              style: appFontHeding3b,
                                            ),
                                          ],
                                        ),
                                        Text(
                                          data['status'],
                                          style: appFontHeding3b,
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              : data['status'] == 'Selesai'
                                  ? Card(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      color: appBackgroundSecondary,
                                      margin: const EdgeInsets.all(8),
                                      child: Container(
                                        padding: const EdgeInsets.all(16),
                                        decoration: boxDecorationInput,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "Nama Produk",
                                                  style: appFontFormInput,
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  data['nama_produk'],
                                                  style: appFontHeding3b,
                                                ),
                                                const SizedBox(height: 8),
                                                const Text(
                                                  "Poin Produk",
                                                  style: appFontFormInput,
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  data['poin_produk']
                                                      .toString(),
                                                  style: appFontHeding3b,
                                                ),
                                              ],
                                            ),
                                            Text(
                                              data['status'],
                                              style: appFontHeding3b,
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  : Card(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      color: appSecondary,
                                      margin: const EdgeInsets.all(8),
                                      child: Container(
                                        padding: const EdgeInsets.all(16),
                                        decoration: boxDecorationInputActive,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "Nama Produk",
                                                  style: appFontFormInput,
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  data['nama_produk'],
                                                  style: appFontHeding3b,
                                                ),
                                                const SizedBox(height: 8),
                                                const Text(
                                                  "Poin Produk",
                                                  style: appFontFormInput,
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  data['poin_produk']
                                                      .toString(),
                                                  style: appFontHeding3b,
                                                ),
                                              ],
                                            ),
                                            Text(
                                              data['status'],
                                              style: appFontHeding3b,
                                            )
                                          ],
                                        ),
                                      ),
                                    ));
                    }).toList(),
                  );
                } else {
                  return const Center(
                      child: Text('Tidak ada riwayat', style: appFontHeding2));
                }
              } else {
                return Text('State: ${snapshot.connectionState}');
              }
            }),
      )),
    );
  }
}
