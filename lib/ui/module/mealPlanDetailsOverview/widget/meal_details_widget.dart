import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrogen/data/model/meal_plan_model.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/res/app_routers.dart';
import 'package:nutrogen/ui/module/mealPlans/widget/meal_detail_widget.dart';
import 'package:nutrogen/utils/helper.dart';

class MealsDetailsWidget extends StatelessWidget {
  const MealsDetailsWidget({required this.mealPlanR, super.key});
  final MealPlanR? mealPlanR;
  @override
  Widget build(BuildContext context) {
    void onFollowThisPlan() async {
      await showModalBottomSheet(
        context: context,
        backgroundColor: AppColors.white,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
        ),
        builder: (context) => const ConfirmFollowWidget(),
      );
    }

    List<MealPlanMeta> mealplanMeta = [];

    mealPlanR?.mealPlanMeta?.forEach(
      (element) {
        if (mealplanMeta.any((meal) => meal.mealName == element.mealName)) {
          MealPlanMeta meal = mealplanMeta
              .firstWhere((meal) => meal.mealName == element.mealName);
          meal = meal.copyWith(
            food: [...?meal.food, ...?element.food],
            recipe: [...?meal.recipe, ...?element.recipe],
          );

          mealplanMeta[mealplanMeta
              .indexWhere((meal) => meal.mealName == element.mealName)] = meal;
        } else {
          mealplanMeta.add(element);
        }
      },
    );

    return Container(
      width: 1.sw,
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            15.verticalSpace,
            ListView.separated(
              itemCount: mealplanMeta.length,
              primary: false,
              shrinkWrap: true,
              separatorBuilder: (context, index) => 15.verticalSpace,
              itemBuilder: (context, index) => MealDetailWidget(
                onAddMeal: () {},
                title: mealplanMeta[index].mealName == '2' ||
                        mealplanMeta[index].mealName?.toLowerCase() ==
                            loc.lunch.toLowerCase()
                    ? loc.lunch
                    : mealplanMeta[index].mealName == '3' ||
                            mealplanMeta[index].mealName?.toLowerCase() ==
                                loc.snacks.toLowerCase()
                        ? loc.snacks
                        : mealplanMeta[index].mealName == '4' ||
                                mealplanMeta[index].mealName?.toLowerCase() ==
                                    loc.dinner.toLowerCase()
                            ? loc.dinner
                            : loc.breakfast,
                food: mealplanMeta[index].food,
              ),
            ),
            100.verticalSpace,
            Center(
              child: ElevatedButton(
                onPressed: onFollowThisPlan,
                child: Text(
                  loc.followThisPlan,
                  style: theme.primaryTextTheme.headlineSmall,
                ),
              ),
            ),
            40.verticalSpace,
          ],
        ),
      ),
    );
  }
}

class ConfirmFollowWidget extends StatelessWidget {
  const ConfirmFollowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          15.verticalSpace,
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: 42.w,
              child: Divider(
                color: AppColors.platinum,
                thickness: 4.h,
              ),
            ),
          ),
          16.verticalSpace,
          Text(
            loc.areYouSureYouWantToFollowThisMealPlan,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          30.verticalSpace,
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    context.pop();
                    context.pushNamed(AppRouters.mealPlanLog);
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size.fromHeight(60.h),
                  ),
                  child: Text(
                    loc.yes,
                    style: theme.primaryTextTheme.headlineSmall,
                  ),
                ),
              ),
              10.horizontalSpace,
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    context.pop();
                  },
                  style: OutlinedButton.styleFrom(
                    fixedSize: Size.fromHeight(60.h),
                  ),
                  child: Text(
                    loc.dontFollow,
                    style: theme.textTheme.headlineSmall,
                  ),
                ),
              ),
            ],
          ),
          50.verticalSpace,
        ],
      ),
    );
  }
}
