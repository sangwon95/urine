
import 'package:flutter/material.dart';

class AppConstants {
  static double elevation = 2.0;
  static double textFieldHeight = 55;

  static const double boxItemHeight60 = 60;
  static const double signupTextFieldHeight = 50;
  static const double buttonHeight = 55;
  static const double dropButtonHeight = 45;

  static double borderLightWidth = 1.5;
  static double borderMediumWidth = 2;
  static double borderBordWidth = 3;

  static BorderRadiusGeometry borderRadius = BorderRadius.circular(30);
  static BorderRadiusGeometry borderMediumRadius = BorderRadius.circular(20);
  static BorderRadiusGeometry borderLightRadius = BorderRadius.circular(12);

  static Radius radius = const Radius.circular(30);
  static Radius mediumRadius = const Radius.circular(20);
  static Radius lightRadius = const Radius.circular(12);

  static const double radiusValue30 = 30;
  static const double radiusValue20 = 20;
  static const double radiusValue10 = 10;

  static EdgeInsets viewPadding = const EdgeInsets.all(5.0);

  static List<String> get urineNameList => [
    '잠혈',
    '빌리루빈',
    '우로빌리노겐',
    '케톤체',
    '단백질',
    '아질산염',
    '포도당',
    '산성도',
    '비중',
    '백혈구',
    '비타민',
  ];

  static LinearGradient gradient = const LinearGradient(
    begin: FractionalOffset.topLeft,
    end: FractionalOffset.bottomRight,
    colors: [
      Color(0xff4182db),
      Color(0xff98dad1),
    ],
    stops: [0.01, 1.0],
  );
}