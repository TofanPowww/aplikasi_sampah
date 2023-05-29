import 'package:aplikasi_sampah/app/constant/color.dart';
import 'package:aplikasi_sampah/app/constant/fontStyle.dart';
import 'package:aplikasi_sampah/app/constant/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'reset_password_controller.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});
  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  bool _isHidePasswordLama = true;
  bool _isHidePasswordBaru = true;
  bool _isHidePasswordKonfir = true;

  void _togglePasswordLamaVisibility() {
    setState(() {
      _isHidePasswordLama = !_isHidePasswordLama;
    });
  }

  void _togglePasswordBaruVisibility() {
    setState(() {
      _isHidePasswordBaru = !_isHidePasswordBaru;
    });
  }

  void _togglePasswordKonfirVisibility() {
    setState(() {
      _isHidePasswordKonfir = !_isHidePasswordKonfir;
    });
  }

  final ResetPasswordController resetC = Get.put(ResetPasswordController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      appBar: AppBar(
        title: const Text("Reset Password", style: appFontTitlePage),
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
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Form(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          //Password Lama//
                          const Text("Password Lama", style: appFontHeding3a),
                          const SizedBox(height: 8),
                          TextFormField(
                            obscureText: _isHidePasswordLama,
                            autofocus: false,
                            autocorrect: false,
                            controller: resetC.passLamaC,
                            keyboardType: TextInputType.text,
                            style: appFontLabelForm,
                            cursorColor: colorPrimary,
                            cursorHeight: 25,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: colorSecondary,
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    _togglePasswordLamaVisibility();
                                  },
                                  child: Icon(
                                      _isHidePasswordLama
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: colorPrimary),
                                ),
                                enabledBorder: enableInputBorder,
                                focusedBorder: focusInputBorder),
                          ),
                          //End Password Lama//
                          const SizedBox(height: 16),
                          //Password Baru//
                          const Text("Password Baru", style: appFontHeding3a),
                          const SizedBox(height: 8),
                          TextFormField(
                            obscureText: _isHidePasswordBaru,
                            autofocus: false,
                            autocorrect: false,
                            controller: resetC.passBaruC,
                            keyboardType: TextInputType.text,
                            style: appFontLabelForm,
                            cursorColor: colorPrimary,
                            cursorHeight: 25,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: colorSecondary,
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    _togglePasswordBaruVisibility();
                                  },
                                  child: Icon(
                                      _isHidePasswordBaru
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: colorPrimary),
                                ),
                                enabledBorder: enableInputBorder,
                                focusedBorder: focusInputBorder),
                          ),
                          //Password Baru//
                          const SizedBox(height: 16),
                          //Konfirmasi Password//
                          const Text("Konfirmasi Password",
                              style: appFontHeding3a),
                          const SizedBox(height: 8),
                          TextFormField(
                            obscureText: _isHidePasswordKonfir,
                            controller: resetC.passKonfirC,
                            autocorrect: false,
                            autofocus: false,
                            keyboardType: TextInputType.text,
                            style: appFontLabelForm,
                            cursorColor: colorPrimary,
                            cursorHeight: 25,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: colorSecondary,
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    _togglePasswordKonfirVisibility();
                                  },
                                  child: Icon(
                                      _isHidePasswordKonfir
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: colorPrimary),
                                ),
                                enabledBorder: enableInputBorder,
                                focusedBorder: focusInputBorder),
                          ),
                          //End Konfirmasi Password//
                          const SizedBox(height: 32),
                          //Submit Button//
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                                onPressed: () {
                                  resetC.resetPass(
                                      resetC.passLamaC.text.trim(),
                                      resetC.passBaruC.text.trim(),
                                      resetC.passKonfirC.text.trim());
                                },
                                style: btnStylePrimary,
                                child:
                                    const Text("Simpan", style: appFontButton)),
                          ),
                          //End Submit Button//
                        ]))
                  ]))),
    );
  }
}
