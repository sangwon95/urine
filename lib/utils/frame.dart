import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io' show Platform;

import 'color.dart';

class Frame{

  /// 앱바 위젯
 static AppBar myAppbar(String title, {bool isIconBtn = false, Function? onPressed, IconData? icon = Icons.settings_rounded}){
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.white
      ),
      title: Frame.myText(
        text: title,
        fontSize: 1.0,
        color: mainColor,
        fontWeight: FontWeight.w600
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0.0,
      iconTheme: IconThemeData(color: Colors.black),
      actions:
      [
        /// 채팅화면 우측 상단 아이콘 버튼
        Visibility(
          visible: isIconBtn,
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
                onPressed: () => onPressed!(),
                icon: Icon(icon, size: 25)
            ),
          ),
        ),
      ],
    );
  }

 /// 앱바 타이틀 이미지 위젯
 static AppBar myImageAppbar({bool isIconBtn = false, Function? onPressed, IconData? icon = Icons.settings_rounded}){
   return AppBar(
     systemOverlayStyle: SystemUiOverlayStyle(
         statusBarBrightness: Brightness.light,
         statusBarIconBrightness: Brightness.dark,
         statusBarColor: Colors.white
     ),
     title: Image.asset('images/logo.png', color: mainColor, height: 25,),
     centerTitle: true,
     backgroundColor: Colors.white,
     elevation: 0.0,
     iconTheme: IconThemeData(color: Colors.grey.shade600),
     actions:
     [
       /// 채팅화면 우측 상단 아이콘 버튼
       Visibility(
         visible: isIconBtn,
         child: Padding(
           padding: const EdgeInsets.only(right: 10),
           child: IconButton(
               onPressed: () => onPressed!(),
               icon: Icon(icon, size: 25)
           ),
         ),
       ),
     ],
   );
 }

  static TextStyle textSpanBoldStyle(){
   return TextStyle(fontWeight: FontWeight.w600, color: Colors.blueAccent, fontSize: 14);
  }

  static TextStyle textSpanNormalStyle(){
   return TextStyle(fontWeight: FontWeight.normal, fontSize: 14);
  }


  /// 텍스트
  static Text myText({
    required String text,
    double fontSize = 1.0,
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.normal,
    TextAlign align = TextAlign.start,
    TextOverflow overflow = TextOverflow.visible,
    int maxLinesCount = 1,
    TextDecoration decoration = TextDecoration.none
  }){
   return Text(
     text,
     textScaleFactor: fontSize,
     overflow: overflow,
     maxLines: maxLinesCount,
     style: TextStyle(
         color: color,
         fontWeight: fontWeight,
       decoration: decoration,

     ),
     textAlign: align
     ,
   );
  }


  /// Navigator 화면 이동
  static doPagePush(BuildContext context, Widget page)
  {
   return Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }


 /// Navigator 화면 이동, 바로 이전 화면 1개는 스택에서 없앰.
 static doPagePushReplace(context, Widget page)
 {
   return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => page));
 }


 /// Navigator 화면 이동, 이전 화면 모두 삭제후 이동
 static doPageAndRemoveUntil(context, Widget page)
 {
   return Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) => page), (route) => false);
 }

}