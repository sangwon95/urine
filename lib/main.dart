import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'app.dart';
import 'common/common.dart';
import 'common/data/preference/app_preferences.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'common/data/preference/prefs.dart';
import 'common/di/di.dart';
import 'layers/domain/usecase/auth_usecase.dart';
import 'layers/entity/login_dto.dart';
import 'layers/model/authorization.dart';


/// TODO
/// 1) 포도당 수치 max 4

var logger = Logger(
    printer: PrettyPrinter(
        methodCount: 1,      // number of method calls to be displayed
        errorMethodCount: 8, // number of method calls if stacktrace is provided
        lineLength: 120,     // width of the output
        colors: true,        // Colorful log messages
        printEmojis: false,  // Print an emoji for each log message
        printTime: false     // Should each log print contain a timestamp
    )
);

Future<void> main() async {
  // 플랫폼 채널의 위젯 바인딩을 보장해야한다.
  final bindings = WidgetsFlutterBinding.ensureInitialized();

  // Flutter 초기화가 완료될 때까지 스플래시 화면을 표시합니다.
  FlutterNativeSplash.preserve(widgetsBinding: bindings);

  // EasyLocalization 패키지를 초기화하여 로컬라이제이션을 지원합니다.
  await EasyLocalization.ensureInitialized();

  // SharedPreferences 초기화
  await AppPreferences.init();

  // Locator 초기화
  initLocator();

  // 사용자 정보 초기화
  await initAuthorization();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ko')],
      fallbackLocale: const Locale('en'),
      path: 'assets/translations',
      useOnlyLangCode: true,
      child: const MyApp(),
    ),
  );
}

/// 사용자 정보 초기화
Future<void> initAuthorization() async {
  logger.i('afterFirstLayout');

  final userID = Prefs.userID.get();
  final password = Prefs.password.get();
  final token = Prefs.token.get();
  final toggleGatt = Prefs.toggelGatt.get();

  Authorization().setValues(
      userID: userID,
      password: password,
      token: token,
  );
  Authorization().toggleGatt = toggleGatt;

  if(Authorization().userID.isNotEmpty){
    await login();
  }
}


/// 로그인 진행
Future<void> login() async {
  Map<String, dynamic> toMap(){
    return {
      'userID'   : Authorization().userID,
      'password' :  Authorization().password,
    };
  }

  try {
   LoginDTO? response = await LoginUseCase().execute(toMap());
        if (response?.status.code == '200' && response != null){
          Authorization().token = response.data!;
          Prefs.token.set(response.data!);
          logger.d('로그인 성공: ${Authorization().userID}');
        } else {
          Authorization().userID = '-';
        }
  } on DioException catch (e) {
    logger.e(e);
    Authorization().userID = '-';
  } catch (e) {
    logger.e(e);
    Authorization().userID = '-';
  }
}


