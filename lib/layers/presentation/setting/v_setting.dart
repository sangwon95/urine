
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urine/layers/model/authorization.dart';
import 'package:urine/layers/presentation/setting/v_version.dart';
import 'package:urine/layers/presentation/setting/vm_setting.dart';

import '../../../../common/common.dart';
import '../widget/scaffold/frame_scaffold.dart';
import '../widget/style_text.dart';
import '../widget/w_custom_dialog.dart';
import 'manager/v_manager.dart';
import 'opensource/v_opensource.dart';
import 'v_terms_full.dart';


/// 설정 화면
class SettingView extends StatefulWidget   {
  const SettingView({Key? key}) : super(key: key);

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView>{

  String get title => '설정';


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => SettingViewModel(),
      child: FrameScaffold(
        appBarTitle: title,
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: AppDim.small),
            child: Column(
              children:
              [

                 Visibility(
                   visible: Authorization().userID == 'sim3383' ? true : false,
                   child: _buildMenu('관리자'),
                 ),
                _buildMenu('버전 정보'),
                _buildMenu('이용약관 및 정책'),
                _buildMenu('오픈소스 라이선스'),
                _buildMenu('로그 아웃'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Menu item widget
  _buildMenu(String text) {
    return Consumer<SettingViewModel>(
      builder: (context, provider, child) {
        return InkWell(
          onTap: () {
            switch(text){
              case '관리자': {
                Nav.doPush(context, const ManagerView());
                break;
              }
              case '버전 정보': {
                Nav.doPush(context, const VersionView());
                break;
              }
              case '이용약관 및 정책': {
                Nav.doPush(context, TermsFullView());
                break;
              }
              case '오픈소스 라이선스': {
                Nav.doPush(context, const OpensourceView());
                break;
              }
              case '로그 아웃': {
                CustomDialog.showSettingDialog(
                    title: '로그아웃',
                    text: '\n로그아웃 하시겠습니까?',
                    mainContext: context,
                    onPressed: ()=> provider.logout(context),
                );
                break;
              }
            }
          },
          child: Column(
            children: [
              Container(
                height: 60,
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  border: Border(bottom: BorderSide(
                    color: AppColors.grey,
                    width: 0.1,
                  )),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:
                  [
                    StyleText(
                      text: text,
                      size: AppDim.fontSizeSmall,
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: AppColors.grey,
                      size: AppDim.iconXSmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
