
import 'package:flutter/material.dart';

import '../utils/edit_controller.dart';
import '../utils/etc.dart';
import '../utils/frame.dart';
import '../utils/network_connectivity.dart';
import '../widgets/bottom_sheet.dart';
import '../widgets/button.dart';
import '../widgets/text_field.dart';

/// 로그인 화면
class LoginPage extends StatefulWidget {

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  /// Login TextEditingController
  final LoginEdit _loginEdit = LoginEdit();

  @override
  Widget build(BuildContext context) {

    /// 네트워크 연결 상태 확인
    NetWorkConnectivity(context: context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // 키보드 내리기
        },
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:
              [
                /// 최상단 bi image
                Container(
                    height: 250,
                    padding: const EdgeInsets.fromLTRB(0, 150, 0, 10),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: Colors.white),
                    child: Center(
                        child: Image.asset('images/logo.png', height: 230, width: 230))
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                  child: LoginTextField(iconData: Icons.account_box, hint: '아이디를 입력해주세요.', controller: _loginEdit.idController, type: 'id')
                ),

                /// 비밀번호 입력
                Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
                    child: LoginTextField(iconData: Icons.vpn_key, hint: '비밀번호를 입력해주세요.', controller: _loginEdit.passController, type: 'pass')
                ),

                /// 로그인 버튼
                LoginButton(loginEdit: _loginEdit, context: context),

                /// 회원가입 Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                  [
                    Container(
                        child: InkWell(
                            onTap: ()
                            {
                              Etc.showSnackBar(context, msg: '온워즈: 042-721-2997 문의 바랍니다.', durationTime: 4);
                            },
                            child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Frame.myText(text: '문의 하기', fontSize: 0.9, color: Colors.grey, fontWeight: FontWeight.w600)))
                    ),

                    Etc.solidLineVertical(),

                    Container(
                        child: InkWell(
                            onTap: ()
                            {
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (BuildContext context){
                                    return StatefulBuilder(
                                        builder: (BuildContext context, Function(void Function()) sheetSetState)
                                        {
                                          return TermsBottomSheet();
                                        }
                                    );
                                  }
                              );
                            },
                            child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Frame.myText(text: '회원가입', fontSize: 0.9, color: Colors.grey, fontWeight: FontWeight.w600)))
                    )
                  ],
                )

              ],
            ),
          ),
        ),
      )
    );
  }
}
