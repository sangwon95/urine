import 'package:flutter/material.dart';
import '../widgets/dialog.dart';

/// 비밀번호 변경 유효성 확인 클래스
class PasswordValidate{

  /// 기존 비밀번호 체크
  bool checkBeforePassword(String value, String value2, BuildContext context){
    if(value.isEmpty){
      CustomDialog.showMyDialog('현재 비밀번호 확인!', '현재 비밀번호 작성란이 비어 있습니다. 작성 후 다시 시도바랍니다.', context, false);
      return false;
    }
    else {
      String pattern = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*\\W).{7,15}";
      RegExp regExp = new RegExp(pattern);

      if(!regExp.hasMatch(value)){
        CustomDialog.showMyDialog('현재 비밀번호 확인!', '특수, 대소문자, 숫자 포함 7자~15자로 입력하세요.', context, false);
        return false;
      }

      if(value != value2){
        CustomDialog.showMyDialog('현재 비밀번호 확인!', '현재 비밀번호가 다릅니다. 확인 후 다시 시도바랍니다.', context, false);
        return false;
      }
      else{
        return true;
      }
    }
  }


  /// 비밀번호 체크
  bool checkPassword(String value, BuildContext context){
    if(value.isEmpty){
      CustomDialog.showMyDialog('새 비밀번호 확인!', '새 비밀번호 작성란이 비어 있습니다. 작성 후 다시 시도바랍니다.', context, false);
      return false;
    }
    else {
      String pattern = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*\\W).{7,15}";
      RegExp regExp = new RegExp(pattern);

      if(!regExp.hasMatch(value)){
        CustomDialog.showMyDialog('새 비밀번호 확인!', '특수, 대소문자, 숫자 포함 7자~15자로 입력하세요.', context, false);
        return false;
      }
      else{
        return true;
      }
    }
  }


  /// 비밀번호2 체크
  bool checkPassword2(String value, BuildContext context){
    if(value.isEmpty){
      CustomDialog.showMyDialog('새 비밀번호 재입력 확인!', '새 비밀번호 재입력이 비어 있습니다. 작성 후 다시 시도바랍니다.', context, false);
      return false;
    }
    else
      return true;
  }


  /// 비밀번호 일치 체크
  bool checkSamePassword(String value, String value2, BuildContext context){
    if(value != value2){
      CustomDialog.showMyDialog('새 비밀번호 확인!', '새 비밀번호가 일치하지 않습니다. 작성 후 다시 시도바랍니다.', context, false);
      return false;
    }
    else
      return true;
  }
}