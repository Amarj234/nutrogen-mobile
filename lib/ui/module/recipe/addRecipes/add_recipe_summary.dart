import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/res/app_routers.dart';
import 'package:nutrogen/ui/module/recipe/widget/chart_widget.dart';
import 'package:nutrogen/utils/helper.dart';
import 'package:pie_chart/pie_chart.dart';

class AddRecipeSummary extends HookConsumerWidget {
  const AddRecipeSummary({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorList2 = <Color>[
      AppColors.darkMidnightBlue,
      AppColors.gold,
      AppColors.goldenPoppy,
    ];

    final dataMap = <String, double>{
      loc.fat: 4,
      loc.protein: 3,
      loc.carbohydrates: 3,
    };

    final colorList = <Color>[
      AppColors.goldenPoppy,
      AppColors.maastrichtBlue,
      AppColors.gold,
    ];
    void onSeeMore() {
      context.pushNamed(AppRouters.nutritionSummary);
    }

    return Padding(
      padding: EdgeInsets.all(20.w),
      child: SingleChildScrollView(
        child: Column(
          children: [
            20.verticalSpace,
            PieChart(
              dataMap: dataMap,
              animationDuration: const Duration(milliseconds: 800),
              chartRadius: 200.w,
              colorList: colorList2,
              chartType: ChartType.disc,
              legendOptions: const LegendOptions(showLegends: false),
              chartValuesOptions: const ChartValuesOptions(
                showChartValueBackground: false,
                showChartValues: false,
                showChartValuesInPercentage: false,
                showChartValuesOutside: false,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 50,
              height: 60,
              //  margin: EdgeInsets.symmetric(horizontal: 70.w, vertical: 20.h),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: colorList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ChartWidget(
                    title: dataMap.keys.elementAt(index),
                    subTitle: '234g 23%',
                    color: colorList[index],
                  ),
                ),
              ),
            ),
            10.verticalSpace,
            Container(
              //  margin: EdgeInsets.symmetric(horizontal: 20.w),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 26.h),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        loc.ttlCalories,
                        style: theme.textTheme.labelLarge,
                      ),
                      2.verticalSpace,
                      Text(
                        '4324',
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        loc.netCalories,
                        style: theme.textTheme.labelLarge,
                      ),
                      2.verticalSpace,
                      Text(
                        '1234',
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        loc.yourGoal,
                        style: theme.textTheme.labelLarge,
                      ),
                      2.verticalSpace,
                      Text(
                        '4550',
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            15.verticalSpace,
            Container(
              //   margin: EdgeInsets.symmetric(horizontal: 20.w),
              padding: EdgeInsets.only(
                top: 20.w,
                left: 20.w,
                right: 20.w,
                bottom: 5.w,
              ),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    loc.nutrientFulfillmentPerDay,
                    style: theme.textTheme.displaySmall,
                  ),
                  16.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${loc.protein} - 23%',
                        style: theme.textTheme.titleSmall,
                      ),
                      Text(
                        '89/89g',
                        style: theme.textTheme.titleSmall,
                      ),
                    ],
                  ),
                  10.verticalSpace,
                  LinearProgressIndicator(
                    backgroundColor: AppColors.cultured,
                    value: 1.0,
                    minHeight: 10.h,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.goldenPoppy,
                    ),
                    borderRadius: BorderRadius.circular(50.r),
                  ),
                  30.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${loc.carbohydrates} - 23%',
                        style: theme.textTheme.titleSmall,
                      ),
                      Text(
                        '78/88g',
                        style: theme.textTheme.titleSmall,
                      ),
                    ],
                  ),
                  10.verticalSpace,
                  LinearProgressIndicator(
                    backgroundColor: AppColors.cultured,
                    value: 0.8,
                    minHeight: 10.h,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.blueberry,
                    ),
                    borderRadius: BorderRadius.circular(50.r),
                  ),
                  30.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${loc.fat} - 23%',
                        style: theme.textTheme.titleSmall,
                      ),
                      Text(
                        '289/300mg',
                        style: theme.textTheme.titleSmall,
                      ),
                    ],
                  ),
                  10.verticalSpace,
                  LinearProgressIndicator(
                    backgroundColor: AppColors.cultured,
                    value: 0.95,
                    minHeight: 10.h,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.goldenPoppy,
                    ),
                    borderRadius: BorderRadius.circular(50.r),
                  ),
                  Center(
                    child: TextButton(
                      onPressed: onSeeMore,
                      child: Text(
                        loc.nutritionSummary,
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: AppColors.darkMidnightBlue,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            40.verticalSpace,
            Container(
              alignment: Alignment.centerLeft,
              //margin: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                loc.macros,
                style: theme.textTheme.bodyLarge
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            15.verticalSpace,
            ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              primary: false,
              itemCount: 20,
              itemBuilder: (context, parentIndex) => Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Protein',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontFamily: AppAssets.fontPlusJakartaSans,
                        ),
                      ),
                      Text(
                        '18.5g',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontFamily: AppAssets.fontPlusJakartaSans,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: parentIndex != 19,
                    child: Divider(
                      color: AppColors.platinum,
                      thickness: 1.h,
                      height: 20.h,
                    ),
                  ),
                  Visibility(
                    visible: parentIndex == 1 || parentIndex == 2,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      primary: false,
                      itemCount: 2,
                      itemBuilder: (context, index) => Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 20.w, right: 10.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Sugars',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: AppColors.darkSilver,
                                    fontFamily: AppAssets.fontPlusJakartaSans,
                                  ),
                                ),
                                Text(
                                  '18.5g',
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontFamily: AppAssets.fontPlusJakartaSans,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: AppColors.platinum,
                            thickness: 1.h,
                            height: 20.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            50.verticalSpace,
          ],
        ),
      ),
    );
  }
}
