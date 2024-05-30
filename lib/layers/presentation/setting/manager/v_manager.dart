

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:urine/common/common.dart';
import 'package:urine/common/data/preference/prefs.dart';
import 'package:urine/common/util/snackbar_utils.dart';
import 'package:urine/layers/model/authorization.dart';
import 'package:urine/layers/presentation/widget/scaffold/frame_scaffold.dart';
import 'package:urine/layers/presentation/widget/style_text.dart';

class ManagerView extends StatefulWidget {
  const ManagerView({super.key});

  @override
  State<ManagerView> createState() => _ManagerViewState();
}

class _ManagerViewState extends State<ManagerView> {

 late bool _isChecked;

 @override
  void initState() {
   _isChecked = Authorization().toggleGatt;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FrameScaffold(
      appBarTitle: 'Manager',
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Switch(
                value: _isChecked,
                onChanged: (value) {
                  setState(() {
                    _isChecked = value;
                    Prefs.toggelGatt.set(value);
                    Authorization().toggleGatt = value;
                  });
                  SnackBarUtils.showPrimarySnackBar(context, '${value == true? '구버전이 ': '신규버전이 '}활성화 되었습니다.');
                },
            ),
            const Gap(AppDim.mediumLarge),

            const StyleText(
              text: '✓ 관리자 계정 [sim3383]만 볼수 있는 화면입니다.\n✓ OFF일 때 신규버전 디바이스\n✓ ON일 때 구버전 디바이스',
              softWrap: true,
              size: AppDim.fontSizeSmall,
              maxLinesCount: 4,
            )
          ],
        ),
      )
    );
  }
}
