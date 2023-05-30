// ignore_for_file: avoid_print
import 'dart:io';
import 'package:aplikasi_sampah/app/constant/color.dart';
import 'package:aplikasi_sampah/app/constant/fontStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../constant/style.dart';
import 'auth_controller.dart';
import 'signup/daftar_controller.dart';

class DaftarScreen extends StatefulWidget {
  const DaftarScreen({Key? key}) : super(key: key);
  @override
  State<DaftarScreen> createState() => _DaftarScreenState();
}

class _DaftarScreenState extends State<DaftarScreen> {
  final AuthController daftarC = Get.put(AuthController());
  final c = Get.put(DaftarController());
  bool showProgres = false;

  //Show & Hide Password
  bool _isHidePassword = true;
  void _togglePasswordVisibility() {
    setState(() {
      _isHidePassword = !_isHidePassword;
    });
  }

  //Show & Hide Confirm Password
  bool _isHideConfirmPass = true;
  void _toggleConfirmPassVisibility() {
    setState(() {
      _isHideConfirmPass = !_isHideConfirmPass;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorBackground,
        body: SafeArea(
            child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 24, horizontal: 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Text("Signup", style: appFontTitle),
                          ),
                          const Center(
                            child: Text("Halaman pendaftaran akun warga",
                                style: appFontHeding3),
                          ),
                          const SizedBox(height: 24),
                          //Form Daftar
                          Container(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Column(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: colorPrimary,
                                            backgroundImage: daftarC
                                                        .imageProfil ==
                                                    null
                                                ? const AssetImage(
                                                    "assets/images/Profile.png")
                                                : FileImage(File(daftarC
                                                    .imageProfil!
                                                    .path)) as ImageProvider,
                                            radius: 80,
                                          ),
                                          const SizedBox(height: 8),
                                          InkWell(
                                              onTap: () {
                                                showModalBottomSheet(
                                                  context: context,
                                                  builder: (context) =>
                                                      bottomSheet(context),
                                                );
                                              },
                                              child: const Text(
                                                "Tambah foto profil",
                                                style: appFontButtonText,
                                              ))
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                    Container(
                                      width: double.infinity,
                                      height: 56,
                                      decoration: boxDecorationInputSmallAccent,
                                      padding: const EdgeInsets.only(
                                          left: 16,
                                          top: 8,
                                          bottom: 8,
                                          right: 16),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Daftar sebagai",
                                            style: appFontFormInput,
                                          ),
                                          const SizedBox(width: 16),
                                          DropdownButton<String>(
                                            dropdownColor: colorSecondary,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            iconSize: 30,
                                            underline: Container(
                                                height: 0,
                                                color: Colors.transparent),
                                            icon: const Icon(
                                                Icons.arrow_drop_down_rounded),
                                            iconEnabledColor: colorPrimary,
                                            style: appFontFormInput,
                                            alignment: Alignment.center,
                                            value: daftarC.currentItemSelected,
                                            items: daftarC.option.map(
                                                (String dropDownStringItem) {
                                              return DropdownMenuItem<String>(
                                                value: dropDownStringItem,
                                                child: Text(dropDownStringItem),
                                              );
                                            }).toList(),
                                            onChanged: (newValueSelected) {
                                              setState(() {
                                                daftarC.currentItemSelected =
                                                    newValueSelected!;
                                                daftarC.rool = newValueSelected;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                    TextFormField(
                                      controller: c.emailsignupC,
                                      keyboardType: TextInputType.emailAddress,
                                      style: appFontFormInput,
                                      cursorColor: colorPrimary,
                                      cursorHeight: 25,
                                      decoration: const InputDecoration(
                                          filled: true,
                                          enabled: true,
                                          fillColor: colorSecondary,
                                          label: Text("Email"),
                                          labelStyle: appFontFormInput,
                                          floatingLabelStyle: appFontFormInput,
                                          focusColor: colorSecondary,
                                          enabledBorder: enableInputBorder,
                                          focusedBorder: focusInputBorder),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Email tidak boleh kosong";
                                        }
                                        if (!RegExp(
                                                "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                            .hasMatch(value)) {
                                          return ("Tolong masukkan email dengan benar");
                                        } else {
                                          return null;
                                        }
                                      },
                                      onChanged: (value) {},
                                    ),
                                    const SizedBox(height: 24),
                                    TextFormField(
                                      controller: c.namasignupC,
                                      style: appFontFormInput,
                                      cursorColor: colorPrimary,
                                      cursorHeight: 25,
                                      decoration: const InputDecoration(
                                          filled: true,
                                          fillColor: colorSecondary,
                                          label: Text("Nama Lengkap"),
                                          labelStyle: appFontFormInput,
                                          floatingLabelStyle: appFontFormInput,
                                          focusColor: colorSecondary,
                                          enabledBorder: enableInputBorder,
                                          focusedBorder: focusInputBorder),
                                      onChanged: (value) {},
                                    ),
                                    const SizedBox(height: 24),
                                    TextFormField(
                                      controller: c.rtsignupC,
                                      style: appFontFormInput,
                                      cursorColor: colorPrimary,
                                      cursorHeight: 25,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                          filled: true,
                                          fillColor: colorSecondary,
                                          label: Text("RT"),
                                          labelStyle: appFontFormInput,
                                          floatingLabelStyle: appFontFormInput,
                                          focusColor: colorSecondary,
                                          enabledBorder: enableInputBorder,
                                          focusedBorder: focusInputBorder),
                                      onChanged: (value) {},
                                    ),
                                    const SizedBox(height: 24),
                                    //No. KK
                                    TextFormField(
                                      controller: c.rwsignupC,
                                      style: appFontFormInput,
                                      cursorColor: colorPrimary,
                                      cursorHeight: 25,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                          filled: true,
                                          fillColor: colorSecondary,
                                          label: Text("RW"),
                                          labelStyle: appFontFormInput,
                                          floatingLabelStyle: appFontFormInput,
                                          focusColor: colorSecondary,
                                          enabledBorder: enableInputBorder,
                                          focusedBorder: focusInputBorder),
                                      onChanged: (value) {},
                                    ),
                                    const SizedBox(height: 24),
                                    //No. WA
                                    TextFormField(
                                      controller: c.wasignupC,
                                      style: appFontFormInput,
                                      cursorColor: colorPrimary,
                                      cursorHeight: 25,
                                      keyboardType: TextInputType.phone,
                                      decoration: const InputDecoration(
                                          filled: true,
                                          fillColor: colorSecondary,
                                          label: Text("No. WhatsApp"),
                                          labelStyle: appFontFormInput,
                                          floatingLabelStyle: appFontFormInput,
                                          focusColor: colorSecondary,
                                          enabledBorder: enableInputBorder,
                                          focusedBorder: focusInputBorder),
                                      onChanged: (value) {},
                                    ),
                                    const SizedBox(height: 24),
                                    //password
                                    TextFormField(
                                      controller: c.passwordsignupC,
                                      obscureText: _isHidePassword,
                                      keyboardType: TextInputType.text,
                                      style: appFontFormInput,
                                      cursorColor: colorPrimary,
                                      cursorHeight: 25,
                                      decoration: InputDecoration(
                                          filled: true,
                                          enabled: true,
                                          fillColor: colorSecondary,
                                          suffixIcon: GestureDetector(
                                            onTap: () {
                                              _togglePasswordVisibility();
                                            },
                                            child: Icon(
                                              _isHidePassword
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                              color: colorPrimary,
                                            ),
                                          ),
                                          label: const Text("Password"),
                                          labelStyle: appFontFormInput,
                                          floatingLabelStyle: appFontFormInput,
                                          focusColor: colorSecondary,
                                          enabledBorder: enableInputBorder,
                                          focusedBorder: focusInputBorder),
                                      validator: (value) {
                                        RegExp regex = RegExp(r'^.{6,}$');
                                        if (value!.isEmpty) {
                                          return "Password tidak boleh kosong";
                                        }
                                        if (!regex.hasMatch(value)) {
                                          return ("Masukkan password dengan benar min. 6 karakter");
                                        } else {
                                          return null;
                                        }
                                      },
                                      onChanged: (value) {},
                                    ),
                                    const SizedBox(height: 24),
                                    //confirm password
                                    TextFormField(
                                      controller: c.confirmpasswordsignupC,
                                      obscureText: _isHideConfirmPass,
                                      keyboardType: TextInputType.text,
                                      style: appFontFormInput,
                                      cursorColor: colorPrimary,
                                      cursorHeight: 25,
                                      decoration: InputDecoration(
                                          filled: true,
                                          enabled: true,
                                          fillColor: colorSecondary,
                                          suffixIcon: GestureDetector(
                                            onTap: () {
                                              _toggleConfirmPassVisibility();
                                            },
                                            child: Icon(
                                              _isHideConfirmPass
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                              color: colorPrimary,
                                            ),
                                          ),
                                          label: const Text("Confirm Password"),
                                          labelStyle: appFontFormInput,
                                          floatingLabelStyle: appFontFormInput,
                                          focusColor: colorSecondary,
                                          enabledBorder: enableInputBorder,
                                          focusedBorder: focusInputBorder),
                                      validator: (value) {
                                        if (c.confirmpasswordsignupC.text !=
                                            c.passwordsignupC.text) {
                                          return "Password tidak sama";
                                        } else {
                                          return null;
                                        }
                                      },
                                      onChanged: (value) {},
                                    )
                                  ])),
                          const SizedBox(height: 32),
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                                onPressed: () {
                                  AuthController.instance
                                      .daftar(
                                          daftarC.rool.trim(),
                                          c.emailsignupC.text.trim(),
                                          c.namasignupC.text.trim(),
                                          c.rtsignupC.text.trim(),
                                          c.rwsignupC.text.trim(),
                                          c.wasignupC.text.trim(),
                                          c.passwordsignupC.text.trim(),
                                          c.confirmpasswordsignupC.text.trim())
                                      .whenComplete(() {
                                    c.emailsignupC.clear();
                                    c.namasignupC.clear();
                                    c.rtsignupC.clear();
                                    c.rwsignupC.clear();
                                    c.wasignupC.clear();
                                    c.passwordsignupC.clear();
                                    c.confirmpasswordsignupC.clear();
                                  });
                                },
                                style: btnStylePrimary,
                                child: const Text(
                                  "Daftar",
                                  style: appFontButton,
                                )),
                          ),
                          const SizedBox(height: 16),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Sudah punya akun? ",
                                  style: appFontNormal,
                                ),
                                InkWell(
                                  onTap: () {
                                    daftarC.toLogin();
                                  },
                                  child: const Text(
                                    "Masuk",
                                    style: appFontButtonText,
                                  ),
                                )
                              ])
                        ])))));
  }

  Widget bottomSheet(BuildContext context) {
    final picker = ImagePicker();
    //Kamera//
    Future kamera() async {
      try {
        final XFile? pick = await picker.pickImage(source: ImageSource.camera);
        setState(() {
          daftarC.imageProfil = File(pick!.path);
        });
      } catch (e) {
        print(e);
      }
    }

    //Gallery//
    Future gallery() async {
      try {
        final XFile? pick = await picker.pickImage(source: ImageSource.gallery);
        setState(() {
          daftarC.imageProfil = File(pick!.path);
        });
      } catch (e) {
        print(e);
      }
    }

    Size size = MediaQuery.of(context).size;
    return Container(
        width: double.infinity,
        height: size.height * 0.17,
        margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(children: [
          const Text("Pilih foto profil", style: appFontHeding2),
          const SizedBox(height: 24),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            InkWell(
                child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.image_search_rounded, color: colorPrimary),
                      SizedBox(height: 16),
                      Text("Gallery", style: appFontFormInput)
                    ]),
                onTap: () {
                  gallery();
                }),
            const SizedBox(width: 120),
            InkWell(
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera_alt_rounded, color: colorPrimary),
                    SizedBox(height: 16),
                    Text("Kamera", style: appFontFormInput)
                  ],
                ),
                onTap: () {
                  kamera();
                })
          ])
        ]));
  }
}
