import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/utils/helper.dart';

class BreakfastEditWidget extends StatelessWidget {
  const BreakfastEditWidget({
    required this.onAddMeal,
    required this.title,
    super.key,
  });
  final String title;
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
          Row(
            children: [
              Expanded(
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
                  ],
                ),
              ),
              IconButton(
                padding: EdgeInsets.all(2.w),
                onPressed: () {},
                icon: SvgPicture.asset(AppAssets.svgEdit),
              ),
            ],
          ),
          12.verticalSpace,
          ListView.separated(
            itemCount: 2,
            shrinkWrap: true,
            primary: false,
            separatorBuilder: (context, index) => Divider(
              thickness: 1.h,
              height: 20.h,
            ),
            itemBuilder: (context, index) => FoodWidget(
              index: index,
              onOptionMenu: () {},
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
    super.key,
  });
  final int index;
  final VoidCallback onOptionMenu;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: Image.asset(
            AppAssets.jpgBreakfast,
            width: 54.w,
            height: 54.w,
            opacity: index == 0
                ? const AlwaysStoppedAnimation(1)
                : const AlwaysStoppedAnimation(.5),
          ),
        ),
        8.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '1 pc Grilled Chicken Cheese',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: index == 0
                      ? AppColors.eerieBlack
                      : AppColors.eerieBlack.withOpacity(.4),
                ),
              ),
              1.verticalSpace,
              Text(
                'Carbs 33g, Fat 8g, Protein 20g',
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
                index == 0 ? AppColors.weldonBlue : Colors.grey,
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
