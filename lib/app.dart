import 'package:after_layout/after_layout.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:urine/common/cli_common.dart';

import 'common/common.dart';
import 'layers/model/authorization.dart';
import 'layers/presentation/auth/login/v_login.dart';
import 'layers/presentation/home/v_home.dart';

class MyApp extends StatefulWidget{
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with AfterLayoutMixin{
  final themeData = ThemeData();

  @override
  Widget build(BuildContext context) {
    // 앱 화면 세로 위쪽 방향으로 고정
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: 'Yocheck',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      theme:Theme.of(context).copyWith(
        colorScheme: themeData.colorScheme.copyWith(primary: AppColors.primaryColor),
      ),
      initialRoute: Authorization().userID.isEmpty ? 'v_login' : 'v_home',
      routes: {
        'v_login': (context) => const LoginView(),
        'v_home': (context) => const HomeView(),
      },
    );
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    FlutterNativeSplash.remove();
  }
}