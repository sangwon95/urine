

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../common/common.dart';
import 'style_text.dart';

class CustomDialog {

  /// 사용자 지정 다이얼로그를 화면에 표시하는 함수.
  ///
  /// [title]: 다이얼로그 상단에 표시할 제목 문자열.
  /// [content]: 다이얼로그 내용에 표시할 문자열.
  /// [mainContext]: 다이얼로그를 띄울 화면의 BuildContext.
  static showMyDialog({
    required String title,
    required String content,
    required BuildContext mainContext,
  }) {
    return showDialog(
        context: mainContext,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: AppConstants.borderLightRadius,
            ),
            title: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                [
                  Icon(
                    Icons.error,
                    color: AppColors.primaryColor,
                    size: AppDim.xLarge,
                  ),
                  const Gap(AppDim.small),
                  StyleText(
                    text: title,
                    fontWeight: AppDim.weightBold,
                  ),
                  const Gap(AppDim.small),
                ],
              ),
            ),
            content: SizedBox(
              height: 115,
              child: Column(
                children: [
                  const Gap(AppDim.xSmall),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppDim.large),
                    child: SizedBox(
                      height: 35,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          StyleText(
                              text: content,
                              align: TextAlign.center,
                              size: AppDim.fontSizeSmall,
                              softWrap: true,
                              maxLinesCount: 2,
                              fontWeight: AppDim.weight500
                          )
                        ],
                      ),
                    ),
                  ),
                  const Gap(AppDim.large),

                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: TextButton(
                          style: TextButton.styleFrom(
                              elevation: 5.0,
                              backgroundColor: AppColors.primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    bottomRight: AppConstants.lightRadius,
                                    bottomLeft: AppConstants.lightRadius,
                                  ))),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const StyleText(
                            text: '확인',
                            color: AppColors.white,
                            fontWeight: AppDim.weightBold,
                          )
                      ),
                    ),
                  ),
                ],
              ),
            ),
            contentPadding: const EdgeInsets.all(0),
            actionsAlignment: MainAxisAlignment.end,
            actionsPadding: const EdgeInsets.all(0),

          );
        });
  }


  // static showLoginDialog({
  //   required String title,
  //   required String content,
  //   required BuildContext mainContext,
  // }) {
  //   return showDialog(
  //       context: mainContext,
  //       barrierDismissible: false,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           shape: RoundedRectangleBorder(
  //               borderRadius: AppConstants.borderLightRadius),
  //           title: Center(
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Icon(
  //                   Icons.error,
  //                   color: AppColors.primaryColor,
  //                   size: AppDim.xLarge,
  //                 ),
  //                 const Gap(AppDim.small),
  //                 StyleText(
  //                   text: title,
  //                   fontWeight: AppDim.weightBold,
  //                 )
  //               ],
  //             ),
  //           ),
  //           content: SizedBox(
  //             height: 135,
  //             child: Column(
  //               children: [
  //                 const Gap(AppDim.xSmall),
  //                 Padding(
  //                   padding: const EdgeInsets.symmetric(
  //                       horizontal: AppDim.large),
  //                   child: SizedBox(
  //                     height: 60,
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         SizedBox(
  //                             width: 220,
  //                             child: StyleText(
  //                               text: content,
  //                               align: TextAlign.center,
  //                               size: AppDim.fontSizeSmall,
  //                               maxLinesCount: 2,
  //                               fontWeight: AppDim.weight500,
  //                             ))
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //                 const Gap(AppDim.large),
  //
  //                 Row(
  //                   children: [
  //                     Expanded(
  //                       child: Container(
  //                         width: 60,
  //                         height: 45,
  //                         child: TextButton(
  //                           style: TextButton.styleFrom(
  //                               elevation: 3.0,
  //                               backgroundColor: AppColors.primaryColor,
  //                               shape: const RoundedRectangleBorder(
  //                                   borderRadius: BorderRadius.only(
  //                                       bottomLeft: Radius.circular(5.0)))),
  //                           onPressed: () {
  //                             Navigator.pop(context);
  //                           },
  //                           child: const StyleText(
  //                             text: '취소',
  //                             color: AppColors.white,
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                     const Gap(1),
  //                     Expanded(
  //                       child: SizedBox(
  //                         height: 45,
  //                         width: 60,
  //                         child: TextButton(
  //                           style: TextButton.styleFrom(
  //                               elevation: 5.0,
  //                               backgroundColor: AppColors.primaryColor,
  //                               shape: RoundedRectangleBorder(
  //                                   side: BorderSide(width: 1.0,
  //                                       color: AppColors.primaryColor),
  //                                   borderRadius: const BorderRadius.only(
  //                                       bottomRight: Radius.circular(5.0)))),
  //                           onPressed: () =>
  //                           {
  //                             Navigator.pop(context),
  //                             Nav.doPush(context, const LoginViewTest()),
  //                           },
  //                           child: const StyleText(
  //                               text: '로그인', color: AppColors.white),
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 )
  //
  //               ],
  //             ),
  //           ),
  //           contentPadding: const EdgeInsets.all(0),
  //           actionsAlignment: MainAxisAlignment.end,
  //           actionsPadding: const EdgeInsets.all(0),
  //
  //         );
  //       });
  // }

  /// 네트워크 연결 상태 다이얼로그
  static showNetworkDialog(String title, String text, BuildContext mainContext,
      Function onPressed) {
    return showDialog(
        context: mainContext,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            title: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, textScaleFactor: 0.85,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            content: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 190,
                      child: Text(text, textAlign: TextAlign.center,
                          textScaleFactor: 0.85)),
                ],
              ),
            ),
            contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
            actionsAlignment: MainAxisAlignment.center,
            actions: <Widget>[
              Container(
                height: 40,
                width: 240,
                margin: EdgeInsets.only(bottom: 10),
                child: TextButton(
                    style: TextButton.styleFrom(
                        elevation: 5.0,
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 1.0, color: AppColors.primaryColor),
                            borderRadius: BorderRadius.circular(5.0))),
                    onPressed: () => onPressed(),
                    child: const Text('확인', textScaleFactor: 1.0,
                        style: TextStyle(color: AppColors.white))
                ),
              ),

            ],
          );
        });
  }






  /// 설정 다이얼 로그(로그 아웃)
  static showSettingDialog({
    required String title,
    required String text,
    required BuildContext mainContext,
    required Function onPressed
  }) {
    return showDialog(
        context: mainContext,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: AppConstants.borderLightRadius),
            title: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StyleText(
                    text: title,
                    fontWeight: AppDim.weightBold,
                  ),
                ],
              ),
            ),
            content: SizedBox(
              height: 122,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: 190,
                            height: 31,
                            child: StyleText(
                              text: text,
                              align: TextAlign.center,
                              size: AppDim.fontSizeSmall,
                              maxLinesCount: 2,
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 34),
                    child: Row(
                      children:
                      [
                        Expanded(
                          child: SizedBox(
                            width: 60,
                            height: 45,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                  elevation: 3.0,
                                  backgroundColor: AppColors.primaryColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: AppConstants.lightRadius))),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const StyleText(
                                  text: '취소', color: AppColors.white),
                            ),
                          ),
                        ),
                        const Gap(1),

                        Expanded(
                          child: SizedBox(
                            height: 45,
                            width: 60,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                  elevation: 5.0,
                                  backgroundColor: AppColors.primaryColor,
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(width: 1.0,
                                          color: AppColors.primaryColor),
                                      borderRadius:  BorderRadius.only(
                                          bottomRight: AppConstants.lightRadius))),
                              onPressed: () => onPressed(),
                              child: const StyleText(
                                  text: '확인',
                                  color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            contentPadding: const EdgeInsets.all(0.0),
          );
        });
  }


  /// Dio Exception Dialog
  static showDioDialog(String title, String text, BuildContext mainContext,
      {required Function onPositive}) {
    return showDialog(
        context: mainContext,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            title: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, textScaleFactor: 0.85,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            content: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 190,
                      child: Text(text, textAlign: TextAlign.center,
                          textScaleFactor: 0.85)),
                ],
              ),
            ),
            contentPadding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
            actionsAlignment: MainAxisAlignment.center,
            actions: <Widget>[


              Container(
                width: 240,
                height: 40,
                margin: const EdgeInsets.only(bottom: 10),
                child: TextButton(
                    style: TextButton.styleFrom(
                        elevation: 3.0,
                        backgroundColor: AppColors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                    onPressed: () => onPositive(),
                    child: const Text('확인', textScaleFactor: 1.0,
                        style: TextStyle(color: AppColors.grey))
                ),
              )

            ],
          );
        });
  }


  /// 팝업 형태로 표시
  static popup(context,
      {required Widget child, double width = 300, required double height, double padding = 10,
        bool bBackgroundTapPop = true, Color color = AppColors
          .white, double round = 15.0}) async {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(round))),
            contentPadding: EdgeInsets.all(padding),
            content: Container(
                width: width,
                //height:  // 호출 하는 곳의 column에서 mainAxisSize: MainAxisSize.min 적용 필요
                child: child
            ),
          );
        }
    );
  }
}
