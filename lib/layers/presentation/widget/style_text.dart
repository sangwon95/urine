
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:urine/common/common.dart';
import 'package:urine/common/constant/app_dimensions.dart';

class StyleText extends StatelessWidget {
  final String text;
  final double size;
  final double height;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign align;
  final TextOverflow overflow;
  final int maxLinesCount;
  final bool softWrap;
  final TextDecoration? decoration;
  final Color? decorationColor;
  final double? decorationThickness;

  const StyleText({
    super.key,
    required this.text,
    this.size = AppDim.fontSizeMedium,
    this.height = 1.0,
    this.color = AppColors.veryDarkGrey,
    this.fontWeight = FontWeight.normal,
    this.align = TextAlign.start,
    this.overflow = TextOverflow.visible,
    this.maxLinesCount = 1,
    this.softWrap = false,
    this.decoration,
    this.decorationColor,
    this.decorationThickness,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textScaleFactor: AppDim.scaleFontSize,
      overflow: overflow,
      maxLines: maxLinesCount,
      softWrap: softWrap,
      style: TextStyle(
          height: height,
          color: color,
          fontSize: size,
          fontWeight: fontWeight,
          decoration: decoration,
          decorationColor: decorationColor,
          decorationThickness: decorationThickness,
          fontFamily: 'pretendard'
      ),
      textAlign: align,
    );
  }
}
