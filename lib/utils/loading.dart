import 'package:aplikasi_sampah/app/constant/color.dart';
import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: colorPrimary),
        ),
      ),
    );
  }
}
