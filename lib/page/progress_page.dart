// this class defines the full-screen semi-transparent modal dialog
// by extending the ModalRoute class
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../utils/color.dart';
import '../utils/constants.dart';
import '../utils/frame.dart';

/// Screen displayed during ChatBot [action]
class ProgressPage extends ModalRoute {
  final InspectionType inspectionType;
  ProgressPage(this.inspectionType);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.88);

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation,) {
    return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {
        return Material(
          type: MaterialType.transparency,
          child: Padding(
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 30),
                    child: InspectionType.basic  == inspectionType ? SpinKitCircle(
                      color: mainColor,
                      size: 70,
                    ):
                    SpinKitFadingFour(
                      color: mainColor,
                      size: 70
                    )
                  ),
                  SizedBox(height: 20),

                  Frame.myText(
                    text: InspectionType.basic  == inspectionType ?
                    '검사 진행중입니다.\n잠시만 기다려주세요.':
                    '성분 분석 중입니다.\n잠시만 기다려주세요.',
                    align: TextAlign.center,
                    fontSize: 1.4,
                    maxLinesCount: 2,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    ),
                ],
              ),
            ),
          ),
        );
      },

    );
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // add fade animation
    return FadeTransition(
      opacity: animation,
      // add slide animation
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, -1),
          end: Offset.zero,
        ).animate(animation),
        // add scale animation
        child: ScaleTransition(
          scale: animation,
          child: child,
        ),
      ),
    );
  }
}