import 'package:flutter/material.dart';

import '../../model/terms_data.dart';
import '../../utils/color.dart';
import '../utils/frame.dart';

/// 전체 이용약관 화면
class TermsFullPage extends StatelessWidget {

  final String title = '이용 약관 및 정책';
  final termsText = TermsText();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: Frame.myAppbar(title),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
          [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 30),
              child: Container(
                  width:MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(border: Border.all(width: 2.0, color: mainColor),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: Padding(padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                      [
                        /// 개인정보 수집 및 이용 동의
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(termsText.privacyTitle, textScaleFactor: 1.3, style: TextStyle(fontWeight: FontWeight.w600)),
                        ),
                        Text(termsText.privacyMainText),

                        /// 민감정보 처리에 대한 동의
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(termsText.sensitiveTitle, textScaleFactor: 1.3, style: TextStyle(fontWeight: FontWeight.w600)),
                        ),
                        Text(termsText.sensitiveMainText),

                        /// 연구과제 설명 및 참여 동의
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(termsText.researchTitle, textScaleFactor: 1.3, style: TextStyle(fontWeight: FontWeight.w600)),
                        ),
                        Text(termsText.researchMainText),
                      ],
                    ),
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
