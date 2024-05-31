import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/res/app_routers.dart';
import 'package:nutrogen/ui/common/circular_arch_progress_bar_widget.dart';
import 'package:nutrogen/ui/module/dashboard/widget/caloris_widget.dart';
import 'package:nutrogen/ui/module/dashboard/widget/cholestrol_widget.dart';
import 'package:nutrogen/ui/module/dashboard/widget/custom_fire_progress.dart';
import 'package:nutrogen/ui/module/dashboard/widget/discover_widget.dart';
import 'package:nutrogen/ui/module/dashboard/widget/drawer_widget.dart';
import 'package:nutrogen/ui/module/dashboard/widget/filter_widget.dart';
import 'package:nutrogen/ui/module/dashboard/widget/filterdata_widget.dart';
import 'package:nutrogen/ui/module/dashboard/widget/meal_plan_widget.dart';
import 'package:nutrogen/ui/module/home/home_provider.dart';
import 'package:nutrogen/utils/helper.dart';

class DashboardPage extends HookConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ZoomDrawerController zoomDrawerController =
        useMemoized(() => ZoomDrawerController());

    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          zoomDrawerController.stateNotifier?.addListener(() {
            ref.read(bottomNavHideProvider.notifier).state =
                zoomDrawerController.isOpen?.call() == true;
          });
        });

        return null;
      },
      [],
    );

    return Scaffold(
      body: ZoomDrawer(
        controller: zoomDrawerController,
        menuBackgroundColor: AppColors.darkMidnightBlue,
        style: DrawerStyle.defaultStyle,
        menuScreen: DrawerWidget(controller: zoomDrawerController),
        mainScreen: DashboardWidget(controller: zoomDrawerController),
        borderRadius: 20.r,
        showShadow: true,
        angle: 0.0,
        shadowLayer1Color: AppColors.transparent,
        mainScreenTapClose: true,
        menuScreenTapClose: true,
        drawerShadowsBackgroundColor: AppColors.americanSilver,
        slideWidth: MediaQuery.of(context).size.width * .60,
        openCurve: Curves.easeOut,
        closeCurve: Curves.easeIn,
      ),
    );
  }
}

class DashboardWidget extends HookConsumerWidget {
  const DashboardWidget({required this.controller, super.key});

  final ZoomDrawerController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFilter = useState(loc.tasks);

    final titleList = useMemoized(
      () => [loc.recipes, loc.friends, loc.challenges, loc.integrations],
    );
    final svgList = useMemoized(
      () => [
        AppAssets.svgRecipes,
        AppAssets.svgFriends,
        AppAssets.svgChallenges,
        AppAssets.svgIntegrations,
      ],
    );

    void onViewAll() {
      context.pushNamed(AppRouters.nutritionSummary);
    }

    void onMenu() {
      controller.toggle?.call();
    }

    void onSearch() {
      context.pushNamed(AppRouters.search);
    }

    void onBell() {
      context.pushNamed(AppRouters.notification);
    }

    void onViewMacros() {
      context.pushNamed(AppRouters.nutritionSummary);
    }

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: ScreenUtil().statusBarHeight,
            color: AppColors.antiFlashWhite,
          ),
          Expanded(
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  floating: false,
                  pinned: false,
                  toolbarHeight: 40.h,
                  flexibleSpace: Container(
                    alignment: Alignment.bottomCenter,
                    color: AppColors.antiFlashWhite,
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      children: [
                        IconButton.filled(
                          onPressed: onMenu,
                          style: IconButton.styleFrom(
                            fixedSize: Size(58.w, 58.w),
                            backgroundColor: AppColors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                          ),
                          icon: SvgPicture.asset(AppAssets.svgMenu),
                        ),
                        const Spacer(),
                        IconButton.filled(
                          onPressed: onSearch,
                          style: IconButton.styleFrom(
                            fixedSize: Size(58.w, 58.w),
                            backgroundColor: AppColors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                          ),
                          icon: SvgPicture.asset(AppAssets.svgSearch),
                        ),
                        6.horizontalSpace,
                        IconButton.filled(
                          onPressed: onBell,
                          style: IconButton.styleFrom(
                            fixedSize: Size(58.w, 58.w),
                            backgroundColor: AppColors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                          ),
                          icon: SvgPicture.asset(AppAssets.svgBell),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(20.w),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    loc.calories,
                                    style: theme.textTheme.displaySmall,
                                  ),
                                  30.verticalSpace,
                                  Hero(
                                    tag: 'calories_tag',
                                    child: Container(
                                      width: 166.w,
                                      height: 140.w,
                                      padding: EdgeInsets.only(
                                        left: 15.w,
                                      ),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          const CircularArchProgressBarWidget(
                                            value: 75,
                                            fillColor: AppColors.goldenPoppy,
                                            backgroundColor: AppColors.cultured,
                                          ),
                                          Positioned(
                                            top: 45.h,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  '2,423',
                                                  style: theme
                                                      .textTheme.displayMedium
                                                      ?.copyWith(
                                                    fontSize: 26.sp,
                                                  ),
                                                ),
                                                Text(
                                                  loc.kcalRemaining,
                                                  style: theme
                                                      .textTheme.labelLarge
                                                      ?.copyWith(
                                                    color: AppColors.darkSilver,
                                                  ),
                                                ),
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
                            50.horizontalSpace,
                            Expanded(
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: TextButton(
                                      onPressed: onViewMacros,
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        minimumSize: Size.zero,
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                      ),
                                      child: Text(
                                        loc.viewMacros,
                                        style: theme.textTheme.titleSmall
                                            ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          decoration: TextDecoration.underline,
                                          color: AppColors.darkSilver,
                                        ),
                                      ),
                                    ),
                                  ),
                                  16.verticalSpace,
                                  CaloriesWidget(
                                    name: loc.protein,
                                    value: '50/76g',
                                    svg: AppAssets.svgProtein,
                                  ),
                                  10.verticalSpace,
                                  CaloriesWidget(
                                    name: loc.carbohydrates,
                                    value: '121/231g',
                                    svg: AppAssets.svgCarbohydrates,
                                  ),
                                  10.verticalSpace,
                                  CaloriesWidget(
                                    name: loc.fat,
                                    value: '121g/234g',
                                    svg: AppAssets.svgFat,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      15.verticalSpace,
                      Row(
                        children: [
                          CholestrolWidget(
                            title: loc.totalFats,
                            value: '87kg',
                            goal: '77kg',
                            progress: 75,
                            activeColor: AppColors.goldenPoppy,
                          ),
                          const Spacer(),
                          CholestrolWidget(
                            title: loc.cholestrol,
                            value: '241kg',
                            goal: '77kg',
                            progress: 50,
                            activeColor: AppColors.blueberry,
                          ),
                          const Spacer(),
                          CholestrolWidget(
                            title: loc.calcium,
                            value: '43kg',
                            goal: '77kg',
                            progress: 75,
                            activeColor: AppColors.goldenPoppy,
                          ),
                        ],
                      ),
                      30.verticalSpace,
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              loc.myCurrentMealPlan,
                              style: theme.textTheme.bodyLarge
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                          ),
                          TextButton(
                            onPressed: onViewAll,
                            child: Text(
                              loc.viewAll,
                              style: theme.textTheme.bodyLarge,
                            ),
                          ),
                        ],
                      ),
                      5.verticalSpace,
                      const MealPlanWidget(),
                      30.verticalSpace,
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          loc.levelUpYourGame,
                          style: theme.textTheme.bodyLarge
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                      5.verticalSpace,
                      Container(
                        padding: EdgeInsets.all(20.w),
                        decoration: BoxDecoration(
                          color: AppColors.darkMidnightBlue,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 58.w,
                              height: 58.w,
                              decoration: BoxDecoration(
                                color: AppColors.blueberry,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    loc.lvl,
                                    style: theme.primaryTextTheme.labelLarge
                                        ?.copyWith(color: AppColors.cultured),
                                  ),
                                  Text(
                                    '3',
                                    style: theme.primaryTextTheme.displayMedium
                                        ?.copyWith(
                                      color: AppColors.cultured,
                                      fontSize: 28.sp,
                                      height: 0.8,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            15.horizontalSpace,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomFireProgress(
                                    progress: 0.80,
                                    child: (color) => Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        RotationTransition(
                                          turns: const AlwaysStoppedAnimation(
                                            45 / 360,
                                          ),
                                          child: Container(
                                            width: 24.w,
                                            height: 24.w,
                                            decoration: BoxDecoration(
                                              color: color,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                5.r,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '4',
                                          style: theme
                                              .primaryTextTheme.headlineSmall,
                                        ),
                                      ],
                                    ),
                                  ),
                                  10.verticalSpace,
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5.w),
                                    child: Text(
                                      '13% until next level',
                                      style: theme.primaryTextTheme.labelLarge,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      16.verticalSpace,
                      Row(
                        children: [
                          FilterWidget(
                            selectedFilter: selectedFilter.value,
                            title: loc.tasks,
                            onTap: () => selectedFilter.value = loc.tasks,
                          ),
                          10.horizontalSpace,
                          FilterWidget(
                            selectedFilter: selectedFilter.value,
                            title: loc.milestones,
                            onTap: () => selectedFilter.value = loc.milestones,
                          ),
                          10.horizontalSpace,
                          FilterWidget(
                            selectedFilter: selectedFilter.value,
                            title: loc.challenges,
                            onTap: () => selectedFilter.value = loc.challenges,
                          ),
                        ],
                      ),
                      16.verticalSpace,
                      SizedBox(
                        height: 256.h,
                        child: ListView.separated(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) =>
                              const FilterDataWidget(),
                          separatorBuilder: (context, index) =>
                              15.horizontalSpace,
                          itemCount: 3,
                        ),
                      ),
                      30.verticalSpace,
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          loc.discover,
                          style: theme.textTheme.bodyLarge
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                      5.verticalSpace,
                      GridView.builder(
                        itemCount: titleList.length,
                        shrinkWrap: true,
                        primary: false,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 15.h,
                          crossAxisSpacing: 15.w,
                        ),
                        itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            if (index == 0) {
                              context.pushNamed(AppRouters.myRecipe);
                            } else if (index == 1) {
                              context.pushNamed(AppRouters.friendsDailyTask);
                            } else if (index == 2) {
                              context.pushNamed(AppRouters.levels);
                            } else if (index == 3) {
                              context
                                  .pushNamed(AppRouters.integratedMobileApps);
                            }
                          },
                          child: DiscoverWidget(
                            title: titleList[index],
                            svg: svgList[index],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
