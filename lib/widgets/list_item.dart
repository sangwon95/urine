
import 'package:flutter/material.dart';
import 'package:urine/main.dart';
import 'package:urine/utils/dio_client.dart';

import '../model/result_list.dart';
import '../model/urine_model.dart';
import '../page/recent_page.dart';
import '../utils/color.dart';
import '../utils/etc.dart';
import '../utils/frame.dart';
import 'bottom_sheet.dart';

class ResultListItem extends StatelessWidget {

  final ResultList resultListItem;
  final BuildContext context;
  final Size size;
  const ResultListItem({Key? key,
    required this.resultListItem,
    required this.size,
    required this.context
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        // Frame.doPagePush(
        //     context,
        //     RecentPage(title: '상세 결과', datetime: resultListItem.datetime));

        final resultList =  await client.dioRecent(resultListItem.datetime);
        UrineModel urineModel = UrineModel();
        urineModel.initOfList(resultList);
        _showResult(urineModel);
      },
      child: Container(
          height: 85,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide( // POINT
                color: Colors.grey,
                width: 0.4,
              ),
            ),
          ),
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
                            height: 55, width: 55),

                        /// 항목
                        Container(
                          width: 180,
                          padding: EdgeInsets.only(left: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Frame.myText(
                                  text: Etc.setResultDateTime(resultListItem.datetime),
                                  fontSize: 1.0,
                                  color: Colors.grey.shade500,
                                  fontWeight: FontWeight.normal,
                                  maxLinesCount: 1),

                              SizedBox(height: 5),

                              Frame.myText(
                                  text: '음성-${resultListItem.negativeCnt} / 양성-${resultListItem.positiveCnt}',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 1.2,
                                  maxLinesCount: 1),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios_sharp, color: Colors.grey)
                ]
            ),
          )),
    );
  }

  _showResult(UrineModel urineModel) {
    /// 결과 데이터 view
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context){
          return StatefulBuilder(
              builder: (BuildContext context, Function(void Function()) sheetSetState) {
                return FastestBottomSheet(urineModel: urineModel, size: size);
              }
            );
        }
    );
  }
}