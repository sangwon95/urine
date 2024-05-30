import 'package:flutter/material.dart';
import 'package:urine/common/common.dart';

import '../../model/enum/home_button_type.dart';
import 'w_menu_button.dart';


class UrineHomeBody extends StatelessWidget {
  const UrineHomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: AppDim.large),
      child: const Column(
        children: [
          Row(
            children:
            [
              MenuButton(type: HomeButtonType.inspection), // 검사 시작
              MenuButton(type: HomeButtonType.history), // 검사 내역
            ],
          ),
          Row(
            children:
            [
              MenuButton(type: HomeButtonType.ingredient), // 성분 분석
              MenuButton(type: HomeButtonType.transition), // 나의 추이
            ],
          ),
        ],
      ),
    );
  }

}
