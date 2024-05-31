import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/utils/helper.dart';

class EasyTaskWidget extends StatelessWidget {
  const EasyTaskWidget({
    required this.buttontxt,
    super.key,
    this.isshowpoint = false,
    this.isshowActive = false,
  });
  final bool isshowpoint;
  final bool isshowActive;
  final String buttontxt;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15.r),
          child: Image.asset(
            AppAssets.jpgTask,
            width: 256.w,
            height: 256.w,
          ),
        ),
        Positioned(
          right: 12.w,
          top: 12.h,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: AppColors.antiFlashWhite,
              borderRadius: BorderRadius.circular(50.r),
            ),
            child: Text(
              buttontxt,
              style: theme.textTheme.labelLarge
                  ?.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
        ),
        Positioned(
          left: 12.w,
          top: 12.h,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: AppColors.antiFlashWhite,
              borderRadius: BorderRadius.circular(50.r),
            ),
            child: Text(
              'Easy',
              style: theme.textTheme.labelLarge
                  ?.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
        ),
        isshowActive
            ? Positioned(
                left: 20.w,
                bottom: 115.h,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                  decoration: BoxDecoration(
                    color: AppColors.goldenPoppy,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Active',
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                  ),
                ),
              )
            : Container(),
        Positioned(
          left: 20.w,
          bottom: isshowpoint ? 60.h : 20.h,
          child: Column(
            children: [
              Text(
                'Eat clean',
                style: theme.primaryTextTheme.bodyLarge,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(AppAssets.pngCoin),
                  2.horizontalSpace,
                  Text(
                    '234 points',
                    style: theme.primaryTextTheme.titleSmall,
                  ),
                ],
              ),
            ],
          ),
        ),
        isshowpoint
            ? Positioned(
                left: 20.w,
                bottom: 10.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 200.w,
                      child: LinearProgressIndicator(
                        backgroundColor: AppColors.whitegrey.withOpacity(.3),
                        value: 0.7,
                        minHeight: 10.h,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          AppColors.white,
                        ),
                        borderRadius: BorderRadius.circular(50.r),
                      ),
                    ),
                    8.verticalSpace,
                    Text(
                      '60% complete',
                      style: theme.primaryTextTheme.titleSmall,
                    ),
                  ],
                ),
              )
            : Container(),
      ],
    );
  }
}
