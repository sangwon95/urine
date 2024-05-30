
import 'package:flutter/material.dart';

/// Navigator 화면 이동 Util
class Nav {

  /// Navigator 화면 이동
  static doPush(BuildContext context, Widget page) {
    return Navigator.push(
        context, MaterialPageRoute(builder: (context) => page));
  }

  /// Navigator 화면 나가기
  static doPop(BuildContext context) {
    return Navigator.pop(context);
  }

  /// Navigator 화면 이동, 바로 이전 화면 1개는 스택에서 없앰.
  static doPushReplace(BuildContext context, Widget page) {
    return Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => page));
  }

  /// Navigator 화면 이동, 이전 화면 모두 삭제후 이동
  static doAndRemoveUntil(BuildContext context, Widget page) {
    return Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => page),
        (route) => false);
  }
}
