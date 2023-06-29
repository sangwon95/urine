// this class defines the full-screen semi-transparent modal dialog
// by extending the ModalRoute class
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:urine/utils/frame.dart';

import '../../utils/color.dart';

/// Screen displayed during ChatBot [action]
class LoadingPage extends ModalRoute {

  @override
  Duration get transitionDuration => const Duration(milliseconds: 0);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.58);

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  bool timerRunOnce = true;
  late Timer time;

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
                  CupertinoActivityIndicator(
                    color: Colors.white,
                    radius: 15.0
                  ),
                  SizedBox(height: 15),
                  Frame.myText(
                    text: '불러오는 중..',
                    fontSize: 1.0,
                    color: Colors.white,
                  )
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
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}