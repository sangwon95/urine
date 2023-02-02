import 'package:flutter/material.dart';
import '../model/authorization.dart';
import 'my_shared_preferences.dart';

/// 자동로그인 클래스
class AutoLoginManager{
  MySharedPreferences _saveData = MySharedPreferences();

  void authLogin(BuildContext context, String id, String pwd)
  {
    Authorization().userID         = id;
    Authorization().password       = pwd;


    setSharedPreferencesData();
  }

  /// save SharedPreferences
  /// saving user data through SharedPreferences
  void setSharedPreferencesData() {
    _saveData.setStringData('userID'       , Authorization().userID);
    _saveData.setStringData('password'     , Authorization().password);
  }
}