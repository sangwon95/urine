import 'package:urine/layers/model/authorization.dart';

class History {
  final int page;
  final String searchStartDate;
  final String searchEndDate;

  History({
    required this.page,
    required this.searchStartDate,
    required this.searchEndDate,
  });

  Map<String, dynamic> toMap(){
    return {
      'userID': Authorization().userID,
      'page': page,
      'searchStartDate': searchStartDate,
      'searchEndDate': searchEndDate,
    };
  }
}
