import 'package:flutter/material.dart';

import '../../../../common/common.dart';
import '../widget/scaffold/frame_scaffold.dart';
import '../widget/style_text.dart';

class VersionView extends StatelessWidget {
  const VersionView({super.key});

  String get title => '앱버전';

  @override
  Widget build(BuildContext context) {
    return FrameScaffold(
      appBarTitle: title,
      body: Center(
        child: StyleText(
          text: '현재 앱 버전 ${Texts.appVersion}',
          color: AppColors.greyTextColor,
          size: AppDim.fontSizeLarge,
        ),
      ),
    );
  }
}
