import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/utils/helper.dart';

class MeanPlanWidget extends StatelessWidget {
  const MeanPlanWidget({
    required this.onTap,
    required this.title,
    required this.alligned,
    required this.kcal,
    required this.rating,
    required this.image,
    required this.fat,
    required this.protein,
    required this.cholesterol,
    super.key,
  });

  final VoidCallback onTap;
  final String title;
  final String alligned;
  final String kcal;
  final String fat;
  final String protein;
  final String cholesterol;
  final String rating;
  final String image;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: AppColors.white,
        ),
        child: Column(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                image: DecorationImage(
                  image: NetworkImage(image),
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
                    '$alligned% Alligned',
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
                    title,
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                Row(
                  children: [
                    SvgPicture.asset(AppAssets.svgStar),
                    2.horizontalSpace,
                    Text(
                      rating,
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
                  '$kcal kcal/day',
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
                  'F $fat',
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
                  'P $protein',
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
                  'C $cholesterol',
                  style: theme.textTheme.titleSmall
                      ?.copyWith(color: AppColors.darkSilver),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
