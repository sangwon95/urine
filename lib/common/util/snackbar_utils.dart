import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../layers/presentation/widget/style_text.dart';
import '../common.dart';

class SnackBarUtils {

  /// 일반 스낵바
  static showDefaultSnackBar(
      BuildContext context,
      String message,
      {int seconds = 2}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: seconds),
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.white,
      content: StyleText(
        text: message,
        size: AppDim.fontSizeSmall,
        color: AppColors.blackTextColor,
      ),
    ));
  }

  /// 센터 스낵바
  static showCenterSnackBar(
      BuildContext context,
      String message,
      {int seconds = 3}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: seconds),
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.primaryColor,
      action: SnackBarAction(
        label: 'X',
        textColor: AppColors.whiteTextColor,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 225.0),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
              Icons.arrow_circle_left_outlined,
              color: AppColors.whiteTextColor,
              size: AppDim.iconMedium,
          ),
          const Gap(AppDim.small),
          StyleText(
            text: message,
            size: AppDim.fontSizeXLarge,
            color: AppColors.whiteTextColor,
            fontWeight: AppDim.weightBold,
          ),
          const Gap(AppDim.small),
          Icon(
            Icons.arrow_circle_right_outlined,
            color: AppColors.whiteTextColor,
            size: AppDim.iconMedium,),
        ],
      ),
    ));
  }

  /// BG White 스낵바
  static showPrimarySnackBar(
      BuildContext context,
      String message,
      {int seconds = 2}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: seconds.seconds,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      content: Container(
        padding: const EdgeInsets.all(8.0),
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: AppConstants.borderLightRadius,
          boxShadow: [
            BoxShadow(
              color:  Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(1, 1), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(Icons.check_circle, size: AppDim.iconSmall, color: AppColors.white),
            const Gap(AppDim.mediumLarge),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StyleText(
                    text: message,
                    fontWeight: AppDim.weight500,
                      color: AppColors.white
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}