import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nutrogen/data/model/meal_list_model.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/ui/common/image_widget.dart';
import 'package:nutrogen/utils/helper.dart';

class DiaryWidget extends StatelessWidget {
  const DiaryWidget({
    required this.onAddMeal,
    required this.mealList,
    super.key,
  });

  final VoidCallback onAddMeal;
  final List<Meals>? mealList;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${mealList?.first.mealType}',
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
          ListView.separated(
            itemCount: mealList?.length ?? 0,
            shrinkWrap: true,
            primary: false,
            padding: EdgeInsets.symmetric(vertical: 15.h),
            separatorBuilder: (context, index) => Divider(
              thickness: 1.h,
              height: 20.h,
            ),
            itemBuilder: (context, index) {
              final name = mealList?[index].recipes != null
                  ? '${mealList?[index].recipes?.recipeName}'
                  : '${mealList?[index].food?.foodName}';

              final image = mealList?[index].recipes != null
                  ? '${mealList?[index].recipes?.recipeImage}'
                  : '${mealList?[index].food?.foodName}';

              double carbs = 0;
              double fat = 0;
              double protein = 0;
              double energy = 0;

              if (mealList?[index].recipes != null) {
                mealList?[index].recipes?.ingredient?.forEach((element) {
                  carbs = carbs + (element.food?.carbohydrateG ?? 0);
                  fat = fat + (element.food?.fatG ?? 0);
                  protein = protein + (element.food?.proteinG ?? 0);
                  energy = energy + (element.food?.energyKcal ?? 0);
                });
              } else {
                carbs = mealList?[index].food?.carbohydrateG ?? 0;
                fat = mealList?[index].food?.fatG ?? 0;
                protein = mealList?[index].food?.proteinG ?? 0;
                energy = mealList?[index].food?.energyKcal?.toDouble() ?? 0;
              }

              final contains =
                  'Carbs ${carbs.round()}g, Fat ${fat.round()}g, Protein ${protein.round()}g';

              return FoodWidget(
                onOptionMenu: () {},
                name: name,
                image: image,
                contains: contains,
                energy: '${energy.round()}g kcal',
                onDelete: () {},
              );
            },
          ),
          20.verticalSpace,
          Center(
            child: ElevatedButton(
              onPressed: onAddMeal,
              child: Text(
                loc.addFood,
                style: theme.primaryTextTheme.headlineSmall,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FoodWidget extends StatelessWidget {
  const FoodWidget({
    required this.onOptionMenu,
    required this.onDelete,
    required this.name,
    required this.image,
    required this.contains,
    required this.energy,
    super.key,
  });

  final VoidCallback onOptionMenu;
  final VoidCallback onDelete;
  final String? image;
  final String? name;
  final String? contains;
  final String? energy;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ImageWidget(
          '$image',
          width: 54.w,
          height: 54.w,
          radius: 10.r,
        ),
        8.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$name',
                style: theme.textTheme.titleMedium,
              ),
              1.verticalSpace,
              Text(
                '$contains',
                style: theme.textTheme.titleSmall
                    ?.copyWith(color: AppColors.darkSilver),
              ),
            ],
          ),
        ),
        8.horizontalSpace,
        Text(
          '$energy',
          style:
              theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500),
        ),
        10.horizontalSpace,
        PopupMenuButton<int>(
          color: AppColors.white,
          surfaceTintColor: AppColors.white,
          elevation: 20,
          splashRadius: 10.r,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
          shadowColor: AppColors.black.withOpacity(0.5),
          child: SvgPicture.asset(AppAssets.svgThreeDots),
          itemBuilder: (context) => [
            PopupMenuItem<int>(
              value: 0,
              height: 34.h,
              padding: EdgeInsets.zero,
              onTap: onDelete,
              child: Row(
                children: [
                  20.horizontalSpace,
                  SvgPicture.asset(AppAssets.svgDelete),
                  6.horizontalSpace,
                  Text(
                    loc.delete,
                    style: theme.textTheme.bodyMedium,
                  ),
                  40.horizontalSpace,
                ],
              ),
            ),
          ],
        ),
        // InkWell(
        //     onTap: onOptionMenu,
        //     child: SvgPicture.asset(AppAssets.svgThreeDots))
      ],
    );
  }
}
