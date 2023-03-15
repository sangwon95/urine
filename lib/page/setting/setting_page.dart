
import 'package:flutter/material.dart';
import 'package:urine/page/setting/password_change_page.dart';
import 'package:urine/page/setting/version_page.dart';


import '../../utils/etc.dart';
import '../../utils/frame.dart';
import '../../widgets/dialog.dart';
import '../terms_full_page.dart';

/// 설정 화면
class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final String title = '설정';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Frame.myAppbar(title),

      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 10),
          child: Column(
            children:
            [
              _buildMenu('프로필 수정'),
              _buildMenu('비밀번호 재설정'),
              _buildMenu('버전 정보'),
              _buildMenu('이용약관 및 정책'),
              _buildMenu('로그 아웃'),
            ],
          ),
        ),
      ),
    );
  }

  /// Menu item widget
  _buildMenu(String text) {
    return InkWell(
      onTap: ()
      {
        if(text == '비밀번호 재설정')
          Frame.doPagePush(context, PassChangePage(()=>editInfoCompleteMsg()));

        else if(text == '버전 정보')
          Frame.doPagePush(context, VersionPage());

        else if(text == '이용약관 및 정책')
          Frame.doPagePush(context, TermsFullPage());

        else if(text == '회원 탈퇴')
          CustomDialog.showActionDialog('회원 탈퇴!', '회원 탈퇴 하시겠습니까?\n주의! 개인정보가 삭제됩니다.', context);

        else if(text == '로그 아웃')
          CustomDialog.showActionDialog('로그 아웃!', '로그 아웃 하시겠습니까?', context);
      },
      child: Column(
        children: [
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey, width: 0.2),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:
                [
                  Text(text, textScaleFactor: 1.0),
                  Icon(Icons.arrow_forward_ios_sharp, color: Colors.grey, size: 15),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 개인정보, Pwd 수정 완료 메시지
  editInfoCompleteMsg(){
    Etc.showSnackBar(context, msg: '정상적으로 변경 되었습니다.', durationTime: 3);
  }
}
