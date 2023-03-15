
import 'package:flutter/material.dart';
import 'package:urine/main.dart';

import '../page/recent_page.dart';
import '../utils/color.dart';
import '../utils/etc.dart';
import '../utils/frame.dart';

class ResultListItem extends StatelessWidget {

  final element;
  const ResultListItem({Key? key, required this.element}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mLog.d(element['datetime']);
    return InkWell(
      onTap: () {
        Frame.doPagePush(
            context,
            RecentPage(title: '상세 결과', datetime: element['datetime']));
      },
      child: Container(
          height: 75,
          padding: EdgeInsets.all(3),
          child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:
                    [
                      Container(
                        child: Row(
                          children:
                          [
                            /// icon image
                            Image.asset('images/past_icon.png',
                                height: 35, width: 35),

                            /// 항목
                            Container(
                              width: 180,
                              padding: EdgeInsets.only(left: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Frame.myText(
                                      text: '음성:${element['negativeCnt']}  양성:${element['positiveCnt']}',
                                      fontWeight: FontWeight.w600,
                                      maxLinesCount: 1),

                                  Frame.myText(
                                      text: Etc.setResultDateTime(element['datetime']),
                                      fontSize: 0.85,
                                      color: Colors.grey.shade500,
                                      fontWeight: FontWeight.normal,
                                      maxLinesCount: 1),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios_sharp, color: mainColor)
                    ]
                ),
              )
          )),
    );
  }
}