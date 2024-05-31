import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/data/model/meal_list_model.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/utils/helper.dart';
import 'package:pie_chart/pie_chart.dart';

class NutritionSummaryPage extends HookConsumerWidget {
  const NutritionSummaryPage({
    required this.foodsWithType,
    this.limitProtein,
    this.limitCarbohydrates,
    this.limitFat,
    super.key,
  });

  final List<Food>? foodsWithType;
  final double? limitProtein;
  final double? limitCarbohydrates;
  final double? limitFat;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Food foodContinents = Food();

    foodsWithType?.forEach((element) {
      foodContinents = collectFood(foodContinents, element);
    });

    void onClose() {
      context.pop();
    }

    final dataMap = <String, double>{
      loc.breakfast: (foodsWithType?[0].energyKcal ?? 0),
      loc.lunch: (foodsWithType?[1].energyKcal ?? 0),
      loc.dinner: (foodsWithType?[2].energyKcal ?? 0),
      loc.snacks: (foodsWithType?[3].energyKcal ?? 0),
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
                loc.nutritionSummary,
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
            20.verticalSpace,
            PieChart(
              dataMap: dataMap,
              animationDuration: const Duration(milliseconds: 800),
              chartRadius: 200.w,
              colorList: colorList,
              chartType: ChartType.disc,
              legendOptions: const LegendOptions(showLegends: false),
              chartValuesOptions: const ChartValuesOptions(
                showChartValueBackground: false,
                showChartValues: false,
                showChartValuesInPercentage: false,
                showChartValuesOutside: false,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 45.w, vertical: 20.h),
              child: GridView.builder(
                itemCount: colorList.length,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 34.w,
                  mainAxisSpacing: 15.h,
                  mainAxisExtent: 50.h,
                ),
                itemBuilder: (context, index) => ChartWidget(
                  title: dataMap.keys.elementAt(index),
                  subTitle:
                      '${percent(maxValue: index == 0 ? 400 : index == 1 ? 650 : index == 2 ? 200 : 650, value: dataMap.values.elementAt(index))}% (${dataMap.values.elementAt(index).toStringAsFixed(0)} kcal)',
                  color: colorList[index],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
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
                        '1900',
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
                        (foodContinents.energyKcal ?? 0).toStringAsFixed(0),
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
                        (1900 - (foodContinents.energyKcal ?? 0))
                            .toStringAsFixed(0),
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
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              padding: EdgeInsets.all(20.w),
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
                        '${loc.protein} - ${percent(maxValue: (limitProtein ?? 75), value: foodContinents.proteinG)}%',
                        style: theme.textTheme.titleSmall,
                      ),
                      Text(
                        '${(foodContinents.proteinG ?? 0).toStringAsFixed(2)}/${(limitProtein ?? 75)}g',
                        style: theme.textTheme.titleSmall,
                      ),
                    ],
                  ),
                  10.verticalSpace,
                  LinearProgressIndicator(
                    backgroundColor: AppColors.cultured,
                    value:
                        (foodContinents.proteinG ?? 0) / (limitProtein ?? 75),
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
                        '${loc.carbohydrates} - ${percent(maxValue: (limitCarbohydrates ?? 500), value: foodContinents.carbohydrateG)}%',
                        style: theme.textTheme.titleSmall,
                      ),
                      Text(
                        '${(foodContinents.carbohydrateG ?? 0).toStringAsFixed(2)}/${(limitCarbohydrates ?? 500)}g',
                        style: theme.textTheme.titleSmall,
                      ),
                    ],
                  ),
                  10.verticalSpace,
                  LinearProgressIndicator(
                    backgroundColor: AppColors.cultured,
                    value: (foodContinents.carbohydrateG ?? 0) /
                        (limitCarbohydrates ?? 500),
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
                        '${loc.fat} - ${percent(maxValue: (limitFat ?? 70), value: foodContinents.fatG)}%',
                        style: theme.textTheme.titleSmall,
                      ),
                      Text(
                        '${(foodContinents.fatG ?? 0).toStringAsFixed(2)}/${(limitFat ?? 70)}g',
                        style: theme.textTheme.titleSmall,
                      ),
                    ],
                  ),
                  10.verticalSpace,
                  LinearProgressIndicator(
                    backgroundColor: AppColors.cultured,
                    value: (foodContinents.fatG ?? 0) / (limitFat ?? 70),
                    minHeight: 10.h,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.goldenPoppy,
                    ),
                    borderRadius: BorderRadius.circular(50.r),
                  ),
                ],
              ),
            ),
            40.verticalSpace,
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                loc.macros,
                style: theme.textTheme.bodyLarge
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            15.verticalSpace,
            KeyValueWidget(
              title: 'Addedsuger',
              vlaue: '${(foodContinents.addedSugarG ?? 0).toStringAsFixed(2)}g',
            ),
            KeyValueWidget(
              title: 'Calcium',
              vlaue: '${(foodContinents.calciumMg ?? 0).toStringAsFixed(2)}mg',
            ),
            KeyValueWidget(
              title: 'Carbohydrate',
              vlaue:
                  '${(foodContinents.carbohydrateG ?? 0).toStringAsFixed(2)}g',
            ),
            KeyValueWidget(
              title: 'Cholesterol',
              vlaue:
                  '${(foodContinents.cholesterolMg ?? 0).toStringAsFixed(2)}mg',
            ),
            KeyValueWidget(
              title: 'Fat',
              vlaue: '${(foodContinents.fatG ?? 0).toStringAsFixed(2)}g',
            ),
            KeyValueWidget(
              title: 'Folate',
              vlaue: '${(foodContinents.folateUg ?? 0).toStringAsFixed(2)}ug',
            ),
            KeyValueWidget(
              title: 'Iodine',
              vlaue: '${(foodContinents.iodineUg ?? 0).toStringAsFixed(2)}ug',
            ),
            KeyValueWidget(
              title: 'Iron',
              vlaue: '${(foodContinents.ironMg ?? 0).toStringAsFixed(2)}mg',
              isSubItem: true,
            ),
            KeyValueWidget(
              title: 'Magnesium',
              vlaue:
                  '${(foodContinents.magnesiumMg ?? 0).toStringAsFixed(2)}mg',
            ),
            KeyValueWidget(
              title: 'Niacin B3',
              vlaue: '${(foodContinents.niacinB3Mg ?? 0).toStringAsFixed(2)}mg',
            ),
            KeyValueWidget(
              title: 'Phosphorus',
              vlaue:
                  '${(foodContinents.phosphorusMg ?? 0).toStringAsFixed(2)}mg',
            ),
            KeyValueWidget(
              title: 'Polyunsatured Fat',
              vlaue:
                  '${(foodContinents.polyunsaturedFatG ?? 0).toStringAsFixed(2)}g',
            ),
            KeyValueWidget(
              title: 'Potassium',
              vlaue:
                  '${(foodContinents.potassiumMg ?? 0).toStringAsFixed(2)}mg',
            ),
            KeyValueWidget(
              title: 'Protein',
              vlaue: '${(foodContinents.proteinG ?? 0).toStringAsFixed(2)}g',
            ),
            KeyValueWidget(
              title: 'Riboflavin B2',
              vlaue:
                  '${(foodContinents.riboflavinB2Mg ?? 0).toStringAsFixed(2)}mg',
            ),
            KeyValueWidget(
              title: 'Saturated Fat',
              vlaue:
                  '${(foodContinents.saturatedFatG ?? 0).toStringAsFixed(2)}g',
            ),
            KeyValueWidget(
              title: 'Selenium',
              vlaue: '${(foodContinents.seleniumUg ?? 0).toStringAsFixed(2)}ug',
            ),
            KeyValueWidget(
              title: 'Sodium',
              vlaue: '${(foodContinents.sodiumMg ?? 0).toStringAsFixed(2)}mg',
            ),
            KeyValueWidget(
              title: 'Starch',
              vlaue: '${(foodContinents.starchG ?? 0).toStringAsFixed(2)}g',
            ),
            KeyValueWidget(
              title: 'Sugar',
              vlaue: '${(foodContinents.sugarG ?? 0).toStringAsFixed(2)}g',
            ),
            KeyValueWidget(
              title: 'Thiamin B1',
              vlaue:
                  '${(foodContinents.thiaminB1Mg ?? 0).toStringAsFixed(2)}mg',
            ),
            KeyValueWidget(
              title: 'Trans Fat',
              vlaue: '${(foodContinents.transFatMg ?? 0).toStringAsFixed(2)}mg',
            ),
            KeyValueWidget(
              title: 'Vitamin A',
              vlaue: '${(foodContinents.vitaminAUg ?? 0).toStringAsFixed(2)}ug',
            ),
            KeyValueWidget(
              title: 'Vitamin C',
              vlaue: '${(foodContinents.vitaminCMg ?? 0).toStringAsFixed(2)}mg',
            ),
            KeyValueWidget(
              title: 'Vitamin E',
              vlaue: '${(foodContinents.vitaminEMg ?? 0).toStringAsFixed(2)}mg',
            ),
            KeyValueWidget(
              title: 'Zinc',
              vlaue: '${(foodContinents.zincMg ?? 0).toStringAsFixed(2)}mg',
            ),

            // ListView.builder(
            //   padding: EdgeInsets.zero,
            //   shrinkWrap: true,
            //   primary: false,
            //   itemCount: 0,
            //   itemBuilder: (context, parentIndex) => Column(
            //     children: [
            //       Container(
            //         margin: EdgeInsets.symmetric(horizontal: 20.w),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Text(
            //               'Protein',
            //               style: theme.textTheme.bodyMedium?.copyWith(
            //                 fontFamily: AppAssets.fontPlusJakartaSans,
            //               ),
            //             ),
            //             Text(
            //               '18.5g',
            //               style: theme.textTheme.titleMedium?.copyWith(
            //                 fontFamily: AppAssets.fontPlusJakartaSans,
            //                 fontWeight: FontWeight.w700,
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //       // Visibility(
            //       //   visible: parentIndex != 19,
            //       //   child: Divider(
            //       //     color: AppColors.platinum,
            //       //     thickness: 1.h,
            //       //     height: 20.h,
            //       //   ),
            //       // ),
            //       // Visibility(
            //       //   visible: false,
            //       //   child: ListView.builder(
            //       //     padding: EdgeInsets.zero,
            //       //     shrinkWrap: true,
            //       //     primary: false,
            //       //     itemCount: 2,
            //       //     itemBuilder: (context, index) => Column(
            //       //       children: [
            //       //         Container(
            //       //           margin: EdgeInsets.only(left: 40.w, right: 20.w),
            //       //           child: Row(
            //       //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       //             children: [
            //       //               Text(
            //       //                 'Sugars',
            //       //                 style: theme.textTheme.bodyMedium?.copyWith(
            //       //                   color: AppColors.darkSilver,
            //       //                   fontFamily: AppAssets.fontPlusJakartaSans,
            //       //                 ),
            //       //               ),
            //       //               Text(
            //       //                 '18.5g',
            //       //                 style: theme.textTheme.titleMedium?.copyWith(
            //       //                   fontFamily: AppAssets.fontPlusJakartaSans,
            //       //                   fontWeight: FontWeight.w700,
            //       //                 ),
            //       //               ),
            //       //             ],
            //       //           ),
            //       //         ),
            //       //         Divider(
            //       //           color: AppColors.platinum,
            //       //           thickness: 1.h,
            //       //           height: 20.h,
            //       //         ),
            //       //       ],
            //       //     ),
            //       //   ),
            //       // ),
            //     ],
            //   ),
            // ),
            50.verticalSpace,
          ],
        ),
      ),
    );
  }
}

class KeyValueWidget extends StatelessWidget {
  const KeyValueWidget({
    required this.title,
    required this.vlaue,
    this.isBorder = true,
    this.isSubItem = false,
    super.key,
  });

  final String title;
  final String vlaue;
  final bool isBorder;
  final bool isSubItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontFamily: AppAssets.fontPlusJakartaSans,
                ),
              ),
              Text(
                vlaue,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontFamily: AppAssets.fontPlusJakartaSans,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: isBorder,
          child: Divider(
            color: AppColors.platinum,
            thickness: 1.h,
            height: 20.h,
          ),
        ),
      ],
    );
  }
}

class ChartWidget extends StatelessWidget {
  const ChartWidget({
    required this.title,
    required this.subTitle,
    required this.color,
    super.key,
  });

  final String? title;
  final String? subTitle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 24.w,
          height: 24.w,
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
              style: theme.textTheme.labelLarge
                  ?.copyWith(color: AppColors.darkSilver),
            ),
          ],
        ),
      ],
    );
  }
}
