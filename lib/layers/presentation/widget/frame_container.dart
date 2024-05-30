
import 'package:flutter/material.dart';
import 'package:urine/common/common.dart';

class FrameContainer extends StatelessWidget {
  final double? height;
  final Color backgroundColor;
  final Color borderColor;
  final EdgeInsets? margin;
  final Widget child;

  const FrameContainer({
    super.key,
    this.height,
    required this.backgroundColor,
    this.margin = const EdgeInsets.all(0.0),
    this.borderColor =  AppColors.transparent,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: AppDim.paddingLarge,
      margin: margin,
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.all(AppConstants.mediumRadius),
          border: Border.all(
              width: AppConstants.borderLightWidth, color: borderColor,
          ),
        boxShadow: const [
          BoxShadow(
              color: AppColors.middleGrey, //New
              blurRadius: 1.0,
              offset: Offset(0, 1))
        ],
      ),
      child: child,
    );
  }
}