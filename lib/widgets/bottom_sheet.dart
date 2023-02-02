import 'dart:core';

import 'package:flutter/material.dart';
import 'package:urine/utils/etc.dart';
import 'package:urine/widgets/button.dart';
import 'package:intl/intl.dart';

import '../model/urine_model.dart';
import '../page/recent_page.dart';
import '../utils/color.dart';
import '../utils/frame.dart';
import '../widgets.dart';

class TermsBottomSheet extends StatefulWidget {

  @override
  State<TermsBottomSheet> createState() => _TermsBottomSheetState();
}

class _TermsBottomSheetState extends State<TermsBottomSheet> {

  /// agree flag list
  List<bool> agree = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF737373),
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: BorderRadius.only(topLeft:Radius.circular(20), topRight: Radius.circular(20))),
        padding: EdgeInsets.only(
            bottom: bottomPadding(context)),
        child: SizedBox(
          height: 390,
          child: Container(
            padding: EdgeInsets.only(top: 15),
            child: Column(
              children: [
                /// 상단 내림 바
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 70, height: 3,
                      decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    )
                  ],
                ),

                Container(
                  padding: EdgeInsets.only(top: 30, left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                    [
                      _buildRowCheckBox(0, '약관 전체 동의'),
                      Etc.solidLine(context),
                      _buildRowCheckBox(1, '서비스 이용 약관'),
                      _buildRowCheckBox(2, '개인정보 이용 약관'),
                      _buildRowCheckBox(3, '개인정보 제 3자 제공 동의'),

                      Padding(
                          padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                          child: TermsButton(
                              btnName: '동의하기',
                              context: context,
                              agree: agree,
                          )
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),

        ),
      ),
    );
  }

  /// check box click area and text
  _buildRowCheckBox(int index, String headText) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children:
          [
            Transform.scale(
              scale: 1.1,
              child: Checkbox(
                  activeColor: mainColor,
                  checkColor: Colors.white,
                  shape: CircleBorder(side: BorderSide(color: mainColor)),
                  value: agree[index],
                  onChanged:(bool? value) {
                    setState(()
                    {
                      if(index == 0)
                      {
                        for(int i = 0 ; i<agree.length ; i++)
                          agree[i] = value!;
                      }
                      else{
                        agree[index] = value!;
                      }
                    });
                  }),
            ),
            Container(
                child: Row(
                    children:
                    [
                      Text(headText, softWrap: true, textScaleFactor: index == 0 ? 1.2 : 1.0,
                          style: TextStyle(fontWeight: index == 0 ? FontWeight.w600 : FontWeight.w500)),
                      Visibility(
                          visible:index == 0 ? false : true,
                          child:Text(' (필수)', softWrap: true, textScaleFactor: 1.0, style: TextStyle(color: Colors.red))),
                    ]
                )),

          ],
        ),


        Visibility(
          visible: index == 0 ? false : true,
          child: Text(
            '보기',
            textScaleFactor: 0.9,
            style: TextStyle(
              color: Colors.grey,
              decoration: TextDecoration.underline,
            ),
          ),
        )
      ],
    );
  }

  /// sheet bottom
  double bottomPadding(BuildContext ctx) {
    var result = MediaQuery.of(ctx).viewInsets.bottom;
    if (result == 0) result = 10;
    return result;
  }
}
