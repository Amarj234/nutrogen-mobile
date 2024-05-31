import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/utils/helper.dart';
import 'package:pie_chart/pie_chart.dart';

class MealHistory extends StatelessWidget {
  const MealHistory({super.key});

  @override
  Widget build(BuildContext context) {
    void onClose() {
      context.pop();
    }

    final dataMap = <String, double>{
      loc.breakfast: 1,
      loc.lunch: 3,
      loc.dinner: 3,
      loc.snacks: 3,
    };

    final colorList = <Color>[
      AppColors.darkMidnightBlue,
      AppColors.maastrichtBlue,
      AppColors.gold,
      AppColors.goldenPoppy,
    ];

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
                loc.mealHistory,
                style: theme.textTheme.bodyLarge
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            Positioned(
              left: 10.w,
              bottom: 10.h,
              child: IconButton(
                onPressed: onClose,
                padding: EdgeInsets.zero,
                icon: SvgPicture.asset(AppAssets.svgCloseGray),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    'Mon, 17th dec',
                    style: theme.textTheme.displaySmall,
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 26.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Text(
                            loc.netCalories,
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
                      45.horizontalSpace,
                      Column(
                        children: [
                          Text(
                            loc.yourGoal,
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
                    ],
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Text(
                            loc.protein,
                            style: theme.textTheme.labelLarge,
                          ),
                          2.verticalSpace,
                          Text(
                            '50/76g',
                            style: theme.textTheme.bodyLarge
                                ?.copyWith(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      50.horizontalSpace,
                      Column(
                        children: [
                          Text(
                            loc.carbohydrates,
                            style: theme.textTheme.labelLarge,
                          ),
                          2.verticalSpace,
                          Text(
                            '121/231g',
                            style: theme.textTheme.bodyLarge
                                ?.copyWith(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      50.horizontalSpace,
                      Column(
                        children: [
                          Text(
                            loc.fat,
                            style: theme.textTheme.labelLarge,
                          ),
                          2.verticalSpace,
                          Text(
                            '121g/234g',
                            style: theme.textTheme.bodyLarge
                                ?.copyWith(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                20.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: PieChart(
                          ringStrokeWidth: 1,
                          chartLegendSpacing: 1,
                          dataMap: dataMap,
                          animationDuration: const Duration(milliseconds: 800),
                          chartRadius: 100.w,
                          colorList: colorList,
                          chartType: ChartType.disc,
                          legendOptions:
                              const LegendOptions(showLegends: false),
                          chartValuesOptions: const ChartValuesOptions(
                            showChartValueBackground: false,
                            showChartValues: false,
                            showChartValuesInPercentage: false,
                            showChartValuesOutside: false,
                          ),
                        ),
                      ),
                      Container(
                        width: 250,
                        margin: EdgeInsets.only(left: 10.h),
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: colorList.length,
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 0,
                            mainAxisSpacing: 1.h,
                            mainAxisExtent: 50.h,
                          ),
                          itemBuilder: (context, index) => ChartWidget(
                            size: 20,
                            title: dataMap.keys.elementAt(index),
                            subTitle: '20% (234 cal)',
                            color: colorList[index],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                15.verticalSpace,
                ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  shrinkWrap: true,
                  primary: false,
                  itemCount: 7,
                  itemBuilder: (context, parentIndex) => Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom:
                            BorderSide(width: 1.5, color: AppColors.platinum),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: Image.asset(
                            AppAssets.jpgBreakfast,
                            width: 54.w,
                            height: 54.w,
                          ),
                        ),
                        8.horizontalSpace,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '1 pc Grilled Chicken Cheese',
                              style: theme.textTheme.titleMedium,
                            ),
                            1.verticalSpace,
                            Text(
                              'Breakfast - 232 Kcal',
                              style: theme.textTheme.titleSmall
                                  ?.copyWith(color: AppColors.darkSilver),
                            ),
                          ],
                        ),

                        // InkWell(
                        //     onTap: onOptionMenu,
                        //     child: SvgPicture.asset(AppAssets.svgThreeDots))
                      ],
                    ),
                  ),
                ),
                20.verticalSpace,
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    'Mon, 17th dec',
                    style: theme.textTheme.displaySmall,
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 26.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Text(
                            loc.netCalories,
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
                      45.horizontalSpace,
                      Column(
                        children: [
                          Text(
                            loc.yourGoal,
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
                    ],
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Text(
                            loc.protein,
                            style: theme.textTheme.labelLarge,
                          ),
                          2.verticalSpace,
                          Text(
                            '50/76g',
                            style: theme.textTheme.bodyLarge
                                ?.copyWith(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      50.horizontalSpace,
                      Column(
                        children: [
                          Text(
                            loc.carbohydrates,
                            style: theme.textTheme.labelLarge,
                          ),
                          2.verticalSpace,
                          Text(
                            '121/231g',
                            style: theme.textTheme.bodyLarge
                                ?.copyWith(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      50.horizontalSpace,
                      Column(
                        children: [
                          Text(
                            loc.fat,
                            style: theme.textTheme.labelLarge,
                          ),
                          2.verticalSpace,
                          Text(
                            '121g/234g',
                            style: theme.textTheme.bodyLarge
                                ?.copyWith(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                20.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: PieChart(
                          ringStrokeWidth: 1,
                          chartLegendSpacing: 1,
                          dataMap: dataMap,
                          animationDuration: const Duration(milliseconds: 800),
                          chartRadius: 100.w,
                          colorList: colorList,
                          chartType: ChartType.disc,
                          legendOptions:
                              const LegendOptions(showLegends: false),
                          chartValuesOptions: const ChartValuesOptions(
                            showChartValueBackground: false,
                            showChartValues: false,
                            showChartValuesInPercentage: false,
                            showChartValuesOutside: false,
                          ),
                        ),
                      ),
                      Container(
                        width: 250,
                        margin: EdgeInsets.only(left: 10.h),
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: colorList.length,
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 0,
                            mainAxisSpacing: 1.h,
                            mainAxisExtent: 50.h,
                          ),
                          itemBuilder: (context, index) => ChartWidget(
                            size: 20,
                            title: dataMap.keys.elementAt(index),
                            subTitle: '20% (234 cal)',
                            color: colorList[index],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                15.verticalSpace,
                ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  shrinkWrap: true,
                  primary: false,
                  itemCount: 7,
                  itemBuilder: (context, parentIndex) => Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom:
                            BorderSide(width: 1.5, color: AppColors.platinum),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: Image.asset(
                            AppAssets.jpgBreakfast,
                            width: 54.w,
                            height: 54.w,
                          ),
                        ),
                        8.horizontalSpace,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '1 pc Grilled Chicken Cheese',
                              style: theme.textTheme.titleMedium,
                            ),
                            1.verticalSpace,
                            Text(
                              'Breakfast - 232 Kcal',
                              style: theme.textTheme.titleSmall
                                  ?.copyWith(color: AppColors.darkSilver),
                            ),
                          ],
                        ),

                        // InkWell(
                        //     onTap: onOptionMenu,
                        //     child: SvgPicture.asset(AppAssets.svgThreeDots))
                      ],
                    ),
                  ),
                ),
                50.verticalSpace,
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ChartWidget extends StatelessWidget {
  const ChartWidget({
    required this.title,
    required this.subTitle,
    required this.color,
    this.size = 24,
    super.key,
  });

  final String? title;
  final double size;
  final String? subTitle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: size.w,
          height: size.w,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        12.horizontalSpace,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$title',
              style: theme.textTheme.titleMedium,
            ),
            Text(
              '$subTitle',
              style: theme.textTheme.titleSmall
                  ?.copyWith(color: AppColors.darkSilver),
            ),
          ],
        ),
      ],
    );
  }
}
