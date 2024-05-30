
import 'dart:typed_data';

import '../../layers/model/vo_urine.dart';

class Etc {

  static List<String> createUrineValuesList(Urine urine) {
    return [
      urine.blood,
      urine.billrubin,
      urine.urobillnogen,
      urine.ketones,
      urine.protein,
      urine.nitrite,
      urine.glucose,
      urine.pH,
      urine.sG,
      urine.leucoytes,
      urine.vitamin,
    ];
  }


  /// Change hex string of [%TS] to byte data
  static Uint8List hexStringToByteArray(String input) {
    String cleanInput = remove0x(input);

    int len = cleanInput.length;

    if (len == 0) {
      return Uint8List(0);
    }
    Uint8List data;
    int startIdx;
    if (len % 2 != 0) {
      data = Uint8List((len ~/ 2) + 1);
      data[0] = digitHex(cleanInput[0]);
      startIdx = 1;
    } else {
      data = Uint8List((len ~/ 2));
      startIdx = 0;
    }

    for (int i = startIdx; i < len; i += 2) {
      data[(i + 1) ~/ 2] =
          (digitHex(cleanInput[i]) << 4) + digitHex(cleanInput[i + 1]);
    }
    return data;
  }

  static remove0x(String hex) => hex.startsWith("0x") ? hex.substring(2) : hex;

  static int digitHex(String hex) {
    int char = hex.codeUnitAt(0);
    if (char >= '0'.codeUnitAt(0) && char <= '9'.codeUnitAt(0) ||
        char >= 'a'.codeUnitAt(0) && char <= 'f'.codeUnitAt(0)) {
      return int.parse(hex, radix: 16);
    } else {
      return -1;
    }
  }
}