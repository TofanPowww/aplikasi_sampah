import 'package:aplikasi_sampah/app/constant/color.dart';
import 'package:aplikasi_sampah/app/constant/fontStyle.dart';
import 'package:aplikasi_sampah/app/constant/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'request_pengambilan_controller.dart';

class DetailRequestView extends StatefulWidget {
  const DetailRequestView({super.key});

  @override
  State<DetailRequestView> createState() => _DetailRequestVieqState();
}

class _DetailRequestVieqState extends State<DetailRequestView> {
  RxBool isLoading = false.obs;
  int value = 0;
  String? status;
  final RequestPengambilanController kirimC =
      Get.put(RequestPengambilanController());
  Widget customRadioButton(String text, int index) {
    return OutlinedButton(
      style: ButtonStyle(
          shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          side: MaterialStatePropertyAll(BorderSide(
            color: (value == index) ? colorPrimary : colorGray,
            width: (value == index) ? 1.7 : 1,
          ))),
      onPressed: () {
        setState(() {
          value = index;
        });
      },
      child: Text(text,
          style: TextStyle(
              color: (value == index) ? colorPrimary : colorGray,
              fontFamily: "Satoshi",
              fontWeight:
                  (value == index) ? FontWeight.w700 : FontWeight.w500)),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController jmlhOrganik = TextEditingController(text: "0.0");
    TextEditingController jmlhAnorganik = TextEditingController(text: "0.0");
    TextEditingController ket = TextEditingController(text: "-");
    final request =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      backgroundColor: colorBackground,
      appBar: AppBar(
        title: const Text("Detail Permintaan", style: appFontTitlePage),
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
              child: Padding(
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
                    const Text("Email", style: appFontFormInput),
                    const SizedBox(height: 4),
                    Text(request['email'], style: appFontHeding2),
                  ],
                )),
            const SizedBox(height: 8),
            Container(
                decoration: boxDecorationInput,
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Nama Warga", style: appFontFormInput),
                    const SizedBox(height: 4),
                    Text(request['nama'], style: appFontHeding2),
                  ],
                )),
            const SizedBox(height: 8),
            Container(
                decoration: boxDecorationInput,
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("RT/RW", style: appFontFormInput),
                    const SizedBox(height: 4),
                    Text("${request['rt']} / ${request['rw']}",
                        style: appFontHeding2),
                  ],
                )),
            const SizedBox(height: 8),
            Container(
              decoration: boxDecorationInput,
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              height: 85,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text("Status", style: appFontFormInput),
                  const SizedBox(width: 24),
                  DropdownButton(
                    hint: const Text("Status Request", style: appFontHeding2),
                    style: appFontHeding2,
                    dropdownColor: colorSecondary,
                    iconEnabledColor: colorAccent,
                    icon: const Icon(Icons.arrow_drop_down_rounded),
                    underline: Container(height: 0),
                    borderRadius: BorderRadius.circular(10),
                    value: status,
                    onChanged: (String? newValue) {
                      setState(() {
                        status = newValue ?? "";
                      });
                    },
                    items: <String>['Menunggu', 'Diterima', 'Ditolak']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                          value: value, child: Text(value));
                    }).toList(),
                  )
                ],
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: boxDecorationInput,
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              height: status == "Ditolak" ? 250 : 330,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      "Jumlah",
                      style: appFontFormInput,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text("Organik", style: appFontFormInput),
                  const SizedBox(height: 4),
                  Expanded(
                      child: status == "Ditolak"
                          ? TextFormField(
                              readOnly: true,
                              controller: jmlhOrganik,
                              style: appFontHeding2,
                              decoration: const InputDecoration(
                                  filled: true,
                                  enabled: true,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  focusedBorder: focusInputBorder,
                                  fillColor: colorSecondary,
                                  enabledBorder: enableInputBorder),
                            )
                          : TextFormField(
                              controller: kirimC.jumlahOrganikC,
                              maxLines: 1,
                              keyboardType: TextInputType.number,
                              style: appFontHeding2,
                              cursorColor: colorPrimary,
                              cursorHeight: 25,
                              decoration: const InputDecoration(
                                  filled: true,
                                  enabled: true,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  focusedBorder: focusInputBorder,
                                  fillColor: colorSecondary,
                                  enabledBorder: enableInputBorder),
                            )),
                  const SizedBox(height: 8),
                  const Text("Anorganik", style: appFontFormInput),
                  status == "Ditolak"
                      ? const SizedBox()
                      : const SizedBox(height: 4),
                  status == "Ditolak"
                      ? const SizedBox()
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(child: customRadioButton("Plastik", 1)),
                            const SizedBox(width: 4),
                            Expanded(child: customRadioButton("Kertas", 2)),
                            const SizedBox(width: 4),
                            Expanded(child: customRadioButton("Logam", 3)),
                          ],
                        ),
                  status == "Ditolak"
                      ? const SizedBox()
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                                flex: 1, child: customRadioButton("Besi", 4)),
                            const SizedBox(width: 4),
                            Expanded(
                                flex: 2,
                                child: customRadioButton("Botol Kaca", 5))
                          ],
                        ),
                  const SizedBox(height: 4),
                  Expanded(
                      child: status == "Ditolak"
                          ? TextFormField(
                              readOnly: true,
                              controller: jmlhAnorganik,
                              style: appFontHeding2,
                              decoration: const InputDecoration(
                                  filled: true,
                                  enabled: true,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  focusedBorder: focusInputBorder,
                                  fillColor: colorSecondary,
                                  enabledBorder: enableInputBorder),
                            )
                          : TextFormField(
                              controller: kirimC.jumlahAnorganikC,
                              maxLines: 1,
                              keyboardType: TextInputType.number,
                              style: appFontHeding2,
                              cursorColor: colorPrimary,
                              cursorHeight: 25,
                              decoration: const InputDecoration(
                                  filled: true,
                                  enabled: true,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  focusedBorder: focusInputBorder,
                                  fillColor: colorSecondary,
                                  enabledBorder: enableInputBorder),
                            )),
                ],
              ),
            ),
            const SizedBox(height: 8),
            status == "Ditolak"
                ? Container(
                    decoration: boxDecorationInput,
                    padding: const EdgeInsets.all(16),
                    width: double.infinity,
                    height: 120,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Keterangan", style: appFontFormInput),
                        const SizedBox(width: 16),
                        Expanded(
                          child: SizedBox(
                              child: TextFormField(
                            controller: kirimC.keteranganC,
                            maxLines: 3,
                            textAlign: TextAlign.justify,
                            keyboardType: TextInputType.text,
                            style: appFontFormInput,
                            cursorColor: colorPrimary,
                            cursorHeight: 25,
                            decoration: const InputDecoration(
                              filled: true,
                              enabled: true,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              focusedBorder: focusInputBorder,
                              fillColor: colorSecondary,
                              enabledBorder: enableInputBorder,
                            ),
                          )),
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
            const SizedBox(height: 8),
            Container(
                decoration: boxDecorationInput,
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Foto", style: appFontFormInput),
                    const SizedBox(height: 8),
                    Center(
                      child: SizedBox(
                          width: 300,
                          height: 300,
                          child: Image(
                            image: NetworkImage(request['foto_sampah']),
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;

                              return const Center(
                                  child: CircularProgressIndicator(
                                      color: colorPrimary));
                              // You can use LinearProgressIndicator or CircularProgressIndicator instead
                            },
                          )),
                    )
                  ],
                )),
            const SizedBox(height: 16),
            SizedBox(
                width: double.infinity,
                height: 56,
                child: Obx(() => ElevatedButton(
                    onPressed: () {
                      kirimC.isLoading.value
                          ? null
                          : status == "Ditolak"
                              ? kirimC.updateTransaksi(
                                  request['id'].toString(),
                                  request['email'].toString(),
                                  request['tgl'].toString(),
                                  double.parse(jmlhOrganik.text.trim()),
                                  double.parse(jmlhAnorganik.text.trim()),
                                  status!.trim(),
                                  kirimC.keteranganC.text.trim(),
                                  0)
                              : value == 0
                                  ? kirimC.updateTransaksi(
                                      request['id'].toString(),
                                      request['email'].toString(),
                                      request['tgl'].toString(),
                                      double.parse(
                                          kirimC.jumlahOrganikC.text.trim()),
                                      double.parse(
                                          kirimC.jumlahAnorganikC.text.trim()),
                                      status!.trim(),
                                      ket.text.trim(),
                                      0)
                                  : kirimC.updateTransaksi(
                                      request['id'].toString(),
                                      request['email'].toString(),
                                      request['tgl'].toString(),
                                      double.parse(
                                          kirimC.jumlahOrganikC.text.trim()),
                                      double.parse(
                                          kirimC.jumlahAnorganikC.text.trim()),
                                      status!.trim(),
                                      ket.text.trim(),
                                      value);
                    },
                    style: btnStylePrimary,
                    child: status == "Ditolak"
                        ? kirimC.isLoading.value
                            ? const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(
                                      color: colorBackground),
                                  SizedBox(width: 16),
                                  Text("Sedang memuat...",
                                      style: appFontButton),
                                ],
                              )
                            : const Text("Konfirmasi Pembatalan",
                                style: appFontButton)
                        : kirimC.isLoading.value
                            ? const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(
                                      color: colorBackground),
                                  SizedBox(width: 16),
                                  Text("Sedang memuat...",
                                      style: appFontButton),
                                ],
                              )
                            : const Text("Konfirmasi Pengambilan",
                                style: appFontButton)))),
          ],
        ),
      ))),
    );
  }
}
