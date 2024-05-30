import 'package:flutter/material.dart';
import 'package:urine/common/common.dart';

/// 히스토리 탭바 (최근, 전체)
class TopTabBar extends StatelessWidget {
  final TabController tabController;

  const TopTabBar({
    super.key,
    required this.tabController,
  });

  String get recentText => '최근';
  String get allText => '전체';
  double get tabBarHeight => 45;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: tabBarHeight,
      decoration: BoxDecoration(
        color: AppColors.brightGrey,
        borderRadius: BorderRadius.all(AppConstants.radius),
      ),
      child: TabBar(
        controller: tabController,
        // give the indicator a decoration (color and border radius)
        indicator: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.all(AppConstants.radius),
        ),
        labelColor: AppColors.whiteTextColor,
        unselectedLabelColor: AppColors.blackTextColor,
        tabs: [
          Tab(
            text: recentText,
          ),

          Tab(
            text: allText,
          ),
        ],
      ),
    );
  }
}
