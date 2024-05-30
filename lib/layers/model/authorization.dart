
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/data/preference/prefs.dart';
import '../../main.dart';

/// Attributes to store user authorization information
class Authorization{
  late String userID; //ex)U00000
  late String password; // 비밀번호
  late String token; //ex)eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJV
  late String name; //ex)홍길동
  late bool toggleGatt = false; //ex)홍길동


  @override
  String toString() {
    return 'Authorization{userID: $userID, password: $password, token: $token}';
  } // 목표 걸음수

  // Authorization 클래스의 싱글톤 인스턴스
  static final Authorization _authInstance = Authorization.internal();

  // 싱글톤 패턴을 위한 비공개 생성자
  factory Authorization(){
    return _authInstance;
  }

  // 사용자 권한 값을 설정하는 메서드
  // Authorization 초기화
  void setValues({
    required String userID,
    required String password,
    required String token,
  }) {
    this.userID = userID;
    this.password = password;
    this.token = token;
  }

  /// Authorization의 단일 인스턴스를 제공하기 위한 팩토리 메서드
  Authorization.internal() {
    init();
  }

  /// 권한 값을 초기화하는 메서드
  clean() {
    init();
    clearSetStringData();
  }

  /// 권한 값을 초기화하는 메서드
  init() {
    userID = '';
    password = '';
    token = '';
    toggleGatt = false;
  }

  /// SharedPreferences clear
  clearSetStringData() async {
    var pref = await SharedPreferences.getInstance();
    pref.clear();
  }
}