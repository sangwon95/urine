import 'package:flutter/material.dart';
import 'package:urine/common/common.dart';
import 'package:urine/common/constant/app_colors.dart';
import 'package:urine/common/constant/app_dimensions.dart';
import 'package:urine/layers/presentation/auth/signup/v_signup.dart';
import 'package:urine/layers/presentation/widget/style_text.dart';

class SignUpGuideButton extends StatelessWidget {
  const SignUpGuideButton({super.key});

  String get signupQuestionText => '아직 회원이 아니신가요?';

  String get signupText => '회원가입';

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        StyleText(
          text: signupQuestionText,
          color: AppColors.greyTextColor,
          size: AppDim.fontSizeMedium,
        ),
        TextButton(
          onPressed: () => Nav.doPush(context, const SignupView()),
          child: StyleText(
              text: signupText,
              color: AppColors.greyTextColor,
              size: AppDim.fontSizeMedium,
              fontWeight: AppDim.weightBold,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.greyTextColor,
              decorationThickness: 0.8),
        )
      ],
    );
  }
}
