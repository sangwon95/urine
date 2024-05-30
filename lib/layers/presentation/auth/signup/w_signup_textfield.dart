
import 'package:flutter/material.dart';
import 'package:urine/common/constant/app_colors.dart';
import 'package:urine/common/constant/app_dimensions.dart';
import 'package:urine/common/util/scale_font_size.dart';
import 'package:urine/layers/presentation/auth/signup/v_signup.dart';

import '../../../../common/constant/app_constants.dart';
import '../../../model/enum/signup_type.dart';

class SignupTextField extends StatelessWidget {

  final dynamic type;
  final TextEditingController controller;

  const SignupTextField({
    super.key,
    required this.type,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: AppConstants.signupTextFieldHeight,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: AppColors.signupTextFieldBg,
          borderRadius: BorderRadius.all(AppConstants.mediumRadius),
        ),
        child: MediaQuery(
          data: getScaleFontSize(context, fontSize: 0.85),
            child: TextField(
              autofocus: false,
              obscureText: (type == SignupType.pass || type == SignupType.pass2),
              controller: controller,
              keyboardType: TextInputType.text,
              style: const TextStyle(
                  color: Colors.black, decorationThickness: 0),
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: const EdgeInsets.only(left: AppDim.large),
                hintText: type.hint,
                hintStyle: const TextStyle(
                  color: AppColors.grey,
                  fontWeight: AppDim.weight500,
                ),
              ),
            ),
          ),
        );
  }
}
