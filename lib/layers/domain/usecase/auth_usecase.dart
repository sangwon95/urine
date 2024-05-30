
import 'dart:ffi';


import 'package:urine/common/di/di.dart';
import 'package:urine/layers/data/%20repository/auth_repository_imp.dart';
import 'package:urine/layers/entity/login_dto.dart';

import '../../entity/change_pass_dto.dart';
import '../../entity/logout_dto.dart';
import '../../entity/signup_dto.dart';
import '../../model/vo_login.dart';
import '../../model/vo_signup.dart';
import '../repository/auth_repository.dart';
import 'base_usecase.dart';

/// 로그인 유스케이스
class LoginUseCase implements BaseUseCase<void, Map<String, dynamic>> {
  final AuthRepository _authRepository;

  LoginUseCase([AuthRepository? authRepository]) : _authRepository = authRepository ?? locator();

  @override
  Future<LoginDTO?> execute(Map<String, dynamic> toMap) {
    return _authRepository.login(toMap);
  }
}

/// 회원가입 유스케이스
class SignupUseCase implements BaseUseCase<void, Map<String, dynamic>> {
  final AuthRepository _authRepository;

  SignupUseCase([AuthRepository? authRepository]) : _authRepository = authRepository ?? locator();

  @override
  Future<SignupDTO?> execute(Map<String, dynamic> toMap) {
    return _authRepository.signup(toMap);
  }
}

/// 로그아웃 유스케이스
class LogoutUseCase implements NoParamUseCase<void, void> {
  final AuthRepository _authRepository;

  LogoutUseCase([AuthRepository? authRepository])
      : _authRepository = authRepository ?? locator();

  @override
  Future<LogoutDTO?> execute() {
    return _authRepository.logout();
  }
}

/// 비밀번호 변경 유스케이스
class ChangePassUseCase implements BaseUseCase<void, Map<String, dynamic>> {
  final AuthRepository _authRepository;

  ChangePassUseCase([AuthRepository? authRepository])
      : _authRepository = authRepository ?? locator();

  @override
  Future<ChangePassDTO?> execute(Map<String, dynamic> toMap) {
    return _authRepository.changePass(toMap);
  }
}