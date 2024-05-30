import 'package:flutter/material.dart';

/// Container의 통일성을 위한 Widget
class CommonContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Color? color;
  final BoxBorder? border;
  BorderRadiusGeometry? borderRadius = BorderRadius.circular(12);
  final List<BoxShadow>? boxShadow;
  final Widget? child;

  var circular = 20;
   CommonContainer({
    super.key,
    this.height,
    this.width,
    this.margin,
    this.padding,
    this.color,
    this.border,
    this.boxShadow,
    this.borderRadius,
    this.child,

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        border: border,
        borderRadius: borderRadius
      ),
      child: child,
    );
  }
}
