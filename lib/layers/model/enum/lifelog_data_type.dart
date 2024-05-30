enum LifeLogDataType {
  eye('d008','시력', 0.43), //시력
  bloodPressure('d013', '혈압',  0.5), //혈압
  bloodSugar('d011', '혈당',  0.35), //혈당
  heightWeight('d001','키,몸무게',  0.55), //키 몸무게
  bodyComposition('d007', '체성분',  0.8), //체성분
  brains('d016', '두뇌',  0.8), //두뇌
  dementia('d017', '치매',  0.4), //치매
  brainWaves('d018', '뇌파',  0.5), //뇌파
  pee('d012', '소변',  0.8), //소변
  boneDensity('d014', '골밀도',  0.7); //골밀도

  const LifeLogDataType(this.id, this.name, this.ratio);

  final String id;
  final String name; //
  final double ratio; // bottom sheet 높이 비율
}