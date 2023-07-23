import 'package:aplikasi_sampah/app/constant/fontStyle.dart';
import 'package:aplikasi_sampah/app/constant/style.dart';
import 'package:aplikasi_sampah/app/screens/home/warga/tukar/tukar_controller.dart';
import 'package:aplikasi_sampah/app/screens/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../../constant/color.dart';
import 'package:get/get.dart';

class TukarPoinView extends StatefulWidget {
  const TukarPoinView({super.key});
  @override
  State<TukarPoinView> createState() => _TukarPoinView();
}

class _TukarPoinView extends State<TukarPoinView> {
  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final Stream<QuerySnapshot> _produkStream = FirebaseFirestore.instance
      .collection('produk')
      .orderBy('poin', descending: false)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    final TukarController tukarC = Get.put(TukarController());
    final poin =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
        backgroundColor: colorBackground,
        appBar: AppBar(
            title: const Text("Tukar Poin", style: appFontTitlePage),
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
                    tukarC.toTukarRiwayat();
                  },
                  icon: const Icon(Icons.history_rounded))
            ]),
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(24),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1.5,
                                color: colorPrimary,
                                style: BorderStyle.solid),
                            boxShadow: [boxShadow],
                            gradient: const LinearGradient(
                                colors: [colorAccent, colorAccent2]),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15))),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text("Poin terkumpul",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "Satoshi",
                                      fontWeight: FontWeight.w500,
                                      color: colorPrimary)),
                              Text(
                                  poin["poin"].toString(),
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontFamily: "Satoshi",
                                      fontWeight: FontWeight.w600,
                                      color: colorPrimary)),
                            ])),
                    const SizedBox(height: 32),
                    const Text("Produk",
                        style: TextStyle(
                            fontFamily: "Satoshi",
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: colorPrimary)),
                    const SizedBox(height: 18),
                    StreamBuilder<QuerySnapshot>(
                        stream: _produkStream,
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator(
                              color: colorPrimary,
                            ));
                          } else if (snapshot.connectionState ==
                                  ConnectionState.active ||
                              snapshot.connectionState ==
                                  ConnectionState.done) {
                            if (snapshot.hasError) {
                              return const Text('Something went wrong');
                            } else if (snapshot.hasData) {
                              return ListView(
                                primary: false,
                                shrinkWrap: true,
                                children: snapshot.data!.docs
                                    .map((DocumentSnapshot document) {
                                  Map<String, dynamic> data =
                                      document.data()! as Map<String, dynamic>;
                                  return Container(
                                      height: 102,
                                      width: Get.width,
                                      margin: const EdgeInsets.only(bottom: 16),
                                      decoration: boxDecoration,
                                      child: Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(data['nama'],
                                                    style: appFontHeding2a),
                                                const SizedBox(height: 8),
                                                Text("${data['poin']} Poin",
                                                    style: appFontHeding1a)
                                              ],
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            DetailProdukView(
                                                                poinW: poin[
                                                                    "poin"]),
                                                        settings: RouteSettings(
                                                            arguments: data)));
                                              },
                                              icon: const Icon(Icons
                                                  .arrow_forward_ios_rounded),
                                              color: colorPrimary,
                                            )
                                          ],
                                        ),
                                      ));
                                }).toList(),
                              );
                            } else {
                              return const Center(
                                  child: Text('Tidak ada produk',
                                      style: appFontHeding2));
                            }
                          } else {
                            return Text('State: ${snapshot.connectionState}');
                          }
                        })
                  ],
                ),
              )),
        ));
  }
}
