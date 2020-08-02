import 'package:flutter/material.dart';

const double kDefaultMargin = 20;
const double kDefaultBorderRadius = 20;

const Color kAccentColorLight = Color(0xFFFEE891);

final List<BoxShadow> kPrimaryBoxShadow = [
  BoxShadow(
      offset: Offset(0, 10),
      color: Color(0xFFD3D3D3).withOpacity(.84),
      blurRadius: 33)
];

final List<BoxShadow> kSecondaryBoxShadow = [
  BoxShadow(
      offset: Offset(3, 7),
      color: Color(0xFF3D3D3D).withOpacity(.5),
      blurRadius: 20)
];
