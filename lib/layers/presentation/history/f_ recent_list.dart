import 'package:flutter/material.dart';
import 'package:urine/common/common.dart';
import 'package:urine/layers/presentation/history/w_history_list_item.dart';
import 'package:urine/layers/presentation/widget/frame_container.dart';

import '../../entity/history_dto.dart';
import '../widget/w_data_empty.dart';
import '../widget/w_dotted_line.dart';


class RecentListFragment extends StatelessWidget {
  final List<HistoryDataDTO> historyList;

  const RecentListFragment({
    super.key,
    required this.historyList,
  });

  String get emptyText => '검사 이력이 없습니다.';

  int get recentListMaxCount => 5;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppConstants.viewPadding,
      child: FrameContainer(
        backgroundColor: AppColors.greyBoxBg,
        child: historyList.isEmpty
            ? DataEmpty(message: emptyText)
            : ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: historyList.length > recentListMaxCount
                    ? recentListMaxCount
                    : historyList.length,
                itemBuilder: (BuildContext context, int index) =>
                    HistoryListItem(
                  history: historyList[index],
                ),
                separatorBuilder: (BuildContext context, int index) {
                  return const DottedLine(mWidth: double.infinity);
                },
              ),
      ),
    );
  }
}
