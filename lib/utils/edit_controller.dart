import 'package:flutter/material.dart';


/// 로그인 editingController class
class LoginEdit{

  TextEditingController idController   = TextEditingController(); // 아이디
  TextEditingController passController = TextEditingController(); // 비밀번호

  Map<String, dynamic> toMap() {
    Map<String, dynamic> toMap = {
      'userID'   : idController.text,
      'password' : passController.text,
    };
    return toMap;
  }

}



/// 회원가입 editingController class
class SignEdit{

  TextEditingController idController    = TextEditingController(); // 아이디
  TextEditingController passController  = TextEditingController(); // 비밀번호
  TextEditingController pass2Controller = TextEditingController(); // 비밀번호 확인
  TextEditingController nameController = TextEditingController();  // 이름



  Map<String, dynamic> toMap() {
    Map<String, dynamic> toMap = {
      'userID'      : idController.text,
      'password'    : passController.text,
      'name'        : nameController.text,
    };
    return toMap;
  }

  /// 개인정보 수정 toMap
  Map<String, dynamic> toMapEditInfo() {
    Map<String, dynamic> toMap = {
      'userID'      : idController.text,
    };
    return toMap;
  }
}



/// 비밀번호 변경 editingController class
class PasswordEdit {
  TextEditingController beforePassController  = TextEditingController(); // 현재 비밀번호
  TextEditingController newPassController     = TextEditingController(); // 새 비밀번호
  TextEditingController newPass2Controller    = TextEditingController(); // 새 비밀번호 확인

  Map<String, dynamic> toMap(String userID) {
    Map<String, dynamic> toMap =
    {
      'userID'      : userID,
      'password'    : beforePassController.text,
      'npassword'   : newPassController.text,
    };

    return toMap;
  }
}