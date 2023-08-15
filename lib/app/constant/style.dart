import 'package:aplikasi_sampah/app/constant/color.dart';
import 'package:flutter/material.dart';

const enableInputBorder = OutlineInputBorder(
    borderSide: BorderSide(
      width: 1.5,
      color: colorPrimary,
      style: BorderStyle.solid,
    ),
    borderRadius: BorderRadius.all(Radius.circular(10)));

const focusInputBorder = OutlineInputBorder(
    borderSide: BorderSide(
      width: 1.5,
      color: colorPrimary,
      style: BorderStyle.solid,
    ),
    borderRadius: BorderRadius.all(Radius.circular(10)));

const errorInputBorder = OutlineInputBorder(
    borderSide: BorderSide(
      width: 1.5,
      color: appDanger,
      style: BorderStyle.solid,
    ),
    borderRadius: BorderRadius.all(Radius.circular(10)));

final btnStylePrimary = ButtonStyle(
    elevation: const MaterialStatePropertyAll(5),
    backgroundColor: const MaterialStatePropertyAll(colorPrimary),
    shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))));

final btnStyleAccent = ButtonStyle(
    elevation: const MaterialStatePropertyAll(5),
    backgroundColor: const MaterialStatePropertyAll(colorAccent),
    shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))));

final btnStyleOutline = ButtonStyle(
    backgroundColor: const MaterialStatePropertyAll(colorBackground),
    side: const MaterialStatePropertyAll(
        BorderSide(width: 1.5, color: colorPrimary)),
    shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))));

final boxDecoration = BoxDecoration(
  boxShadow: [
    BoxShadow(
        color: colorPrimary.withOpacity(0.2),
        offset: const Offset(0, 1),
        blurRadius: 4,
        spreadRadius: 1)
  ],
  color: colorSecondary,
  border: Border.all(
    color: colorPrimary,
    width: 1.5,
    style: BorderStyle.solid,
  ),
  borderRadius: const BorderRadius.all(Radius.circular(15)),
);

final boxDecorationInput = BoxDecoration(
  color: colorSecondary,
  border: Border.all(
    color: colorPrimary,
    width: 1.5,
    style: BorderStyle.solid,
  ),
  borderRadius: const BorderRadius.all(Radius.circular(15)),
);
final boxDecorationInputActive = BoxDecoration(
  color: colorAccent,
  border: Border.all(
    color: colorPrimary,
    width: 1.5,
    style: BorderStyle.solid,
  ),
  borderRadius: const BorderRadius.all(Radius.circular(15)),
);

final boxDecorationInputSmall = BoxDecoration(
  color: colorSecondary,
  border: Border.all(
    color: colorPrimary,
    width: 1.5,
    style: BorderStyle.solid,
  ),
  borderRadius: const BorderRadius.all(Radius.circular(10)),
);

final boxDecorationInputSmallAccent = BoxDecoration(
  color: colorAccent,
  border: Border.all(
    color: colorPrimary,
    width: 1.5,
    style: BorderStyle.solid,
  ),
  borderRadius: const BorderRadius.all(Radius.circular(10)),
);

final boxDecorationDanger = BoxDecoration(
  color: colorBackground2,
  border: Border.all(
    color: appDanger,
    width: 1.5,
    style: BorderStyle.solid,
  ),
  borderRadius: const BorderRadius.all(Radius.circular(10)),
);

final boxShadow = BoxShadow(
    color: colorPrimary.withOpacity(0.4),
    offset: const Offset(0, 2),
    blurRadius: 3,
    spreadRadius: 1);
