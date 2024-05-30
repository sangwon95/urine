import 'package:flutter/material.dart';
import 'package:urine/common/common.dart';

import '../../../common/util/scale_font_size.dart';

class RoundTextField extends StatelessWidget {

  final TextEditingController controller;
  final IconData prefixIcon;
  final TextInputType? keyboardType;
  final Color textColor;
  final String? hintText;
  final bool isFocused;
  final FocusNode focusNode;
  final bool obscureText;

  const RoundTextField({
    super.key,
    required this.controller,
    required this.prefixIcon,
    required this.focusNode,
    this.keyboardType = TextInputType.text,
    this.textColor = Colors.black,
    this.hintText,
    this.isFocused = false,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    final themeColor = context.theme.colorScheme;
    return MediaQuery(
      data: getScaleFontSize(context, fontSize: AppDim.scaleFontSize),
      child: Container(
        height: AppConstants.buttonHeight,
        margin: AppDim.marginXSmall,
        padding: AppDim.paddingXSmall,
        decoration: BoxDecoration(
            color: themeColor.background,
            border: Border.all(width: AppConstants.borderLightWidth, color: themeColor.outline),
            borderRadius: AppConstants.borderRadius,
            boxShadow: [
              if (isFocused)
                BoxShadow(
                    color: AppColors.primaryColor.withOpacity(.2),
                    blurRadius: 1.0,
                    spreadRadius: 2.0
                )
            ],
        ),
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          style: TextStyle(
              fontSize: AppDim.fontSizeSmall,
              fontWeight: AppDim.weightBold,
              color: themeColor.surface,
          ),
          decoration: quarterInputDecoration(context),
          focusNode: focusNode,
        ),
      ),
    );
  }

  quarterInputDecoration(BuildContext context) {
    final themeColor = context.theme.colorScheme;

    if (obscureText) {
      return InputDecoration(
          prefixIcon: Icon(
            prefixIcon,
            color: themeColor.surface,
          ),
          suffixIcon: const Icon(
            Icons.visibility_off_outlined,
          ),
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(
            color: themeColor.onSurface,
          ));
    } else {
      return InputDecoration(
        prefixIcon: Icon(
          prefixIcon,
          color: themeColor.surface,
        ),
        border: InputBorder.none,
        hintText: hintText,
        hintStyle: TextStyle(
          color: themeColor.onSurface,
        ),
      );
    }
  }
}
