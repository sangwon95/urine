import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../common/common.dart';
import '../../../model/authorization.dart';
import '../result_item_box.dart';
import '../style_text.dart';


class ResultBoxAllBottomSheet extends StatefulWidget {
  final List<String> statusList;

  const ResultBoxAllBottomSheet({
    super.key,
    required this.statusList,
  });

  @override
  State<ResultBoxAllBottomSheet> createState() => _ResultBoxAllBottomSheetState();
}

class _ResultBoxAllBottomSheetState extends State<ResultBoxAllBottomSheet> {

  String get intro  => '${Authorization().name}님 검사 결과입니다';
  String get intro2  => '정확한 진단을 위해 정기적인 검사가 필요합니다.';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
        height: size.height * 0.85,
        padding: const EdgeInsets.symmetric(
          horizontal: AppDim.medium,
          vertical: AppDim.small,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
              topLeft: AppConstants.lightRadius,
              topRight: AppConstants.lightRadius),
        ),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTopBar(),
            _buildCancelButton(),

            StyleText(
              text: intro,
              color: AppColors.primaryColor,
              size: AppDim.fontSizeXLarge,
              fontWeight: AppDim.weightBold,
            ),
            const Gap(AppDim.xSmall),

            StyleText(
              text: intro2,
              color: AppColors.blackTextColor,
              fontWeight: AppDim.weight500,
            ),
            const Gap(AppDim.medium),

            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 11,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, //1 개의 행에 보여줄 item 개수
                childAspectRatio: 1 / 0.95, //item 의 가로 1, 세로 1 의 비율
                mainAxisSpacing: 1, //수평 Padding
                crossAxisSpacing: 1, //수직 Padding
              ),
              itemBuilder: (BuildContext context,int index){
                // return Text(index.toString());
                return ResultItemBox(
                        index: index,
                        status: widget.statusList[index],
                      );
              },
            ),
          ],
        )
    );
  }

  /// 상단 바 widget
  _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 70,
          height: 3,
          margin: EdgeInsets.only(top: AppDim.xSmall),
          decoration: BoxDecoration(
            color: AppColors.grey,
            borderRadius: AppConstants.borderLightRadius,
          ),
        )
      ],
    );
  }

  /// 취소 버튼
  _buildCancelButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          icon: Icon(Icons.cancel, color: AppColors.grey, size: AppDim.iconSmall),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

