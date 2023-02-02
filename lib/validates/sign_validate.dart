import 'package:flutter/material.dart';
import '../widgets/dialog.dart';


/// 회원가입 유효성 확인 클래스
class SignValidate{

  /// 아이디(이메일) 체크
  bool checkID(String value, BuildContext context){
    if(value.isEmpty) {
      CustomDialog.showMyDialog('아이디 확인!', '아이디 작성란이 비어 있습니다. 작성 후 다시 시도바랍니다.', context, false);
      return false;
    }
    else {
      String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = new RegExp(pattern);

      if(!regExp.hasMatch(value)) {
        CustomDialog.showMyDialog('아이디 확인!', '잘못된 이메일 형식입니다. 사용중인 이메일를 작성해주세요.', context, false);
        return false;
      }
      else
        return true;
    }
  }


  /// 비밀번호 체크
  bool checkPassword(String value, BuildContext context){
    if(value.isEmpty){
      CustomDialog.showMyDialog('비밀번호 확인!', '비밀번호 작성란이 비어 있습니다. 작성 후 다시 시도바랍니다.', context, false);
      return false;
    }
    else {
      String pattern = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*\\W).{7,15}";
      RegExp regExp = new RegExp(pattern);

      if(!regExp.hasMatch(value)){
        CustomDialog.showMyDialog('비밀번호 확인!', '특수, 대소문자, 숫자 포함 7자~15자로 입력하세요.', context, false);
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
      CustomDialog.showMyDialog('비밀번호 재입력 확인!', '비밀번호 재입력이 비어 있습니다. 작성 후 다시 시도바랍니다.', context, false);
      return false;
    }
    else
        return true;
    }


  /// 비밀번호 일치 체크
  bool checkSamePassword(String value, String value2, BuildContext context){
    if(value != value2){
      CustomDialog.showMyDialog('비밀번호 확인!', '비밀번호가 일치하지 않습니다. 작성 후 다시 시도바랍니다.', context, false);
      return false;
    }
    else
      return true;
  }


  /// 성별 체크
  bool checkGender(String? value, BuildContext context){
    if(value == null){
      CustomDialog.showMyDialog('성별 확인!', '성별을 선택해주세요. 선택 후 다시 시도바랍니다.', context, false);
      return false;
    }
    else
      return true;
  }


  /// 생년월일 체크
  bool checkDateOfBirth(String? value, BuildContext context){
    if(value == null){
      CustomDialog.showMyDialog('생년월일 확인!', '생년월일이 선택되지 않았습니다. 선택 후 다시 시도바랍니다.', context, false);
      return false;
    }
    else
      return true;
  }


  /// 회사이름 체크
  bool checkCompanyName(String value, BuildContext context){
    if(value.isEmpty){
      CustomDialog.showMyDialog('회사이름 확인!', '회사이름이 비어있습니다. 작성 후 다시 시도바랍니다.', context, false);
      return false;
    }
    else
      return true;
  }


  /// 직무 체크
  bool checkJobName(String? value, BuildContext context){
    if(value == null){
      CustomDialog.showMyDialog('직무 확인!', '직무가 선택되지 않았습니다. 선택 후 다시 시도바랍니다.', context, false);
      return false;
    }
    else
      return true;
  }

  /// 이름 체크
  bool checkName(String? value, BuildContext context){
    if(value == null){
      CustomDialog.showMyDialog('이름 확인!', '이름 작성란이 비어있습니다. 작성 후 다시 시도바랍니다.', context, false);
      return false;
    }
    else if(value.length >=7){
      CustomDialog.showMyDialog('이름 확인!', '정확한 이름 작성 후 다시 시도바랍니다.', context, false);
      return false;
    }
    else
      return true;
  }

}