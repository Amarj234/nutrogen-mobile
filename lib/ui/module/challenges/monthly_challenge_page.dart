import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/ui/module/aiGenerateMealPlan/widget/details_widget.dart';
import 'package:nutrogen/ui/module/challenges/widget/task_tab.dart';
import 'package:nutrogen/utils/helper.dart';

class MonthlyChallengePage extends HookConsumerWidget {
  const MonthlyChallengePage({
    required this.buttontxt,
    super.key,
    this.isshowpoint = false,
    this.isshowActive = false,
  });

  final bool isshowpoint;
  final bool isshowActive;
  final String buttontxt;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController = useTabController(initialLength: 2);
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(),
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            color: AppColors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                20.verticalSpace,
                Container(
                  padding: EdgeInsets.all(5.w),
                  decoration: BoxDecoration(
                    color: AppColors.antiFlashWhite,
                    borderRadius: BorderRadius.circular(50.r),
                  ),
                  child: TabBar(
                    controller: tabController,
                    dividerHeight: 0,
                    labelStyle: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontFamily: AppAssets.fontPlusJakartaSans,
                    ),
                    unselectedLabelStyle: theme.textTheme.titleSmall?.copyWith(
                      fontFamily: AppAssets.fontPlusJakartaSans,
                    ),
                    unselectedLabelColor: AppColors.darkSilver,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelPadding: EdgeInsets.symmetric(vertical: 12.h),
                    indicator: BoxDecoration(
                      color: AppColors.brightGray,
                      borderRadius: BorderRadius.circular(50.r),
                    ), //Change background color from here
                    tabs: [
                      Text(loc.yourChallenges),
                      Text(loc.teamChallenges),
                    ],
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(color: AppColors.white),
                  height: 10,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height - 220,
          child: TabBarView(
            controller: tabController,
            children: const [
              DetailsWidget(),
              TaskTab(
                buttontxt: 'Weekly challenge',
                isshowActive: true,
                isshowpoint: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
