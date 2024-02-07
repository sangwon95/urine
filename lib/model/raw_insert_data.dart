
import 'authorization.dart';

class RawInsertData{
  late String userID;
  late String datetime;
  late String dataType;
  late String result;
  late String status;

  RawInsertData(
      this.userID,
      this.datetime,
      this.dataType,
      this.result,
      this.status
      );

  Map<String, dynamic> toMap() {
    Map<String, dynamic> toMap = {
      "userID": userID,
      "datetime": datetime,
      "dataType": dataType,
      "result": result,
      "status": status,
    };
    return toMap;
  }
}