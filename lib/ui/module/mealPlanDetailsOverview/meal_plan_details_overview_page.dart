import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/data/model/meal_plan_model.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/ui/module/logFood/log_food_page.dart';
import 'package:nutrogen/ui/module/mealPlanDetailsOverview/widget/meal_details_widget.dart';
import 'package:nutrogen/ui/module/mealPlanDetailsOverview/widget/overview_widget.dart';
import 'package:nutrogen/utils/helper.dart';

class MealPlanDetailsPage extends HookConsumerWidget {
  const MealPlanDetailsPage({required this.approveMealListREntity, super.key});
  final MealPlanR? approveMealListREntity;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController = useTabController(initialLength: 2);
    void onClose() {
      context.pop();
    }

    void onShare() {}

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverAppBarDelegate(
              minHeight: 252.h,
              maxHeight: 365.h,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      AppAssets.jpgMealPlanDetailsHeader,
                      fit: BoxFit.fitWidth,
                      height: 250.h,
                      width: 1.sw,
                    ),
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.only(
                      left: 20.w,
                      right: 20.w,
                      bottom: 10.h,
                      top: ScreenUtil().statusBarHeight + 8.h,
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: onClose,
                          padding: EdgeInsets.zero,
                          icon: SvgPicture.asset(AppAssets.svgCloseGray),
                        ),
                        Expanded(
                          child: Text(
                            loc.planDetails,
                            textAlign: TextAlign.center,
                            style:
                                theme.primaryTextTheme.displaySmall?.copyWith(
                              fontFamily: AppAssets.fontPlusJakartaSans,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: onShare,
                          padding: EdgeInsets.zero,
                          icon: SvgPicture.asset(AppAssets.svgShare),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 55.h,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.only(left: 20.w, right: 20.w),
                      decoration: BoxDecoration(
                        color: AppColors.antiFlashWhite,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(35.r),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          40.verticalSpace,
                          Text(
                            approveMealListREntity?.mealPlanName ?? '',
                            style: theme.textTheme.displaySmall?.copyWith(
                              fontWeight: FontWeight.w700,
                              fontFamily: AppAssets.fontPlusJakartaSans,
                            ),
                          ),
                          20.verticalSpace,
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: EdgeInsets.only(left: 20.w, right: 20.w),
                      color: AppColors.antiFlashWhite,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: EdgeInsets.all(5.w),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(50.r),
                            ),
                            child: TabBar(
                              controller: tabController,
                              dividerHeight: 0,
                              labelStyle: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                                fontFamily: AppAssets.fontPlusJakartaSans,
                              ),
                              unselectedLabelStyle:
                                  theme.textTheme.titleSmall?.copyWith(
                                fontFamily: AppAssets.fontPlusJakartaSans,
                              ),
                              unselectedLabelColor: AppColors.darkSilver,
                              indicatorSize: TabBarIndicatorSize.tab,
                              labelPadding:
                                  EdgeInsets.symmetric(vertical: 12.h),
                              indicator: BoxDecoration(
                                color: AppColors.brightGray,
                                borderRadius: BorderRadius.circular(50.r),
                              ), //Change background color from here
                              tabs: [
                                Text(loc.overview),
                                Text(loc.mealsDetails),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        body: TabBarView(
          controller: tabController,
          children: [
            OverviewWidget(
              approveMealListREntity: approveMealListREntity,
            ),
            MealsDetailsWidget(
              mealPlanR: approveMealListREntity,
            ),
          ],
        ),
      ),
    );
  }
}
