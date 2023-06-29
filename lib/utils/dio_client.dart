import 'package:dio/dio.dart';
import 'package:urine/model/prediction_model.dart';
import 'package:urine/model/result_list.dart';
import 'package:urine/utils/etc.dart';

import '../main.dart';
import '../model/authorization.dart';

import '../model/login_model.dart';
import '../model/rest_response.dart';
import '../model/recent.dart';
import '../model/status_model.dart';
import '../model/urine_model.dart';
import 'constants.dart';
import 'custom_log_interceptor.dart';

Client client = Client();

class Client {

  Dio _createDio() {
    Dio dio = Dio();

    dio.interceptors.add(CustomLogInterceptor());
    dio.options.connectTimeout = 7000;
    dio.options.receiveTimeout = 7000;
    mLog.i(Authorization().token);

    dio.options.headers = {
      'Authorization': 'URINE ${Authorization().token}',
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };

    return dio;
  }

  /// AI분석 dio
  Future<String> dioAI(Map<String, dynamic> data) async {
    Etc.getValuesFromMap(data);
    try {
      Response response = await _createDio().post(API_AI, data: data);
      print(' >>> [Response statusCode] : ' + response.statusCode.toString());
      print(' >>> [Response statusMessage] : ' +
          response.statusMessage.toString());

      if (response.statusCode == 200) {
        return response.data['result'];
      }
      else {
        print(' >>> [Response statusCode] : ' + response.statusCode.toString());
        print(' >>> [Response statusMessage] : ' +
            response.statusMessage.toString());
        if (response.statusCode == 500)
          throw Exception(MESSAGE_SERVER_ERROR_DEFAULT);
        else
          throw Exception(MESSAGE_ERROR_CONNECT_SERVER);
      }
    }

    /// Timeout, serverConnect Error
    on DioError catch (error) {
      throw Exception(error.type);
    }
    catch (e) {
      print(e.toString());
    }
    return 'unknown';
  }


  /// 회원가입 dio
  Future<StatusModel> dioSign(Map<String, dynamic> data) async
  {
    late StatusModel statusModel;
    late Response response;
    try {
      response = await _createDio().post(API_USER_INSERT, data: data);

      if (response.statusCode == 200) {
        statusModel = StatusModel.fromJson(RestResponseOnlyStatus.fromJson(response.data));
        return statusModel;
      }
      else {
        mLog.e('Sign statusCode : ${response.statusCode.toString()}');
        mLog.e('Sign statusMessage : ${response.statusMessage.toString()}');

        if (response.statusCode == 500)
          throw Exception(MESSAGE_ERROR_RESPONSE);
        else
          throw Exception(MESSAGE_ERROR_UNKNOWN);
      }
    } on DioError catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }


  /// 로그인 dio
  Future<LoginModel> dioLogin(Map<String, dynamic> data) async
  {
    late Response response;
    late LoginModel loginModel;
    try {
      response = await _createDio().post(API_URL_LOGIN, data: data);

      if (response.statusCode == 200) {
        loginModel = LoginModel.fromJson(RestResponseDataString.fromJson(response.data));
        return loginModel;
      }
      else {
        mLog.e('Login  statusCode : ${response.statusCode.toString()}');
        mLog.e('Login  statusMessage : ${response.statusMessage.toString()}');

        if (response.statusCode == 500)
          throw Exception(MESSAGE_ERROR_RESPONSE);
        else
          throw Exception(MESSAGE_ERROR_CONNECT_SERVER);
      }
    } on DioError catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  /// 검새 결과 데이터 저장
  Future<UrineModel> dioSaveResultData(List<Map<String, dynamic>> data) async
  {
    late Response response;
    late UrineModel urineModel;
    try {
      response = await _createDio().post(API_URINE_INSERT, data: data);

      if (response.statusCode == 200) {
        urineModel = UrineModel.fromJson(RestResponseOnlyStatus.fromJson(response.data));
        return urineModel;
      }
      else {
        mLog.e('SaveResult  statusCode : ${response.statusCode.toString()}');
        mLog.e('SaveResult  statusMessage : ${response.statusMessage.toString()}');

        if (response.statusCode == 500)
          throw Exception(MESSAGE_ERROR_RESPONSE);
        else
          throw Exception(MESSAGE_ERROR_CONNECT_SERVER);
      }
    } on DioError catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  /// 유저 이름 가져오기
  Future<String> dioUserName() async {
    try {
      mLog.i('token: ${Authorization().token}');
      mLog.i('userID: ${Authorization().userID}');
      Response response = await _createDio().get(API_GET_INFO, queryParameters: {'userID': Authorization().userID});

      if (response.statusCode == 200) {
        if (response.data['status']['code'] == '200') {
          return response.data['data']['name'];
        }
        else { // 그 외 error code
          print(' >>> [List Error Code & Message]: ${response.data['status']['code']} /  ${response.data['status']['message']}');
          throw Exception(MESSAGE_ERROR_RESPONSE);
        }
      }
      else {
        print(' >>> [Response statusCode] : ' + response.statusCode.toString());
        print(' >>> [Response statusMessage] : ' + response.statusMessage.toString());

        if (response.statusCode == 500)
          throw Exception(MESSAGE_ERROR_RESPONSE);
        else
          throw Exception(MESSAGE_ERROR_CONNECT_SERVER);
      }
    } on DioError catch (error) {
      throw Exception(error);
    }
    catch (error) {
      throw Exception(error);
    }
  }

  /// 최근 검사 결과 dio
  Future<List<Recent>> dioRecent(String datetime) async {
    List<Recent> recentList = [];
    mLog.d(datetime);
    try {
      Response response = await _createDio().get(datetime == '' ? API_RESULT_RECENT : API_RESULT,
          queryParameters: {'userID': Authorization().userID, 'datetime': datetime});

      if (response.statusCode == 200) {
        if (response.data['status']['code'] == '200') {
          recentList = Recent.parse(RestResponseDataList.fromJson(response.data));
          return recentList;
        }
        else { // 그 외 error code
          print(' >>> [List Error Code & Message]: ${response.data['status']['code']} /  ${response.data['status']['message']}');
          throw Exception(MESSAGE_ERROR_RESPONSE);
        }
      }
      else {
        print(' >>> [Response statusCode] : ' + response.statusCode.toString());
        print(' >>> [Response statusMessage] : ' + response.statusMessage.toString());

        if (response.statusCode == 500)
          throw Exception(MESSAGE_ERROR_RESPONSE);
        else
          throw Exception(MESSAGE_ERROR_CONNECT_SERVER);
      }
    } on DioError catch (error) {
      throw Exception(error);
    }
    catch (error) {
      throw Exception(error);
    }
  }


  /// 최근 검사 결과 dio
  Future<List<ResultList>> dioResultList(int pageIndex, String searchStartDate, String searchEndDate) async {
    List<ResultList> resultList = [];

    try {
      Response response = await _createDio().get(API_RESULT_LIST,
          queryParameters: {'userID': 'sim3383', 'page': pageIndex, 'searchStartDate': searchStartDate, 'searchEndDate': searchEndDate});

      if (response.statusCode == 200) {
        if (response.data['status']['code'] == '200') {
          resultList = ResultList.parse(RestResponseDataList.fromJson(response.data));
          return resultList;
        }
        else { // 그 외 error code
          if(response.data['status']['code'] == 'ERR_MS_4003'){
            throw Exception(MESSAGE_NO_RESULT_DATA);
          }
          else {
            print(' >>> [List Error Code & Message]: ${response.data['status']['code']} /  ${response.data['status']['message']}');
            throw Exception(MESSAGE_ERROR_RESPONSE);
          }
        }
      }
      else {
        print(' >>> [Response statusCode] : ' + response.statusCode.toString());
        print(' >>> [Response statusMessage] : ' + response.statusMessage.toString());

        if (response.statusCode == 500)
          throw Exception(MESSAGE_ERROR_RESPONSE);
        else
          throw Exception(MESSAGE_ERROR_CONNECT_SERVER);
      }
    } on DioError catch (error) {
      throw Exception(error);
    }
    catch (error) {
      throw Exception(error);
    }
  }

  /// 차트 데이터 dio
  Future<List<Recent>> dioChartData(String searchStartDate, String searchEndDate) async {
    List<Recent> recentList = [];
    mLog.d('$searchStartDate $searchEndDate');
    try {
      Response response = await _createDio().get(API_CHART_DATA,
          queryParameters: {'userID': 'sim3383', 'searchStartDate': searchStartDate, 'searchEndDate': searchEndDate});

      if (response.statusCode == 200) {
        if (response.data['status']['code'] == '200') {
          recentList = Recent.parse(RestResponseDataList.fromJson(response.data));
          return recentList;
        }
        else { // 그 외 error code
          print(' >>> [List Error Code & Message]: ${response.data['status']['code']} /  ${response.data['status']['message']}');
          return recentList;
          //throw Exception(MESSAGE_ERROR_RESPONSE);
        }
      }
      else {
        print(' >>> [Response statusCode] : ' + response.statusCode.toString());
        print(' >>> [Response statusMessage] : ' + response.statusMessage.toString());

        if (response.statusCode == 500)
          throw Exception(MESSAGE_ERROR_RESPONSE);
        else
          throw Exception(MESSAGE_ERROR_CONNECT_SERVER);
      }
    } on DioError catch (error) {
      throw Exception(error);
    }
    catch (error) {
      throw Exception(error);
    }
  }


  /// 건강 얘찰 dio
  Future<PredictionModel> dioPrediction(String dataType) async {
    PredictionModel predictionModel;
    try {
      Response response = await _createDio().get(API_PERDICTION,
          queryParameters: {'dataType': dataType});

      if (response.statusCode == 200) {
        if (response.data['status']['code'] == '200') {
          predictionModel = PredictionModel.fromJson(RestResponseDataMap.fromJson(response.data));
          return predictionModel;
        }
        else { // 그 외 error code
          print(' >>> [Error Code & Message]: ${response.data['status']['code']} /  ${response.data['status']['message']}');
          //return predictionModel;
          throw Exception(MESSAGE_ERROR_RESPONSE);
        }
      }
      else {
        print(' >>> [Response statusCode] : ' + response.statusCode.toString());
        print(' >>> [Response statusMessage] : ' + response.statusMessage.toString());

        if (response.statusCode == 500)
          throw Exception(MESSAGE_ERROR_RESPONSE);
        else
          throw Exception(MESSAGE_ERROR_CONNECT_SERVER);
      }
    } on DioError catch (error) {
      throw Exception(error);
    }
    catch (error) {
      throw Exception(error);
    }
  }


  //
  // /// 사용자 정보 가져오기
  // Future<UserModel?> dioUserInfo(String userID) async
  // {
  //   UserModel userModel;
  //
  //   try {
  //     Response response = await _createDio().get(
  //         API_URL_PRIVATE_USER, queryParameters: {'userID': userID});
  //
  //     if (response.statusCode == 200) {
  //       if (response.data['status']['code'] == '200') {
  //         userModel =
  //             UserModel.fromJson(RestResponseDefault.fromJson(response.data));
  //         return userModel;
  //       }
  //       else { // 그 외 error code
  //         print(' >>> [PTSD List Error Code & Message] :  '
  //             '${response.data['status']['code']} /  ${response
  //             .data['status']['message']}');
  //       }
  //     }
  //     else {
  //       print(' >>> [PTSD Response statusCode] : ' +
  //           response.statusCode.toString());
  //       print(' >>> [PTSD Response statusMessage] : ' +
  //           response.statusMessage.toString());
  //
  //       if (response.statusCode == 500)
  //         throw Exception(MESSAGE_SERVER_ERROR_DEFAULT);
  //       else
  //         throw Exception(MESSAGE_ERROR_CONNECT_SERVER);
  //     }
  //   } on DioError catch (e) {
  //     print(e.toString());
  //     throw Exception(MESSAGE_ERROR_CONNECT_SERVER);
  //   } catch (e) {
  //     print(e.toString());
  //   }
  //   return null;
  // }
  //
  //
  // /// 개인정보 수정 dio
  // Future<DefaultOnlyStatus> dioEditInfo(Map<String, dynamic> data) async
  // {
  //   late DefaultOnlyStatus defaultOnlyStatus;
  //   late Response response;
  //   try {
  //     response = await _createDio().put(API_URL_PRIVATE_USER, data: data);
  //
  //     if (response.statusCode == 200) {
  //       defaultOnlyStatus = DefaultOnlyStatus.fromJson(
  //           RestResponseOnlyStatus.fromJson(response.data));
  //
  //       if (defaultOnlyStatus.code == '200') {
  //         return defaultOnlyStatus;
  //       }
  //       else { // 그 외 error code
  //         mLog.e('EditInfo Response Code & Message : ${defaultOnlyStatus
  //             .code} / ${defaultOnlyStatus.message}');
  //       }
  //     }
  //     else {
  //       mLog.e('Sign statusCode : ${response.statusCode.toString()}');
  //       mLog.e('Sign statusMessage : ${response.statusMessage.toString()}');
  //
  //       if (response.statusCode == 500)
  //         throw Exception(MESSAGE_SERVER_ERROR_DEFAULT);
  //       else
  //         throw Exception(MESSAGE_ERROR_CONNECT_SERVER);
  //     }
  //   } on DioError catch (e) {
  //     print(e.toString());
  //     throw Exception(MESSAGE_ERROR_CONNECT_SERVER);
  //   } catch (e) {
  //     print(e.toString());
  //   }
  //
  //   return DefaultOnlyStatus(
  //       code: defaultOnlyStatus.code, message: defaultOnlyStatus.message);
  // }
  //
  //
  // /// 비밀번호 변경 dio
  // Future<DefaultOnlyStatus> dioEditPwd(Map<String, dynamic> data) async
  // {
  //   late DefaultOnlyStatus defaultOnlyStatus;
  //   late Response response;
  //   try {
  //     response = await _createDio().put(API_URL_UPDATE_PWD, data: data);
  //
  //     if (response.statusCode == 200) {
  //       defaultOnlyStatus = DefaultOnlyStatus.fromJson(
  //           RestResponseOnlyStatus.fromJson(response.data));
  //
  //       if (defaultOnlyStatus.code == '200') {
  //         return defaultOnlyStatus;
  //       }
  //       else { // 그 외 error code
  //         mLog.e('EditInfo Response Code & Message : ${defaultOnlyStatus
  //             .code} / ${defaultOnlyStatus.message}');
  //       }
  //     }
  //     else {
  //       mLog.e('Sign statusCode : ${response.statusCode.toString()}');
  //       mLog.e('Sign statusMessage : ${response.statusMessage.toString()}');
  //
  //       if (response.statusCode == 500)
  //         throw Exception(MESSAGE_SERVER_ERROR_DEFAULT);
  //       else
  //         throw Exception(MESSAGE_ERROR_CONNECT_SERVER);
  //     }
  //   } on DioError catch (e) {
  //     print(e.toString());
  //     throw Exception(MESSAGE_ERROR_CONNECT_SERVER);
  //   } catch (e) {
  //     print(e.toString());
  //   }
  //
  //   return DefaultOnlyStatus(
  //       code: defaultOnlyStatus.code, message: defaultOnlyStatus.message);
  // }
  //
  //
  // /// 유저 탈퇴 dio
  // Future<DefaultOnlyStatus> dioUserDelete(Map<String, dynamic> data) async
  // {
  //   late DefaultOnlyStatus defaultOnlyStatus;
  //   late Response response;
  //   try {
  //     response = await _createDio().delete(API_URL_PRIVATE_USER, data: data);
  //
  //     if (response.statusCode == 200) {
  //       defaultOnlyStatus = DefaultOnlyStatus.fromJson(
  //           RestResponseOnlyStatus.fromJson(response.data));
  //
  //       if (defaultOnlyStatus.code == '200') {
  //         return defaultOnlyStatus;
  //       }
  //       else { // 그 외 error code
  //         mLog.e('EditInfo Response Code & Message : ${defaultOnlyStatus
  //             .code} / ${defaultOnlyStatus.message}');
  //       }
  //     }
  //     else {
  //       mLog.e('Sign statusCode : ${response.statusCode.toString()}');
  //       mLog.e('Sign statusMessage : ${response.statusMessage.toString()}');
  //
  //       if (response.statusCode == 500)
  //         throw Exception(MESSAGE_SERVER_ERROR_DEFAULT);
  //       else
  //         throw Exception(MESSAGE_ERROR_CONNECT_SERVER);
  //     }
  //   } on DioError catch (e) {
  //     print(e.toString());
  //     throw Exception(MESSAGE_ERROR_CONNECT_SERVER);
  //   } catch (e) {
  //     print(e.toString());
  //   }
  //
  //   return DefaultOnlyStatus(
  //       code: defaultOnlyStatus.code, message: defaultOnlyStatus.message);
  // }
  //
  // /// 리질리언스 검사 dio
  // Future<String?> dioResilience(Map<String, dynamic> data) async
  // {
  //   Etc.getValuesFromMap(data);
  //
  //   late Response response;
  //   try {
  //     response = await _createDio().post(API_URL_RESILIENCE, data: data);
  //
  //     String responseCode = response.data['status']['code'];
  //     String? responseMessage = response.data['status']['message'];
  //
  //     if (response.statusCode == 200) {
  //       if (responseCode == '200') {
  //         return responseMessage; // Success
  //       }
  //       else if (responseCode == '-1') {
  //         return responseMessage; // error
  //       }
  //       else { // 그 외 error code
  //         mLog.e('Resilience Response Code & Message : ${responseCode} / ${responseMessage}');
  //         return responseMessage; // error
  //       }
  //     }
  //     else {
  //       mLog.e('Login  statusCode : ${response.statusCode.toString()}');
  //       mLog.e('Login  statusMessage : ${response.statusMessage.toString()}');
  //
  //       if (response.statusCode == 500)
  //         throw Exception(MESSAGE_SERVER_ERROR_DEFAULT);
  //       else
  //         throw Exception(MESSAGE_ERROR_CONNECT_SERVER);
  //     }
  //   } on DioError catch (e) {
  //     print(e.toString());
  //     throw Exception(MESSAGE_ERROR_CONNECT_SERVER);
  //   } catch (e) {
  //     print(e.toString());
  //   }
  //
  //   return 'UnknownError';
  // }
  //
  //
  // /// 번 아웃 스크리닝 dio
  // Future<DefaultOnlyStatus> dioBurnout(Map<String, dynamic> data) async
  // {
  //   late DefaultOnlyStatus defaultOnlyStatus;
  //   late Response response;
  //   try {
  //     response = await _createDio().put(API_URL_UPDATE_BURNOUT, data: data);
  //
  //     if (response.statusCode == 200) {
  //       defaultOnlyStatus = DefaultOnlyStatus.fromJson(
  //           RestResponseOnlyStatus.fromJson(response.data));
  //
  //       if (defaultOnlyStatus.code == '200') {
  //         return defaultOnlyStatus;
  //       }
  //       else { // 그 외 error code
  //         mLog.e('EditInfo Response Code & Message : ${defaultOnlyStatus
  //             .code} / ${defaultOnlyStatus.message}');
  //       }
  //     }
  //     else {
  //       mLog.e('Sign statusCode : ${response.statusCode.toString()}');
  //       mLog.e('Sign statusMessage : ${response.statusMessage.toString()}');
  //
  //       if (response.statusCode == 500)
  //         throw Exception(MESSAGE_SERVER_ERROR_DEFAULT);
  //       else
  //         throw Exception(MESSAGE_ERROR_CONNECT_SERVER);
  //     }
  //   } on DioError catch (e) {
  //     print(e.toString());
  //     throw Exception(MESSAGE_ERROR_CONNECT_SERVER);
  //   } catch (e) {
  //     print(e.toString());
  //   }
  //
  //   return DefaultOnlyStatus(
  //       code: defaultOnlyStatus.code, message: defaultOnlyStatus.message);
  // }
  //
  //
  // /// 번 아웃 스크리닝 결과값 반환[1~3] dio
  // Future<DefaultOnlyStatus> dioResultBurnout(Map<String, dynamic> data) async
  // {
  //   Etc.getValuesFromMap(data);
  //
  //   late DefaultOnlyStatus defaultOnlyStatus;
  //   late Response response;
  //   try {
  //     response = await _createDio().put(API_URL_UPDATE_RESULT_BURNOUT, data: data);
  //
  //     if (response.statusCode == 200) {
  //       defaultOnlyStatus = DefaultOnlyStatus.fromJson(
  //           RestResponseOnlyStatus.fromJson(response.data));
  //
  //       if (defaultOnlyStatus.code == '200') {
  //         return defaultOnlyStatus;
  //       }
  //       else { // 그 외 error code
  //         mLog.e('EditInfo Response Code & Message : ${defaultOnlyStatus
  //             .code} / ${defaultOnlyStatus.message}');
  //       }
  //     }
  //     else {
  //       mLog.e('Sign statusCode : ${response.statusCode.toString()}');
  //       mLog.e('Sign statusMessage : ${response.statusMessage.toString()}');
  //
  //       if (response.statusCode == 500)
  //         throw Exception(MESSAGE_SERVER_ERROR_DEFAULT);
  //       else
  //         throw Exception(MESSAGE_ERROR_CONNECT_SERVER);
  //     }
  //   } on DioError catch (e) {
  //     print(e.toString());
  //     throw Exception(MESSAGE_ERROR_CONNECT_SERVER);
  //   } catch (e) {
  //     print(e.toString());
  //   }
  //
  //   return DefaultOnlyStatus(
  //       code: defaultOnlyStatus.code, message: defaultOnlyStatus.message);
  // }
  //
  // /// 상담 완료 갯수 가져오기 dio
  // Future<String> dioCompleteCnt() async
  // {
  //   String completeCnt = '';
  //   try {
  //     Response response = await _createDio().get(API_URL_COMPLETECNT_GET, queryParameters: {'userID': Authorization().userID});
  //
  //     if (response.statusCode == 200) {
  //       if (response.data['status']['code'] == '200') {
  //         return response.data['data']['completeCnt'];
  //       }
  //       else { // 그 외 error code
  //         print(' >>> [dioCompleteCnt Error Code & Message]: ${response
  //             .data['status']['code']} /  ${response
  //             .data['status']['message']}');
  //       }
  //     }
  //     else {
  //       print(' >>> [Response statusCode] : ' + response.statusCode.toString());
  //       print(' >>> [Response statusMessage] : ' +
  //           response.statusMessage.toString());
  //
  //       if (response.statusCode == 500)
  //         throw Exception(MESSAGE_SERVER_ERROR_DEFAULT);
  //       else
  //         throw Exception(MESSAGE_ERROR_CONNECT_SERVER);
  //     }
  //   } on DioError catch (e) {
  //     throw Exception(MESSAGE_ERROR_CONNECT_SERVER);
  //   }
  //   catch (e) {
  //     print(e.toString());
  //   }
  //   return completeCnt;
  // }
  //
  //
  // /// 만족도 검사 dio
  // Future<String?> dioSatisfaction(Map<String, dynamic> data) async
  // {
  //   Etc.getValuesFromMap(data);
  //
  //   late Response response;
  //   try {
  //     response = await _createDio().post(API_URL_SATISFACTION, data: data);
  //
  //     String responseCode = response.data['status']['code'];
  //     String? responseMessage = response.data['status']['message'];
  //
  //     if (response.statusCode == 200) {
  //       if (responseCode == '200') {
  //         return responseMessage; // Success
  //       }
  //       else if (responseCode == '-1') {
  //         return responseMessage; // error
  //       }
  //       else { // 그 외 error code
  //         mLog.e('Login Response Code & Message : ${responseCode} / ${responseMessage}');
  //         return responseMessage; // error
  //       }
  //     }
  //     else {
  //       mLog.e('Login  statusCode : ${response.statusCode.toString()}');
  //       mLog.e('Login  statusMessage : ${response.statusMessage.toString()}');
  //
  //       if (response.statusCode == 500)
  //         throw Exception(MESSAGE_SERVER_ERROR_DEFAULT);
  //       else
  //         throw Exception(MESSAGE_ERROR_CONNECT_SERVER);
  //     }
  //   } on DioError catch (e) {
  //     print(e.toString());
  //     throw Exception(MESSAGE_ERROR_CONNECT_SERVER);
  //   } catch (e) {
  //     print(e.toString());
  //   }
  //
  //   return 'UnknownError';
  // }
  //
}