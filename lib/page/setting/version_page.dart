
import 'package:flutter/material.dart';

import '../../utils/color.dart';
import '../../utils/constants.dart';
import '../../utils/frame.dart';


/// 앱 버전 화면
class VersionPage extends StatelessWidget {

  final String title = '버전정보';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Frame.myAppbar(title),

      body: Container(

        padding: EdgeInsets.only(bottom: 40),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:
            [
              Text('현재 버전 $APP_VERSION', textScaleFactor: 1.3, style: TextStyle(color: Colors.grey))
            ],
          ),
        ),
      ),
    );
  }
}
