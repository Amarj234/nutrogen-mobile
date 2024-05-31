import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/res/app_routers.dart';
import 'package:nutrogen/ui/module/challenges/widget/easy_task_widget.dart';
import 'package:nutrogen/ui/module/challenges/widget/expert_budget.dart';
import 'package:nutrogen/ui/module/mealPlans/widget/discover_widget.dart';
import 'package:nutrogen/utils/helper.dart';

class LevelsPage extends HookConsumerWidget {
  const LevelsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          borderRadius: BorderRadius.circular(100),
          onTap: () {
            context.pop();
          },
          child: Container(
            margin: EdgeInsets.only(left: 10.w),
            decoration: const BoxDecoration(
              color: AppColors.antiFlashWhite,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(10),
            child: SvgPicture.asset(AppAssets.svgBackArrow),
          ),
        ),
        elevation: 0,
        centerTitle: true,
        title: Text(
          loc.gamification,
          style: theme.primaryTextTheme.bodyLarge?.copyWith(
            color: AppColors.black,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ExpertBudgetWidget(),
              20.verticalSpace,
              Text(
                loc.claimrewardsthroughpoints,
                style: theme.primaryTextTheme.bodyLarge?.copyWith(
                  color: AppColors.black,
                ),
              ),
              15.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        context.pushNamed(AppRouters.shop);
                      },
                      child: DiscoverRowWidget(
                        svg: AppAssets.cart,
                        title: loc.shopwithNutrogenpoints,
                      ),
                    ),
                  ),
                  10.horizontalSpace,
                  Expanded(
                    child: DiscoverRowWidget(
                      svg: AppAssets.harthend,
                      title: loc.donatewithNutrogenPoints,
                    ),
                  ),
                ],
              ),
              30.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    loc.completeeasytasksearnfast,
                    style: theme.primaryTextTheme.bodyLarge?.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      context.pushNamed(AppRouters.tasks);
                    },
                    child: Text(
                      loc.viewAll,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: AppColors.darkSilver,
                      ),
                    ),
                  ),
                ],
              ),
              15.verticalSpace,
              SizedBox(
                height: 256.h,
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => const EasyTaskWidget(
                    buttontxt: 'Daily Task',
                  ),
                  separatorBuilder: (context, index) => 15.horizontalSpace,
                  itemCount: 3,
                ),
              ),
              30.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    loc.challenges,
                    style: theme.primaryTextTheme.bodyLarge?.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                  Text(
                    loc.viewAll,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: AppColors.darkSilver,
                    ),
                  ),
                ],
              ),
              15.verticalSpace,
              SizedBox(
                height: 256.h,
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => const EasyTaskWidget(
                    isshowActive: true,
                    isshowpoint: true,
                    buttontxt: 'Challenges',
                  ),
                  separatorBuilder: (context, index) => 15.horizontalSpace,
                  itemCount: 3,
                ),
              ),
              30.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    loc.milestones,
                    style: theme.primaryTextTheme.bodyLarge?.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                  Text(
                    loc.viewAll,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: AppColors.darkSilver,
                    ),
                  ),
                ],
              ),
              15.verticalSpace,
              SizedBox(
                height: 256.h,
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => const EasyTaskWidget(
                    isshowActive: true,
                    isshowpoint: true,
                    buttontxt: 'Long Milestone',
                  ),
                  separatorBuilder: (context, index) => 15.horizontalSpace,
                  itemCount: 3,
                ),
              ),
              50.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
