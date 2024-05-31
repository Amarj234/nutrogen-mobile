import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/ui/module/challenges/monthly_challenge_page.dart';
import 'package:nutrogen/ui/module/challenges/widget/task_tab.dart';
import 'package:nutrogen/ui/module/logFood/log_food_page.dart';
import 'package:nutrogen/utils/helper.dart';

class TasksPage extends HookConsumerWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final widgetList = [
      const TaskTab(
        buttontxt: 'Daily Task',
      ),
      const TaskTab(
        buttontxt: 'Weekly challenge',
        isshowActive: true,
        isshowpoint: true,
      ),
      const MonthlyChallengePage(
        buttontxt: 'Monthly Tasks',
        isshowActive: true,
        isshowpoint: true,
      ),
    ];

    final labelList = [
      loc.daily,
      loc.weekly,
      loc.monthly,
    ];
    final tabController = useTabController(initialLength: 3);
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: ScreenUtil().statusBarHeight,
            color: AppColors.white,
          ),
          Expanded(
            child: NestedScrollView(
              physics: const NeverScrollableScrollPhysics(),
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  floating: false,
                  pinned: false,
                  automaticallyImplyLeading: false,
                  toolbarHeight: 42.h,
                  backgroundColor: AppColors.white,
                  flexibleSpace: Column(
                    children: [
                      10.verticalSpace,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                width: 37.w,
                                height: 37.w,
                                padding: EdgeInsets.all(6.w),
                                decoration: const BoxDecoration(
                                  color: AppColors.cultured,
                                  shape: BoxShape.circle,
                                ),
                                child: SvgPicture.asset(AppAssets.svgBackArrow),
                              ),
                            ),
                            10.horizontalSpace,
                            Text(
                              loc.tasks,
                              style: theme.primaryTextTheme.bodyLarge
                                  ?.copyWith(color: Colors.black),
                            ),
                            Container(
                              width: 100,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: SliverAppBarDelegate(
                    minHeight: 55.h,
                    maxHeight: 0.h,
                    child: Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.zero,
                          color: AppColors.white,
                          child: TabBar(
                            tabAlignment: TabAlignment.center,
                            automaticIndicatorColorAdjustment: true,
                            padding: EdgeInsets.zero,
                            controller: tabController,
                            unselectedLabelStyle: theme.textTheme.bodyMedium
                                ?.copyWith(color: AppColors.darkSilver),
                            labelStyle: theme.textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                            isScrollable: true, // Required
                            unselectedLabelColor:
                                AppColors.darkSilver, // Other tabs color
                            labelPadding: const EdgeInsets.symmetric(
                              horizontal: 40,
                            ), // Space between tabs
                            indicator: UnderlineTabIndicator(
                              borderRadius: BorderRadius.circular(40),
                              borderSide: const BorderSide(
                                color: AppColors.darkMidnightBlue,
                                width: 7,
                              ), // Indicator height
                              // Indicator width
                            ),
                            tabs: [
                              for (int i = 0; i < labelList.length; i++) ...[
                                Tab(
                                  text: labelList[i],
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              body: TabBarView(
                controller: tabController,
                children: widgetList,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
