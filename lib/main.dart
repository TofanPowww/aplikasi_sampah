// ignore_for_file: avoid_print

import 'package:aplikasi_sampah/app/screens/auth/auth_controller.dart';
import 'package:aplikasi_sampah/routes/links.dart';
import 'package:aplikasi_sampah/utils/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:aplikasi_sampah/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(const Duration(seconds: 1));
  FlutterNativeSplash.remove();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.getInitialMessage();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final authC = Get.put(AuthController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: authC.streamAuthStatus,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute:
                snapshot.data != null ? AppLinks.HOME : AppLinks.LOGIN,
            getPages: AppRoutes.pages,
          );
        }
        return const LoadingView();
      },
    );
  }
}
