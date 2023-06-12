// ignore_for_file: avoid_print

import 'package:aplikasi_sampah/app/constant/color.dart';
import 'package:aplikasi_sampah/app/constant/fontStyle.dart';
import 'package:aplikasi_sampah/app/constant/style.dart';
import 'package:aplikasi_sampah/app/screens/home/admin/transaksi_poin/transaksipoin_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class CetakTransaksiPoin extends StatefulWidget {
  const CetakTransaksiPoin({super.key});

  @override
  State<CetakTransaksiPoin> createState() => _CetakTransaksiPoinState();
}

class _CetakTransaksiPoinState extends State<CetakTransaksiPoin> {
  final TransaksiPoinController control = Get.put(TransaksiPoinController());
  int value1 = 0;
  int value2 = 0;
  Widget customRadioButton(String text, int index) {
    return OutlinedButton(
      style: ButtonStyle(
          shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          side: MaterialStatePropertyAll(BorderSide(
            color: (value1 == index) ? colorPrimary : colorGray,
            width: (value1 == index) ? 1.7 : 1,
          ))),
      onPressed: () {
        setState(() {
          value1 = index;
        });
      },
      child: Text(text,
          style: TextStyle(
              color: (value1 == index) ? colorPrimary : colorGray,
              fontFamily: "Satoshi",
              fontWeight:
                  (value1 == index) ? FontWeight.w700 : FontWeight.w500)),
    );
  }

  Widget customRadioButton2(String text, int index) {
    return OutlinedButton(
      style: ButtonStyle(
          shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          side: MaterialStatePropertyAll(BorderSide(
            color: (value2 == index) ? colorPrimary : colorGray,
            width: (value2 == index) ? 1.7 : 1,
          ))),
      onPressed: () {
        setState(() {
          value2 = index;
        });
      },
      child: Text(text,
          style: TextStyle(
              color: (value2 == index) ? colorPrimary : colorGray,
              fontFamily: "Satoshi",
              fontWeight:
                  (value2 == index) ? FontWeight.w700 : FontWeight.w500)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      appBar: AppBar(
        backgroundColor: colorPrimary,
        centerTitle: true,
        title: const Text("Cetak Transaksi", style: appFontTitlePage),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                decoration: boxDecorationInput,
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Waktu Transaksi", style: appFontLabelForm),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          customRadioButton("Semua", 1),
                          const SizedBox(width: 8),
                          customRadioButton("Hari ini", 2),
                          const SizedBox(width: 8),
                          customRadioButton("Bulan", 3)
                        ])
                  ],
                )),
            value1 == 3 ? const SizedBox(height: 8) : const SizedBox(),
            value1 == 3
                ? Container(
                    decoration: boxDecorationInput,
                    padding: const EdgeInsets.all(16),
                    width: double.infinity,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Waktu Transaksi",
                              style: appFontLabelForm),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                    child: customRadioButton2("Januari", 1)),
                                const SizedBox(width: 8),
                                Expanded(
                                    child: customRadioButton2("Februari", 2)),
                                const SizedBox(width: 8),
                                Expanded(child: customRadioButton2("Maret", 3)),
                                const SizedBox(width: 8),
                              ]),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(child: customRadioButton2("April", 4)),
                              const SizedBox(width: 8),
                              Expanded(child: customRadioButton2("Mei", 5)),
                              const SizedBox(width: 8),
                              Expanded(child: customRadioButton2("Juni", 6)),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: customRadioButton2("Juli", 7)),
                              const SizedBox(width: 4),
                              Expanded(
                                  flex: 2,
                                  child: customRadioButton2("Agustus", 8)),
                              const SizedBox(width: 4),
                              Expanded(
                                  flex: 2,
                                  child: customRadioButton2("September", 9)),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: customRadioButton2("Oktober", 10)),
                              const SizedBox(width: 4),
                              Expanded(
                                  child: customRadioButton2("November", 11)),
                              const SizedBox(width: 4),
                              Expanded(
                                  child: customRadioButton2("Desember", 12))
                            ],
                          )
                        ]))
                : const SizedBox(),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                  onPressed: () {
                    if (value1 == 1) {
                      control.cetakTransaksiPoin(value1, 0);
                      print("Transaksi semua waktu");
                    }
                    if (value1 == 2) {
                      Fluttertoast.showToast(msg: "Tidak ada transaksi");
                      print("Transaksi hari ini");
                    }
                    if (value1 == 3 && value2 == 1) {
                      Fluttertoast.showToast(msg: "Tidak ada transaksi");
                      print("Transaksi bulan 1");
                    }
                    if (value1 == 3 && value2 == 2) {
                      Fluttertoast.showToast(msg: "Tidak ada transaksi");
                      print("Semua jenis transaksi bulan 2");
                    }
                    if (value1 == 3 && value2 == 3) {
                      Fluttertoast.showToast(msg: "Tidak ada transaksi");
                      print("Semua jenis transaksi bulan 3");
                    }
                    if (value1 == 3 && value2 == 4) {
                      Fluttertoast.showToast(msg: "Tidak ada transaksi");
                      print("Semua jenis transaksi bulan 4");
                    }
                    if (value1 == 3 && value2 == 5) {
                      Fluttertoast.showToast(msg: "Tidak ada transaksi");
                      print("Semua jenis transaksi bulan 5");
                    }
                    if (value1 == 3 && value2 == 6) {
                      Fluttertoast.showToast(msg: "Tidak ada transaksi");
                      print("Semua jenis transaksi bulan 6");
                    }
                    if (value1 == 3 && value2 == 7) {
                      Fluttertoast.showToast(msg: "Tidak ada transaksi");
                      print("Semua jenis transaksi bulan 7");
                    }
                    if (value1 == 3 && value2 == 8) {
                      Fluttertoast.showToast(msg: "Tidak ada transaksi");
                      print("Semua jenis transaksi bulan 8");
                    }
                    if (value1 == 3 && value2 == 9) {
                      Fluttertoast.showToast(msg: "Tidak ada transaksi");
                      print("Semua jenis transaksi bulan 9");
                    }
                    if (value1 == 3 && value2 == 10) {
                      Fluttertoast.showToast(msg: "Tidak ada transaksi");
                      print("Semua jenis transaksi bulan 10");
                    }
                    if (value1 == 3 && value2 == 11) {
                      Fluttertoast.showToast(msg: "Tidak ada transaksi");
                      print("Semua jenis transaksi bulan 11");
                    }
                    if (value1 == 3 && value2 == 12) {
                      Fluttertoast.showToast(msg: "Tidak ada transaksi");
                      print("Semua jenis transaksi bulan 12");
                    }
                  },
                  style: btnStylePrimary,
                  child: const Text("Cetak Transaksi", style: appFontButton)),
            )
          ],
        ),
      )),
    );
  }
}
