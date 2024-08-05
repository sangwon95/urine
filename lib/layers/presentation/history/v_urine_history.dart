
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:urine/common/constant/app_dimensions.dart';
import 'package:urine/layers/presentation/history/vm_urine_history.dart';
import 'package:urine/layers/presentation/history/w_top_tabbar.dart';
import 'package:urine/layers/presentation/widget/scaffold/frame_scaffold.dart';
import '../widget/w_future_handler.dart';
import 'f_ recent_list.dart';
import 'f_all_list.dart';


/// 검사 내역 화면
/// (최근 5개, 전체 검사) 기록을 확인 할 수 있다.
class UrineHistoryView extends StatefulWidget {
  const UrineHistoryView({super.key});

  @override
  State<UrineHistoryView> createState() => _UrineHistoryViewViewState();
}

class _UrineHistoryViewViewState extends State<UrineHistoryView> with TickerProviderStateMixin{

  late final TabController tabController;

  String get title => '검사내역';
  int get tabItemCount => 2;

  @override
  void initState() {
   tabController = TabController(length: tabItemCount, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => HistoryViewModel(),
      child: FrameScaffold(
        appBarTitle: title,
        body: Consumer<HistoryViewModel>(
          builder: (context, provider, child) {
            return FutureHandler(
              isLoading: provider.isLoading,
              isError: provider.isError,
              errorMessage: provider.errorMessage,
              onRetry: () {  },
              child: Padding(
                padding: const EdgeInsets.only(bottom: AppDim.medium),
                child: Column(
                  children: [

                    /// 상단 탭바 (최근 5개, 전체)
                    const Gap(AppDim.medium),
                    TopTabBar(tabController: tabController),

                    /// 히스토리
                    Expanded(
                        child: Consumer<HistoryViewModel>(
                          builder: (context, provider, child) {
                            return TabBarView(
                              controller: tabController,
                              children:  [
                                /// 최근 5개
                                RecentListFragment(historyList: provider.historyList),

                                /// 전체 리스트
                                AllListFragment(
                                  allScrollController: provider.scrollController,
                                  historyList: provider.historyList,
                                ),
                              ],
                            );
                          },
                        )
                    ),
                    const Gap(AppDim.medium),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
