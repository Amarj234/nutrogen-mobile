import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/res/app_routers.dart';
import 'package:nutrogen/ui/module/mealPlans/widget/discover_widget.dart';
import 'package:nutrogen/utils/helper.dart';

class MealPlansPage extends HookConsumerWidget {
  const MealPlansPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 70.h,
        backgroundColor: AppColors.white,
        flexibleSpace: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              bottom: 20.h,
              child: Text(
                loc.mealPlans,
                style: theme.textTheme.bodyLarge
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: Text(
                  loc.myCurrentMealPlan,
                  style: theme.textTheme.displaySmall,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  color: AppColors.white,
                ),
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: const DecorationImage(
                          image: AssetImage(AppAssets.jpgPlan),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          margin: const EdgeInsets.only(top: 10, right: 10),
                          width: 140.w,
                          height: 38.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.antiFlashWhite,
                            borderRadius: BorderRadius.circular(50.r),
                          ),
                          child: Text(
                            '100% Alligned',
                            style: theme.textTheme.titleSmall?.copyWith(
                              color: AppColors.darkMidnightBlue,
                              fontFamily: AppAssets.fontPlusJakartaSans,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                    10.verticalSpace,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 125,
                          child: Text(
                            '30-Day High-Protein Breakfast Plan for Weight Loss',
                            style: theme.textTheme.bodyLarge
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(AppAssets.svgStar),
                            2.horizontalSpace,
                            Text(
                              '4.9',
                              style: theme.textTheme.bodyLarge
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          '2345 kcal/day',
                          style: theme.textTheme.titleSmall
                              ?.copyWith(color: AppColors.darkSilver),
                        ),
                        6.horizontalSpace,
                        Container(
                          width: 5.w,
                          height: 5.w,
                          decoration: const BoxDecoration(
                            color: AppColors.darkSilver,
                            shape: BoxShape.circle,
                          ),
                        ),
                        6.horizontalSpace,
                        Text(
                          'F 13g',
                          style: theme.textTheme.titleSmall
                              ?.copyWith(color: AppColors.darkSilver),
                        ),
                        6.horizontalSpace,
                        Container(
                          width: 5.w,
                          height: 5.w,
                          decoration: const BoxDecoration(
                            color: AppColors.darkSilver,
                            shape: BoxShape.circle,
                          ),
                        ),
                        6.horizontalSpace,
                        Text(
                          'P 13g',
                          style: theme.textTheme.titleSmall
                              ?.copyWith(color: AppColors.darkSilver),
                        ),
                        6.horizontalSpace,
                        Container(
                          width: 5.w,
                          height: 5.w,
                          decoration: const BoxDecoration(
                            color: AppColors.darkSilver,
                            shape: BoxShape.circle,
                          ),
                        ),
                        6.horizontalSpace,
                        Text(
                          'C 52g',
                          style: theme.textTheme.titleSmall
                              ?.copyWith(color: AppColors.darkSilver),
                        ),
                      ],
                    ),
                  ],
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
              10.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        context.pushNamed(AppRouters.dieticiAnapproveMealPaln);
                      },
                      child: DiscoverRowWidget(
                        svg: AppAssets.dieticianPlans,
                        title: loc.dieticianPlans,
                      ),
                    ),
                  ),
                  10.horizontalSpace,
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        context.pushNamed(AppRouters.generateAiMain);
                      },
                      child: DiscoverRowWidget(
                        svg: AppAssets.genrateAi,
                        title: loc.generateAI,
                      ),
                    ),
                  ),
                ],
              ),
              10.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        context.pushNamed(AppRouters.groceryList);
                      },
                      child: DiscoverRowWidget(
                        svg: AppAssets.grocerylist,
                        title: loc.grocerylist,
                      ),
                    ),
                  ),
                  10.horizontalSpace,
                  Expanded(
                    child: DiscoverRowWidget(
                      svg: AppAssets.customplan,
                      title: loc.customplans,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
