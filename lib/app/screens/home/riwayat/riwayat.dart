// ignore_for_file: sized_box_for_whitespace
import 'package:aplikasi_sampah/app/constant/fontStyle.dart';
import 'package:aplikasi_sampah/app/constant/style.dart';
import 'package:aplikasi_sampah/app/screens/auth/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:aplikasi_sampah/app/constant/color.dart';
import 'package:get/get.dart';
import 'detail_riwayat.dart';
import 'riwayat_controller.dart';

class RiwayatView extends StatefulWidget {
  const RiwayatView({super.key});

  @override
  State<RiwayatView> createState() => _RiwayatViewState();
}

class _RiwayatViewState extends State<RiwayatView> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final RiwayatController riwayatC = Get.put(RiwayatController());
  final AuthController authC = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      appBar: AppBar(
        title: const Text("Riwayat Kirim", style: appFontTitlePage),
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
        padding: const EdgeInsets.all(24.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: riwayatC.riwayatStream(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(color: colorPrimary));
            } else if (snapshot.connectionState == ConnectionState.active ||
                snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              } else if (snapshot.hasData) {
                return ListView(
                  primary: false,
                  shrinkWrap: true,
                  children: snapshot.data!.docs.map((DocumentSnapshot doc) {
                    Map<String, dynamic> data =
                        doc.data()! as Map<String, dynamic>;
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const DetailRiwayatView(),
                                  settings: RouteSettings(arguments: data)));
                        },
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: const EdgeInsets.all(8),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: data['status'] == 'Menunggu'
                                ? boxDecorationInputActive
                                : boxDecorationInput,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Tanggal",
                                        style: appFontFormInput),
                                    const SizedBox(height: 4),
                                    Text(data['tgl'], style: appFontHeding3b),
                                    const SizedBox(height: 8),
                                    data['status'] == 'Diterima'
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text("Organik",
                                                      style: appFontFormInput),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                      data['jumlah'].toString(),
                                                      style: appFontHeding3b),
                                                ],
                                              ),
                                              const SizedBox(width: 8),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text("Anorganik",
                                                      style: appFontFormInput),
                                                  const SizedBox(height: 4),
                                                  Text(data['poin'].toString(),
                                                      style: appFontHeding3b),
                                                ],
                                              )
                                            ],
                                          )
                                        : const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text("Organik",
                                                      style: appFontFormInput),
                                                  SizedBox(height: 4),
                                                  Text("-",
                                                      style: appFontHeding3b),
                                                ],
                                              ),
                                              SizedBox(width: 8),
                                              Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Anorganik",
                                                        style:
                                                            appFontFormInput),
                                                    SizedBox(height: 4),
                                                    Text("-",
                                                        style: appFontHeding3b),
                                                  ])
                                            ],
                                          )
                                  ],
                                ),
                                data['status'] == 'Ditolak'
                                    ? Text(data['status'],
                                        style: appFontHeding3c)
                                    : Text(data['status'],
                                        style: appFontHeding3b)
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
          },
        ),
      )),
    );
  }
}
