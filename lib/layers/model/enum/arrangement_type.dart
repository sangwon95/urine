import '../../../common/constant/constants.dart';

enum ArrangementType {
  bluetooth(
    '블루투스 ON',
    '블루투스 OFF',
    '${Texts.imagePath}/urine/arrangement/bluetooth_icon.png',
    '블루투스를 활성화\n해주세요.',
  ),
  device(
    '검사기 ON',
    '검사기 OFF',
    '${Texts.imagePath}/urine/arrangement/power_icon.png',
    '검사기가 켜져 있는지\n확인 해주세요.',
  );

  const ArrangementType(
      this.stateOn,
      this.stateOff,
      this.image,
      this.recommend,
      );

  final String stateOn;
  final String stateOff;
  final String image;
  final String recommend;
}