import 'dart:ffi';

import 'package:urine/common/common.dart';
import 'package:flutter/material.dart';

class RoundedContainer extends StatelessWidget {

  final double height;
  final Widget child;
  final EdgeInsets padding;
  final double radius;
  final Color? backgroundColor;

  const RoundedContainer({
    super.key,
    required this.height,
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    this.radius = 20,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: padding,
      decoration: BoxDecoration(
          color: backgroundColor ?? context.appColors.buttonLayoutBackground,
          borderRadius: BorderRadius.circular(radius)),
      child: child,
    );
  }
}
