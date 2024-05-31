import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/utils/helper.dart';

class RecipeList extends StatelessWidget {
  const RecipeList({super.key, this.favorate = false});
  final bool favorate;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10.w),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: AppColors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: MediaQuery.of(context).size.width - 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                image: AssetImage(AppAssets.jpgPlan),
                fit: BoxFit.cover,
              ),
            ),
            child: Align(
              alignment: Alignment.topRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    margin: const EdgeInsets.only(top: 10, right: 10),
                    width: 170.w,
                    height: 38.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.antiFlashWhite,
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: Text(
                      loc.goodforbreakfast,
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: AppColors.darkMidnightBlue,
                        fontFamily: AppAssets.fontPlusJakartaSans,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(6.r),
                    margin: const EdgeInsets.only(top: 10, right: 10),
                    width: 38.w,
                    height: 38.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.antiFlashWhite,
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: SvgPicture.asset(
                      favorate ? AppAssets.redHeart : AppAssets.hart,
                    ),
                  ),
                ],
              ),
            ),
          ),
          10.verticalSpace,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 135,
                child: Text(
                  'Buttered Corn win Chilli',
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
          5.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '711 cal',
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
              SvgPicture.asset(AppAssets.towUser),
              6.horizontalSpace,
              Text(
                '3',
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
              SvgPicture.asset(AppAssets.svgbag),
              6.horizontalSpace,
              Text(
                '5',
                style: theme.textTheme.titleSmall
                    ?.copyWith(color: AppColors.darkSilver),
              ),
            ],
          ),
          10.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
    );
  }
}
