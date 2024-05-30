enum BluetoothStatus {
  scan('검사기를 찾고 있습니다.\n잠시만 기다려 주세요.'),
  connect('연결 중입니다.\n잠시만 기다려 주세요.'),
  inspection('검사진행 중입니다.\n잠시만 기다려 주세요.'),
  scanError('검사기를 찾지 못했습니다.\n검사기가 켜져있는지 확인해주세요.'),
  connectError('검사기와 연결되지 않았습니다.\n재 연결 시도해주세요.'),
  unableError('검사진행 할 수 없는 검사기입니다.\n다른 검사기를 사용해주세요.'),
  inspectionError('검사기로부터 응답 받지 못했습니다.\n다시 시도 바랍니다.'),
  stripError('스트립이 비어 있습니다.\n 삽입 후 재검사 버튼을 눌러주세요.'),
  cutoff('검사기와 연결이 끊어졌습니다.\n 재검색이 필요합니다.');

  const BluetoothStatus(this.message);

  final String message;
}