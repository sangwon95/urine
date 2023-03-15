
import 'package:flutter/material.dart';
import 'package:urine/widgets/dialog.dart';

import '../utils/color.dart';
import '../utils/etc.dart';
import '../utils/frame.dart';

class LoginTextField extends StatelessWidget {

  final IconData iconData;
  final String hint;
  final String type;
  final TextEditingController controller;

  LoginTextField({required this.iconData, required this.hint, required this.controller, required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        height: 60.0,
        child: MediaQuery(
          data: Etc.getScaleFontSize(context, fontSize: 0.75),
          child: TextField(
            autofocus: false,
            obscureText:type == 'pass'? true : false,
            controller: controller,
            keyboardType: TextInputType.text,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
                fillColor: mainColor,
                border: OutlineInputBorder(borderRadius: const BorderRadius.all(const Radius.circular(5.0))),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: textFieldBorderColor, width: 1.5)),
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(iconData, color: mainColor),
                hintText: hint,
                hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600)
            ),
          ),
        )
    );
  }
}

// ignore: must_be_immutable
class SignTextField extends StatelessWidget {

  final String hint;
  final String type;
  final String headText;
  final TextEditingController controller;

  SignTextField({required this.hint, required this.controller, required this.type, required this.headText});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
          child: Text(headText, textScaleFactor: 1.0, style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.bold)),
        ),

        Container(
            height: 60.0,
            alignment: Alignment.centerLeft,
            child: MediaQuery(
              data:Etc.getScaleFontSize(context, fontSize: 0.75),
              child: TextField(
                enabled: type == 'birth' ? false : true,
                autofocus: false,
                obscureText: type == 'pass'? true : false,
                controller: controller,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: const BorderRadius.all(const Radius.circular(5.0))),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: textFieldBorderColor, width: 1.5)),
                    contentPadding: EdgeInsets.only(left: 12, top: 15),
                    fillColor: Colors.red,
                    hoverColor: mainColor,
                    hintText: hint,
                    hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400)
                ),
              ),
            )
        )
      ],
    );
  }
}


/// Password custom TextFiled Widget
/// This widget is a widget that can check if the password matches.
class PwdTextFiled extends StatelessWidget {
  final String headText;
  final String hint;

  /// [controller] listener registration is required to
  /// change the text widget at the bottom.
  /// ex) controller.addListener(_onChangedFunction)
  final TextEditingController controller;

  /// [true] when there is bottom text widget
  /// [false] when there is not bottom text widget
  final bool isViewPoint;

  /// [true] when Passwords match.
  /// [false] when Passwords do not match.
  final bool isSame;

  PwdTextFiled({
    required this.headText,
    required this.hint,
    required this.isViewPoint,
    required this.controller,
    required this.isSame
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Padding(
          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
          child: Text(headText, textScaleFactor: 1.0,
              style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.bold)),
        ),

        Container(
            height: 60.0,
            alignment: Alignment.centerLeft,
            child: MediaQuery(
                data: Etc.getScaleFontSize(context, fontSize: 0.75),
                child: TextField(
                  autofocus: false,
                  obscureText: true,
                  controller: controller,
                  keyboardType: TextInputType.text,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      border:  OutlineInputBorder(borderRadius: const BorderRadius.all(const Radius.circular(5.0))),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: textFieldBorderColor, width: 1.5)),
                      contentPadding: EdgeInsets.only(left: 12, top: 15),
                      hoverColor: mainColor,
                      hintText: hint,
                      hintStyle: TextStyle(color: Colors.grey)),
                ))
        ),

        /// Bottom text widget
        Visibility(
            visible: isViewPoint,
            child: Container(
                height: 35,
                padding: EdgeInsets.only(left: 5),
                child: Row(
                    children:
                    [
                      Icon(
                          isSame ? Icons.check_circle_outline : Icons.error_outline_sharp,
                          size: 20.0,
                          color: isSame ? Colors.lightBlue :  Colors.red),
                      Padding(
                          padding: EdgeInsets.only(left: 5.0),
                          child: Text(isSame ? '비밀번호가 일치합니다.' : '위 비밀번호와 다릅니다.', textScaleFactor: 0.9,
                              style: TextStyle(color: isSame ? Colors.lightBlue :  Colors.red, fontWeight: FontWeight.w600)))
                    ]
                ))
        ),

      ],
    );
  }
}


class DateTextField extends StatelessWidget {
  final String text;
  final Function(String searchStartDate, String searchEndDate) updateDateBirth;

  const DateTextField({super.key, required this.text, required this.updateDateBirth});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children:
        [
          InkWell(
            onTap: (){
                CustomDialog.showStartEndDialog(context,
                    onPositive: (searchStartDate, searchEndDate)=>updateDateBirth(searchStartDate, searchEndDate));

            },
            child: Container(
                height: 48.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: textFieldBorderColor, width: 1.5),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                      [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Icon(Icons.date_range, size: 25, color: mainColor,),
                        ),
                        Frame.myText(text: text, color: text == '생년월일을 입력해주세요.' ? Colors.grey : Colors.black, fontWeight: FontWeight.w400, fontSize: 0.85),
                      ],
                ))
            ),
          )
        ],
      ),
    );
  }
}

