import '../../../common/constant/constants.dart';

enum UrineAnalysisType {
  progress('검사진행', '${AppStrings.imagePath}/tab/urine/progress.png'),
  history('검사내역', '${AppStrings.imagePath}/tab/urine/history.png'),
  graph('검사추이', '${AppStrings.imagePath}/tab/urine/graph.png');

  const UrineAnalysisType(this.title, this.image);

  final String title;
  final String image;
}