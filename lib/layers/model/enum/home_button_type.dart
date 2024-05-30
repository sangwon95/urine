enum HomeButtonType {
  inspection('검사 하기', 'assets/images/urine/home/first_btn.png'),
  history('검사 내역', 'assets/images/urine/home/second_btn.png'),
  ingredient('성분 분석', 'assets/images/urine/home/third_btn.png'),
  transition('나의 추이', 'assets/images/urine/home/fourth_btn.png');

  const HomeButtonType(this.label, this.imagePath);

  final String label;
  final String imagePath;
}