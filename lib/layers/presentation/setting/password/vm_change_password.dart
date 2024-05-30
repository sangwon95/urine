
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:urine/layers/model/authorization.dart';

import '../../../../../common/data/validate/singup_validate.dart';
import '../../../../../common/util/nav.dart';
import '../../../../../common/util/snackbar_utils.dart';
import '../../../../../main.dart';
import '../../../domain/usecase/auth_usecase.dart';
import '../../auth/login/v_login.dart';
import '../../widget/w_custom_dialog.dart';

class ChangePasswordViewModel extends ChangeNotifier {
  /// 현재 비밀번호
  final _beforePassController = TextEditingController();

  /// 새 비밀번호
  final _newPassController = TextEditingController();

  /// 새 비밀번호 확인
  final _newPass2Controller = TextEditingController();

  TextEditingController get beforePassController => _beforePassController;
  TextEditingController get newPassController => _newPassController;
  TextEditingController get newPass2Controller => _newPass2Controller;


  /// 비밀번호 변경
  Future<void> changePassword(context) async {
    if (validationChangePass(context)) {
      return;
    }

    try {
      ChangePassUseCase().execute(toMap()).then((response) {
        if (response?.status.code == '200' && response != null) {
          Nav.doAndRemoveUntil(context, const LoginView());
          SnackBarUtils.showPrimarySnackBar(context, '비밀번호가 변경되었습니다.');
        } else {
          changePassDialog(context, '비밀번호 변경이 정상적으로\n처리되지 않았습니다.');
        }
      });
    } on DioException catch (e) {
      logger.e(e);
      changePassDialog(context, '죄송합니다.\n예기치 않은 문제가 발생했습니다.');
    } catch (e) {
      logger.e(e);
      changePassDialog(context, '죄송합니다.\n예기치 않은 문제가 발생했습니다.');
    }
  }


  /// 비밀번호 유효성 체크
  bool validationChangePass(BuildContext context){
    if(_beforePassController.text.isEmpty){
      changePassDialog(context, '현재 비밀번호를 입력해주세요.');
      return false;
    }

    if(
       SignValidate.checkSameBeforePassword(_beforePassController.text, Authorization().password, context)&&
       //SignValidate.checkPassword(_newPassController.text, context)&&
       //SignValidate.checkPassword2(_newPass2Controller.text, context)&&
       SignValidate.checkSamePassword(_newPassController.text, _newPass2Controller.text, context)
    ){
      return false; // 위 체크 내용이 true 경우
    }
    else {
      return true; // 위 체크 내용이 false 경우}
    }
  }


  Map<String, dynamic> toMap() {
    return {
      'userID'    : Authorization().userID,
      'password'  : _beforePassController.text,
      'npassword' : _newPassController.text,
    };
  }


  /// 비밀번호 변경 다이얼로그
  changePassDialog(BuildContext context, String message){
    CustomDialog.showMyDialog(
      title: '비밀번호 변경',
      content: message,
      mainContext: context,
    );
  }
}
