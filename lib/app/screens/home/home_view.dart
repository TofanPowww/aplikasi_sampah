// ignore_for_file: public_member_api_docs, sort_constructors_first, no_leading_underscores_for_local_identifiers
// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'package:aplikasi_sampah/app/constant/color.dart';
import 'package:aplikasi_sampah/app/constant/fontStyle.dart';
import 'package:aplikasi_sampah/app/screens/auth/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constant/style.dart';
import 'home_controller.dart';
import 'tukar/tukar.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    requestPermission();
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    final HomeController homeC = Get.put(HomeController());
    final AuthController authC = Get.put(AuthController());

    return Scaffold(
        backgroundColor: appBackgroundPrimary,
        body: SafeArea(
          child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  stream: homeC.streamRole(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    String role = snapshot.data!.data()!["rool"];
                    Map<String, dynamic> dataUser =
                        snapshot.data!.data() as Map<String, dynamic>;
                    if (role == "Warga") {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Selamat Datang,", style: appFontHeding3),
                          Text(
                            // dataUser['nama_lengkap'],
                            snapshot.data!.data()!['nama_lengkap'],
                            // "${authC.user.value.namaLengkap}",
                            style: appFontHeding1,
                          ),
                          const SizedBox(height: 24),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const TukarPoinView(),
                                    settings:
                                        RouteSettings(arguments: dataUser)),
                              );
                            },
                            child: Container(
                              height: 150,
                              width: Get.width,
                              decoration: BoxDecoration(
                                boxShadow: [boxShadow],
                                border:
                                    Border.all(color: colorPrimary, width: 1.5),
                                gradient: const LinearGradient(
                                    colors: [colorAccent, colorAccent2]),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    bottom: -30,
                                    right: -10,
                                    child: Opacity(
                                      opacity: 1.0,
                                      // ignore: sized_box_for_whitespace
                                      child: Container(
                                        width: 180,
                                        height: 180,
                                        child: Image.asset(
                                          "assets/images/woolly_money.png",
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Row(
                                          children: [
                                            Text("Poin", style: appFontHeding)
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          snapshot.data!
                                              .data()!['poin']
                                              .toString(),
                                          style: appFontTitle,
                                        ),
                                        const SizedBox(height: 4),
                                        const Text("Tukar poin",
                                            style: appFontHeding3)
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          const Text("Menu", style: appFontHeding3),
                          const SizedBox(height: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () => homeC.toKirimSampah(),
                                child: Container(
                                  height: 100,
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(16),
                                  decoration: boxDecoration,
                                  child: const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Kirim Sampah",
                                          style: appFontHeding2),
                                      Icon(Icons.arrow_forward_ios_rounded,
                                          color: colorPrimary, size: 30)
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const TukarPoinView(),
                                        settings:
                                            RouteSettings(arguments: dataUser)),
                                  );
                                },
                                child: Container(
                                  height: 100,
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(16),
                                  decoration: boxDecoration,
                                  child: const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Tukar Poin", style: appFontHeding2),
                                      Icon(Icons.arrow_forward_ios_rounded,
                                          color: colorPrimary, size: 30)
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              GestureDetector(
                                onTap: () => homeC.toRiwayat(),
                                child: Container(
                                  height: 100,
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(16),
                                  decoration: boxDecoration,
                                  child: const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Riwayat Kirim",
                                          style: appFontHeding2),
                                      Icon(Icons.arrow_forward_ios_rounded,
                                          color: colorPrimary, size: 30)
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              GestureDetector(
                                onTap: () => homeC.toProfil(),
                                child: Container(
                                  height: 100,
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(16),
                                  decoration: boxDecoration,
                                  child: const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Profil", style: appFontHeding2),
                                      Icon(Icons.arrow_forward_ios_rounded,
                                          color: colorPrimary, size: 30)
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }
                    if (role == "Admin") {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Selamat Datang, ", style: appFontHeding3),
                          Text("${authC.user.value.namaLengkap}",
                              style: appFontHeding1),
                          const SizedBox(height: 24),
                          const Text("Menu", style: appFontHeding3),
                          const SizedBox(height: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () => homeC.toKelolaPetugas(),
                                child: Container(
                                  height: 100,
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(16),
                                  decoration: boxDecoration,
                                  child: const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Petugas", style: appFontHeding2),
                                      Icon(Icons.arrow_forward_ios_rounded,
                                          color: colorPrimary, size: 30)
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              GestureDetector(
                                onTap: () => homeC.toKelolaProduk(),
                                child: Container(
                                  height: 100,
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(16),
                                  decoration: boxDecoration,
                                  child: const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Produk", style: appFontHeding2),
                                      Icon(Icons.arrow_forward_ios_rounded,
                                          color: colorPrimary, size: 30)
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              GestureDetector(
                                onTap: () => homeC.toTransaksiSampah(),
                                child: Container(
                                  height: 100,
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(16),
                                  decoration: boxDecoration,
                                  child: const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Transaksi Sampah",
                                          style: appFontHeding2),
                                      Icon(Icons.arrow_forward_ios_rounded,
                                          color: colorPrimary, size: 30)
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              GestureDetector(
                                onTap: () => homeC.toTransaksiPoin(),
                                child: Container(
                                  height: 100,
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(16),
                                  decoration: boxDecoration,
                                  child: const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Transaksi Penukaran",
                                          style: appFontHeding2),
                                      Icon(Icons.arrow_forward_ios_rounded,
                                          color: colorPrimary, size: 30)
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              GestureDetector(
                                onTap: () => homeC.toProfil(),
                                child: Container(
                                  height: 100,
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(16),
                                  decoration: boxDecoration,
                                  child: const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Profil", style: appFontHeding2),
                                      Icon(Icons.arrow_forward_ios_rounded,
                                          color: colorPrimary, size: 30)
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Selamat datang", style: appFontHeding3),
                          Text("${authC.user.value.namaLengkap}",
                              style: appFontHeding1),
                          const SizedBox(height: 24),
                          const Text("Menu", style: appFontHeding3),
                          const SizedBox(height: 16),
                          GestureDetector(
                            onTap: () => homeC.toRequest(),
                            child: Container(
                              width: double.infinity,
                              height: 100.0,
                              padding: const EdgeInsets.all(16),
                              decoration: boxDecoration,
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Permintaan Pengambilan",
                                      style: appFontHeding2),
                                  Icon(Icons.arrow_forward_ios_rounded,
                                      color: colorPrimary, size: 30)
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          GestureDetector(
                            onTap: () => homeC.toRiwayatPengambilan(),
                            child: Container(
                              width: double.infinity,
                              height: 100.0,
                              padding: const EdgeInsets.all(16),
                              decoration: boxDecoration,
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Riwayat Pengambilan",
                                      style: appFontHeding2),
                                  Icon(Icons.arrow_forward_ios_rounded,
                                      color: colorPrimary, size: 30)
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          GestureDetector(
                            onTap: () => homeC.toProfil(),
                            child: Container(
                              width: double.infinity,
                              height: 100.0,
                              padding: const EdgeInsets.all(16),
                              decoration: boxDecoration,
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Profil", style: appFontHeding2),
                                  Icon(Icons.arrow_forward_ios_rounded,
                                      color: colorPrimary, size: 30)
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  })),
        ));
  }

  FirebaseMessaging message = FirebaseMessaging.instance;
  String? mToken = "";
  void requestPermission() async {
    NotificationSettings settings = await message.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User decline or has not accepted permissions');
    }
  }

  //Get Users Token//
  void getToken() async {
    await message.getToken().then((token) {
      setState(() {
        mToken = token;
        print("My Token is $mToken");
      });
      saveToken(token!);
    });
  }

  void saveToken(String token) async {
    await db.collection("users").doc(auth.currentUser!.email).update({
      "token": token,
    });
  }
}
