import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nutrogen/data/model/meal_list_model.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/ui/common/image_widget.dart';
import 'package:nutrogen/utils/helper.dart';

class PlanWidget extends StatelessWidget {
  const PlanWidget({
    required this.onAddMeal,
    required this.recipies,
    required this.foods,
    required this.title,
    super.key,
  });
  final List<Recipy> recipies;
  final List<Food> foods;
  final String title;

  final VoidCallback onAddMeal;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 20.h,
      ),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: theme.textTheme.displaySmall,
          ),
          2.verticalSpace,
          Padding(
            padding: EdgeInsets.only(right: 26.w),
            child: Text(
              'Recommended portion: 25%  of total daiy consumption',
              style: theme.textTheme.titleSmall
                  ?.copyWith(color: AppColors.darkSilver),
            ),
          ),
          12.verticalSpace,
          Visibility(
            visible: recipies.isNotEmpty,
            child: ListView.separated(
              itemCount: recipies.length,
              shrinkWrap: true,
              separatorBuilder: (context, index) => Divider(
                thickness: 1.h,
                height: 20.h,
              ),
              itemBuilder: (context, index) {
                double energy = 0;

                recipies[index].ingredient?.forEach((element) {
                  energy = energy + (element.food?.energyKcal ?? 0);
                });

                return FoodWidget(
                  subtitle: '$energy kcal',
                  index: index,
                  onOptionMenu: () {},
                  title: '${recipies[index].recipeName}',
                );
              },
            ),
          ),
          Visibility(
            visible: foods.isNotEmpty && recipies.isNotEmpty,
            child: Divider(
              thickness: 1.h,
              height: 20.h,
            ),
          ),
          Visibility(
            visible: foods.isNotEmpty,
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: foods.length,
              shrinkWrap: true,
              separatorBuilder: (context, index) => Divider(
                thickness: 1.h,
                height: 20.h,
              ),
              itemBuilder: (context, index) {
                double energy = foods[index].energyKcal ?? 0;

                return FoodWidget(
                  subtitle: '$energy kcal',
                  index: index,
                  onOptionMenu: () {},
                  title: '${foods[index].foodName}',
                );
              },
            ),
          ),
          20.verticalSpace,
        ],
      ),
    );
  }
}

class FoodWidget extends StatelessWidget {
  const FoodWidget({
    required this.onOptionMenu,
    required this.index,
    required this.title,
    required this.subtitle,
    super.key,
  });
  final int index;
  final String title;
  final String subtitle;
  final VoidCallback onOptionMenu;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: ImageWidget(
            '',
            width: 54.w,
            height: 54.w,
            // opacity: index == 0
            //     ? const AlwaysStoppedAnimation(1)
            //     : const AlwaysStoppedAnimation(.5),
          ),
        ),
        8.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: index == 0
                      ? AppColors.eerieBlack
                      : AppColors.eerieBlack.withOpacity(.4),
                ),
              ),
              1.verticalSpace,
              Text(
                subtitle,
                style: theme.textTheme.titleSmall?.copyWith(
                  color: index == 0
                      ? AppColors.darkSilver
                      : AppColors.darkSilver.withOpacity(.4),
                ),
              ),
            ],
          ),
        ),
        8.horizontalSpace,
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: index == 0
                  ? AppColors.antiFlashWhite
                  : AppColors.darkMidnightBlue,
            ),
            child: SvgPicture.asset(
              AppAssets.svgRight,
              colorFilter: ColorFilter.mode(
                index == 0 ? AppColors.weldonBlue : AppColors.quickSilver,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        // InkWell(
        //     onTap: onOptionMenu,
        //     child: SvgPicture.asset(AppAssets.svgThreeDots))
      ],
    );
  }
}
