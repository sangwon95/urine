
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:urine/common/common.dart';
import 'package:urine/layers/model/authorization.dart';

import '../../../../common/data/preference/prefs.dart';
import '../../../../common/util/dio/dio_exceptions.dart';
import '../../../../main.dart';
import '../../../domain/usecase/auth_usecase.dart';
import '../../../entity/login_dto.dart';
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
      loginDialog(context, Texts.loginEmptyField);
      return;
    }
    try {
      LoginDTO? resonse = await LoginUseCase().execute(toMap());
        if (resonse?.status.code == Texts.successCode && resonse != null){
          Authorization().setValues(
              userID: _idController.text,
              password: _passController.text,
              token: resonse.data ?? '',
          );

          saveAuthPrefs(resonse.data ?? '');
          Nav.doAndRemoveUntil(context, const HomeView());
        }
        else {
          loginDialog(context, Texts.loginFailed);
        }
    } on DioException catch (e) {
      final msg = DioExceptions.fromDioError(e).toString();
      loginDialog(context, msg);
    } catch (e) {
      logger.e(e);
      loginDialog(context, Texts.unexpectedError);
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
      title: Texts.loginLabel,
      content: message,
      mainContext: context,
    );
  }
}