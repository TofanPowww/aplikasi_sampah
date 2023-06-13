// ignore_for_file: avoid_print, sized_box_for_whitespace

import 'package:aplikasi_sampah/app/constant/color.dart';
import 'package:aplikasi_sampah/app/constant/fontStyle.dart';
import 'package:aplikasi_sampah/app/screens/auth/auth_controller.dart';
import 'package:aplikasi_sampah/app/screens/home/petugas/request_pengambilan/request_pengambilan_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'detail_request.dart';

class RequestPengambilan extends StatefulWidget {
  const RequestPengambilan({super.key});

  @override
  State<RequestPengambilan> createState() => _RequestPengambilan();
}

class _RequestPengambilan extends State<RequestPengambilan> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final RequestPengambilanController requestC =
      Get.put(RequestPengambilanController());
  final AuthController authC = Get.put(AuthController());
  final Stream<QuerySnapshot> _kirimSampahStream = FirebaseFirestore.instance
      .collection('transaksiSampah')
      .where('status', isEqualTo: 'Menunggu')
      .orderBy('creationTime', descending: true)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorBackground,
        appBar: AppBar(
          title: const Text("Permintaan Pengambilan", style: appFontTitlePage),
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
                    stream: _kirimSampahStream,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                            child:
                                CircularProgressIndicator(color: colorPrimary));
                      } else if (snapshot.connectionState ==
                              ConnectionState.active ||
                          snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text("Error"),
                          );
                        } else if (snapshot.hasData) {
                          return ListView(
                            primary: false,
                            shrinkWrap: true,
                            children: snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                              Map<String, dynamic> data =
                                  document.data()! as Map<String, dynamic>;
                              return Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: const BorderSide(
                                        color: colorPrimary,
                                        width: 1.5,
                                        style: BorderStyle.solid)),
                                color: colorSecondary,
                                margin: const EdgeInsets.all(8),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
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
                                          const Text("Nama Warga",
                                              style: appFontFormInput),
                                          const SizedBox(height: 4),
                                          Text(data['nama'],
                                              style: appFontHeding3b),
                                          const SizedBox(height: 8),
                                          const Text("RT/RW",
                                              style: appFontFormInput),
                                          const SizedBox(height: 4),
                                          Text(
                                            "${data['rt']} / ${data['rw']}",
                                            style: appFontHeding3b,
                                          )
                                        ],
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const DetailRequestView(),
                                                  settings: RouteSettings(
                                                      arguments: data)));
                                        },
                                        icon: const Icon(
                                            Icons.arrow_forward_ios_rounded),
                                        color: colorPrimary,
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                        } else {
                          return const Text('Empty data');
                        }
                      } else {
                        return Text('State: ${snapshot.connectionState}');
                      }
                    }))));
  }
}
