

class BLECommunicationManager {

  // GATT UUID (DA14580)
  static const String oldGattServiceUuid      = '0783b03e-8535-b5a0-7140-a304d2495cb7';
  static const String oldGattNotificationUuid = '0783b03e-8535-b5a0-7140-a304d2495cb8';
  static const String oldGattWriteUuid        = '0783b03e-8535-b5a0-7140-a304d2495cba';

  // GATT UUID (ESP32-S3)
  static const String gattServiceUuid      = '6e400001-b5a3-f393-e0a9-e50e24dcca9e';
  static const String gattNotificationUuid = '6e400003-b5a3-f393-e0a9-e50e24dcca9e';
  static const String gattWriteUuid        = '6e400002-b5a3-f393-e0a9-e50e24dcca9e';

  // withoutResponse: (true: 구 검사기, false 신규 검사기)
  static const bool withoutResponse = true;

  // bluetooth write 명령어
  static const String commandTs = '2554530a';

  // bluetooth device name keywords
  static const List<String> withKeywords = ['PhotoMT', 'YOCHECK', 'OptoSta'];
}