import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nutrogen/data/model/meal_list_model.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/ui/common/image_widget.dart';
import 'package:nutrogen/utils/helper.dart';

class MealDetailWidget extends StatelessWidget {
  const MealDetailWidget({
     required this.onAddMeal,
    required this.title,
    required this.food,
    super.key,
  });
  final String title;
  final List<Food>? food;
  final VoidCallback onAddMeal;

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
          ListView.separated(
            itemCount: food!.length,
            shrinkWrap: true,
            primary: false,
            separatorBuilder: (context, index) => Divider(
              thickness: 1.h,
              height: 20.h,
            ),
            itemBuilder: (context, index) => FoodWidget(
              subtitle:
                  'Carbs ${food![index].carbohydrateG}g, Fat ${food![index].fatG}g, Protein ${food![index].proteinG}g',
              index: index,
              onOptionMenu: () {},
              title: food![index].foodName ?? '',
            ),
          ),
          10.verticalSpace,
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
