import 'package:urine/common/constant/api_urls.dart';
import 'package:urine/layers/entity/urine_chart_dto.dart';
import 'package:urine/layers/entity/urine_save_dto.dart';
import 'package:urine/layers/entity/user_name_dto.dart';
import 'package:urine/layers/model/vo_history.dart';

import '../../../../common/util/dio/dio_manager.dart';
import '../../../../main.dart';
import '../../../domain/repository/urine_repository.dart';
import '../../../entity/history_dto.dart';
import '../../../entity/urine_result_dto.dart';
import '../../../model/authorization.dart';

class UrineRepositoryImp implements UrineRepository {

  /// 히스토리 조회(최근, 전체)
  @override
  Future<HistoryDTO?> getHistory(History history) async {
    try {
      final response = await DioManager()
          .publicDio
          .get(historyListApiUrl, queryParameters: history.toMap());

      logger.d(response.data);
      if (response.statusCode == 200) {
        final historyDTO = HistoryDTO.fromJson(response.data);
        return historyDTO;
      } else {
        return null;
      }
    } catch (error) {
      rethrow;
    }
  }

  /// 특정날짜 검사 결과 상세
  @override
  Future<UrineResultDTO?> getUrineResult(String dateTime) async {
    try {
      final response = await DioManager()
          .publicDio
          .get(dateTime == '' ? recentResultApiUrl : urineResultApiUrl,
          queryParameters: {'userID': Authorization().userID, 'datetime': dateTime});

      logger.d(response.data);
      if (response.statusCode == 200) {
        return UrineResultDTO.fromJson(response.data);
      } else {
        return null;
      }
    } catch (error) {
      rethrow;
    }
  }

  /// 검사 결과 추이 차트
  @override
  Future<UrineChartDTO?> fetchUrineChart(Map<String, dynamic> searchDateMap) async {
    try {
      final response = await DioManager().publicDio.get(chartApiUrl,
          queryParameters: searchDateMap);

      //logger.d(response.data);
      if (response.statusCode == 200) {
        return UrineChartDTO.fromJson(response.data);
      } else {
        return null;
      }
    } catch (error) {
      rethrow;
    }
  }

  /// 한밭대 ai 성분 분석
  @override
  Future<String?> getAiAnalysis(Map<String, dynamic> toMap) async {
    try {
      final response = await DioManager()
          .publicDio
          .post(aiAnalysisApiUrl, data: toMap);
      if (response.statusCode == 200) {
        return response.data['result'];
      }else {
        return null;
      }
    } catch (error) {
      rethrow;
    }
  }


  /// 소변 검사 결과 데이터 저장
  @override
  Future<UrineSaveDTO?> saveUrine(List<Map<String, dynamic>> toMap) async {
    try {
      final response = await DioManager()
          .publicDio
          .post(saveResultApiUrl, data: toMap);
      logger.d(response.data);
      if (response.statusCode == 200) {
        return UrineSaveDTO.fromJson(response.data);
      } else {
        return null;
      }
    } catch (error) {
      rethrow;
    }
  }


  /// 유저 이름 가져오기
  @override
  Future<UserNameDTO?> getUserName() async {
    try {
      final response = await DioManager()
          .privateDio
          .get(
            getUserNameApiUrl,
            queryParameters: {'userID': Authorization().userID},
      );
      logger.d(response.data);
      if (response.statusCode == 200) {
        return UserNameDTO.fromJson(response.data);
      } else {
        return null;
      }
    } catch (error) {
      rethrow;
    }
  }

}
