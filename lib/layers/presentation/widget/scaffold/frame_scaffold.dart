import 'package:flutter/material.dart';
import 'package:urine/common/common.dart';
import 'package:urine/layers/presentation/widget/style_text.dart';

import '../../../../common/util/app_keyboard_util.dart';
import '../custom_app_bar.dart';

class FrameScaffold extends StatelessWidget {
  final String? appBarTitle;
  final Widget body;
  final Widget? bottomNavigationBar;
  final Gradient? gradient;
  final Color? backgroundColor;
  final bool isKeyboardHide;
  final bool isActions;

  const FrameScaffold({
    super.key,
    this.appBarTitle,
    this.backgroundColor = AppColors.white,
    this.isKeyboardHide = false,
    required this.body,
    this.bottomNavigationBar,
    this.isActions = false,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {if (isKeyboardHide) AppKeyboardUtil.hide(context)},
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0.0,
          title: StyleText(
            text: appBarTitle!,
            size: AppDim.fontSizeLarge,
            color: AppColors.primaryColor,
            fontWeight: AppDim.weightBold,
          ),
          iconTheme: const IconThemeData(color: AppColors.darkGrey),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: AppDim.medium),
          decoration: BoxDecoration(
            gradient: gradient,
          ),
          child: body,
        ),
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }
}
