
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:urine/common/common.dart';
import 'package:urine/layers/model/authorization.dart';

import '../../../../common/data/preference/prefs.dart';
import '../../../../main.dart';
import '../../../domain/usecase/auth_usecase.dart';
import '../../home/v_home.dart';
import '../../widget/w_custom_dialog.dart';

class LoginViewModel extends ChangeNotifier{

  LoginViewModel();

  /// 아이디 TextEditing
  final _idController = TextEditingController();

  /// 비밀번호 TextEditing
  final _passController = TextEditingController();

  TextEditingController get idController => _idController;
  TextEditingController get passController => _passController;


  /// 로그인 진행
  Future login(BuildContext context) async {
    if (_idController.text.isEmpty || _passController.text.isEmpty) {
      loginDialog(context, '아이디, 비밀번호 입력해주세요.');
      return;
    }
    try {
      LoginUseCase().execute(toMap()).then((resonse) => {
        if (resonse?.status.code == '200' && resonse != null){
          Authorization().setValues(
              userID: _idController.text,
              password: _passController.text,
              token: resonse.data ?? '',
          ),

          saveAuthPrefs(resonse.data ?? ''),
          Nav.doAndRemoveUntil(context, const HomeView()),
        }
        else {
          loginDialog(context, '아이디, 비밀번호가 일치하지 않습니다.')
        }
          }
      );
    } on DioException catch (e) {
      logger.e(e);
      loginDialog(context, '죄송합니다.\n예기치 않은 문제가 발생했습니다.');
    } catch (e) {
      logger.e(e);
      loginDialog(context, '죄송합니다.\n예기치 않은 문제가 발생했습니다.');
    }
  }


  Map<String, dynamic> toMap(){
   return {
     'userID'   : _idController.text,
     'password' : _passController.text,
   };
  }


  /// 자동로그인을 위한 데이터 저장
  saveAuthPrefs(String token){
    Prefs.userID.set(_idController.text);
    Prefs.password.set(_passController.text);
    Prefs.token.set(token);
  }


  /// 로그인 다이얼로그
  loginDialog(BuildContext context, String message){
    CustomDialog.showMyDialog(
      title: '로그인',
      content: message,
      mainContext: context,
    );
  }
}