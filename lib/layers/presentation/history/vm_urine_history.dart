
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../common/util/dio/dio_exceptions.dart';
import '../../../../main.dart';
import '../../domain/usecase/urine/history_usecase.dart';
import '../../domain/usecase/urine/urine_result_usecase.dart';
import '../../entity/history_dto.dart';
import '../../entity/urine_result_dto.dart';
import '../../model/vo_history.dart';

class HistoryViewModel extends ChangeNotifier {

  // future handler parameters
  bool _isLoading = true;
  bool _isError = false;
  String _errorMessage = '';

  // future handler parameters getter
  bool get isLoading => _isLoading;
  bool get isError => _isError;
  String get errorMessage => _errorMessage;

  HistoryViewModel() {
    addScrollListener();
    getHistoryDio();
  }

  /// 전체 히스토리 스크롤 컨트롤러
  final _scrollController = ScrollController();

  /// 서버에서 가져온 과거 검사 데이터 리스트
  List<HistoryDataDTO> _historyList = [];

  /// 페이지 인덱스
  int _page = 1;

  List<HistoryDataDTO> get historyList => _historyList;
  ScrollController get scrollController => _scrollController;


  /// 검사결과 히스토리 조회
  Future<void> getHistoryDio() async {
    var history = History(page: _page, searchStartDate: '', searchEndDate: '');

    try {
      HistoryDTO? historyDTO = await HistoryCase().execute(history);
      if (historyDTO?.status.code == '200') {
        if (_historyList.isEmpty) {
          _historyList = historyDTO?.data ?? [];
        } else {
          _historyList.addAll(historyDTO?.data ?? []);
        }
      } else {
        _historyList = [];
      }

      _isLoading = false;
      notifyListeners();
    } on DioException catch (e) {
      final msg = DioExceptions.fromDioError(e).toString();
      notifyError(msg);
    } catch (e) {
      logger.e(e.toString());
      const msg = '죄송합니다.\n예기치 않은 문제가 발생했습니다.';
      notifyError(msg);
    }
  }


  /// 특정날짜의 상세 검사 결과 데이터 조회
  /// 검사 히스토리에서 클릭시 해당 검사 상세내역을 볼수 있게 조회
  /// dateTime: 사용자가 보기 원하는 검사 날짜
  Future<List<String>> getUrineResultDio(String dateTime) async {
    try {
      UrineResultDTO? urineResultDTO = await UrineResultCase().execute(dateTime);

      if (urineResultDTO?.status.code == '200') {
          List<String> statusList = urineResultDTO!.data!
              .map((value) => value.status).toList();
          return statusList;
      } else {
        return [];
      }
    } on DioException catch (e) {
      print(DioExceptions.fromDioError(e).toString());
      return [];
    } catch (e) {
      print(e.toString());
      return [];
    }
  }


  /// 스크롤 이벤트 등록
  /// 히스토리 전체보기에서 스크롤시 하단에 근접하면
  /// 다음 페이지 데이터를 불러온다.
  addScrollListener() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >
          _scrollController.position.maxScrollExtent - 100) {
        if (_historyList.length % 10 == 0) {
          ++_page;
          getHistoryDio();
        }
      }
    });
  }

  /// 에러 처리
  notifyError(String message){
    _isLoading = false;
    _errorMessage = message;
    _isError = true;
    notifyListeners();
  }
}
