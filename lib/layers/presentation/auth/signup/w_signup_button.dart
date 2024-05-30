import 'package:flutter/material.dart';
import 'package:urine/common/common.dart';
import 'package:urine/layers/presentation/widget/style_text.dart';

class SignUpButton extends StatelessWidget {

  final VoidCallback onPressed;

  const SignUpButton({
    super.key,
    required this.onPressed,
  });

  String get btnText => '회원가입';

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        minimumSize: const Size(double.infinity, AppConstants.buttonHeight),
        shape: RoundedRectangleBorder(
            borderRadius: AppConstants.borderLightRadius,
        ),
      ),
      child: StyleText(
        text: btnText,
        color: AppColors.whiteTextColor,
        size: AppDim.fontSizeMedium,
        fontWeight: AppDim.weightBold,
      ),
    );
  }
}
