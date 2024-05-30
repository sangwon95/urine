enum PhysicalType {
  vision('시력'),
  bloodPressure('혈압'),
  weight('몸무게'),
  height('키'),
  hearingAbility('청력'),
  waistCircumference('허리둘레'),
  bodyMassIndex('체질량지수');

  const PhysicalType(this.label);

  final String label;

  static PhysicalType strToEnum(String str) {
    return PhysicalType.values.firstWhere((e) => e.label == str);
  }
}