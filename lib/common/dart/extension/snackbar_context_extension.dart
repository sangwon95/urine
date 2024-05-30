import 'package:flutter/material.dart';

import '../../../layers/presentation/widget/w_tap.dart';
import '../../common.dart';

extension SnackbarContextExtension on BuildContext {

  ///Scaffold안에 Snackbar를 보여줍니다.
  void showSnackbar(String message, {bool isWhiteBg = false}) {
    _showSnackBarWithContext(
      this,
      _SnackbarFactory.createSnackBar(this, message, isWhiteBg: isWhiteBg),
    );
  }

  ///Scaffold안에 빨간 Snackbar를 보여줍니다.
  void showErrorSnackbar(
    String message, {
    Color bgColor = AppColors.salmon,
    double bottomMargin = 0,
  }) {
    _showSnackBarWithContext(
      this,
      _SnackbarFactory.createErrorSnackBar(
        this,
        message,
        bgColor: bgColor,
        bottomMargin: bottomMargin,
      ),
    );
  }
}

void _showSnackBarWithContext(BuildContext context, SnackBar snackbar) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}

class _SnackbarFactory {
  static SnackBar createSnackBar(BuildContext context, String message,
      {Color? bgColor, bool isWhiteBg = false}) {
    Color snackbarBgColor = bgColor ?? context.appColors.snackbarBgColor;
    return SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.fixed,
        backgroundColor: Colors.transparent,
        content: Tap(
          onTap: () {
            try {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            } catch (e) {
              //do nothing
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: isWhiteBg
                  ? AppColors.white
                  :AppColors.primaryColor,
              borderRadius: AppConstants.borderRadius,
            ),
            padding: AppDim.marginMedium,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                      message,
                      style:  TextStyle(
                        color: isWhiteBg
                            ? AppColors.primaryColor
                            :AppColors.white,
                        fontSize: AppDim.fontSizeSmall,
                        fontWeight: AppDim.weightNormal,
                      )),
                ),
              ],
            ),
          ),
        ));
  }

  static SnackBar createErrorSnackBar(BuildContext context, String? message,
      {Color bgColor = AppColors.salmon, double bottomMargin = 0}) {
    return SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.fixed,
        backgroundColor: Colors.transparent,
        content: Tap(
          onTap: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
          child: Container(
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(5),
            ),
            padding: const EdgeInsets.all(20),
            margin: EdgeInsets.only(bottom: bottomMargin),
            child: Text("$message",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontStyle: FontStyle.normal,
                )),
          ),
        ));
  }
}
