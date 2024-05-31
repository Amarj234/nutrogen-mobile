import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/ui/common/input_textfields.dart';
import 'package:nutrogen/utils/helper.dart';

class AddRecipeOne extends HookConsumerWidget {
  const AddRecipeOne({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipeName = useTextEditingController();
    final description = useTextEditingController();
    final totalTime = useTextEditingController();
    final servingSize = useTextEditingController();
    final suitableFor = useTextEditingController();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                child: Text(
                  loc.recipeInfomation,
                  style: theme.textTheme.displaySmall,
                ),
              ),
            ],
          ),
          20.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 75.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: AppColors.white,
                  border: Border.all(color: AppColors.lightGray),
                ),
                child: Column(
                  children: [
                    SvgPicture.asset(AppAssets.svgupload),
                    10.verticalSpace,
                    Text(
                      loc.uploadBanner,
                      style: theme.textTheme.headlineSmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
          20.verticalSpace,
          Text(
            loc.recipeName,
            style: theme.textTheme.headlineSmall,
          ),
          10.verticalSpace,
          InputTextfields(
            hint: 'Type here',
            controller: recipeName,
            bordercolor: AppColors.lightGray,
            fillcolor: AppColors.white,
          ),
          20.verticalSpace,
          Text(
            loc.description,
            style: theme.textTheme.headlineSmall,
          ),
          10.verticalSpace,
          InputTextfields(
            maxLines: 3,
            hint: '5',
            controller: description,
            bordercolor: AppColors.lightGray,
            fillcolor: AppColors.white,
          ),
          20.verticalSpace,
          Text(
            loc.totaltimeinminute,
            style: theme.textTheme.headlineSmall,
          ),
          10.verticalSpace,
          InputTextfields(
            hint: '15',
            controller: totalTime,
            bordercolor: AppColors.lightGray,
            fillcolor: AppColors.white,
          ),
          20.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      loc.servingsize,
                      style: theme.textTheme.headlineSmall,
                    ),
                    10.verticalSpace,
                    InputTextfields(
                      hint: '5',
                      controller: servingSize,
                      bordercolor: AppColors.lightGray,
                      fillcolor: AppColors.white,
                    ),
                  ],
                ),
              ),
              15.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      loc.suitablefor,
                      style: theme.textTheme.headlineSmall,
                    ),
                    10.verticalSpace,
                    InputTextfields(
                      hint: 'Lunch, Dinner',
                      controller: suitableFor,
                      bordercolor: AppColors.lightGray,
                      fillcolor: AppColors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
