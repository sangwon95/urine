

import 'package:flutter/material.dart';
import 'package:urine/common/common.dart';
import 'package:urine/layers/presentation/widget/style_text.dart';

class DefaultButton extends StatelessWidget {
  final String btnName;
  final Function() onPressed;
  final double buttonHeight;

   const DefaultButton({
    super.key,
    required this.btnName,
    required this.onPressed,
    this.buttonHeight = AppConstants.buttonHeight,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        minimumSize: Size(double.infinity, buttonHeight),
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(AppConstants.lightRadius)
        ),
      ),
      child: StyleText(
        text: btnName,
        color: AppColors.whiteTextColor,
        fontWeight: AppDim.weightBold,
      ),
    );
  }
}
