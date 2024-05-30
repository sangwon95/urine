import 'package:flutter/material.dart';
import 'package:urine/common/dart/extension/context_extension.dart';

class Line extends StatelessWidget {
  const Line({
    Key? key,
    this.color,
    this.width = 1,
    this.margin,
  }) : super(key: key);

  final Color? color;
  final EdgeInsets? margin;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: 1,
      color: color ?? context.appColors.divider,
      width: width,
    );
  }
}
