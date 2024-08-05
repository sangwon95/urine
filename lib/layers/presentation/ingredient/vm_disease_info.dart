
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:urine/layers/presentation/ingredient/v_disease_info.dart';

import '../../../main.dart';

class DiseaseInfoViewModel extends ChangeNotifier {

  DiseaseInfoViewModel() {
    initDiseaseInfo();
  }

  // future handler parameters
  bool _isLoading = true;
  bool _isError = false;
  String _errorMessage = '';

  List<ExpandedItem> _diseaseInfoItems = [];

  // future handler parameters getter
  bool get isLoading => _isLoading;
  bool get isError => _isError;
  String get errorMessage => _errorMessage;

  List<ExpandedItem> get diseaseInfoItems => _diseaseInfoItems;

  Future<void> initDiseaseInfo() async {
    try {
      final response = await rootBundle.loadString('assets/json/disease_info.json');

      final List<dynamic> data = json.decode(response);
      List<Map<String, String>>? diseaseInfoList = data
          .map((item) => {
        'title': item['title'].toString(),
        'description': item['description'].toString(),
      }).toList();

      _isLoading = false;
      _diseaseInfoItems = generateItems(diseaseInfoList.length, diseaseInfoList);
      notifyListeners();
    } catch (e) {
      logger.e(e.toString());
      const msg = '죄송합니다.\n예기치 않은 문제가 발생했습니다.';
      notifyError(msg);
    }
  }

  List<ExpandedItem> generateItems(int numberOfItems, List<Map<String, String>>? diseaseInfoList) {
    return List<ExpandedItem>.generate(numberOfItems, (int index) {
      return ExpandedItem(
        headerValue: diseaseInfoList?[index]['title']?? '-',
        expandedValue: diseaseInfoList?[index]['description']?? '-',
      );
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