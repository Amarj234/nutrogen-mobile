import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/utils/helper.dart';

class HydrationWidget extends StatelessWidget {
  const HydrationWidget({super.key});

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
                      loc.hydration,
                      style: theme.textTheme.displaySmall,
                    ),
                    4.verticalSpace,
                    Text(
                      '3/12 glasses',
                      style: theme.textTheme.titleSmall
                          ?.copyWith(color: AppColors.darkSilver),
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
          20.verticalSpace,
          Wrap(
            runSpacing: 16.w,
            spacing: 14.w,
            children: List.generate(
              12,
              (index) => SvgPicture.asset(
                AppAssets.svgGlass,
                colorFilter: ColorFilter.mode(
                  index >= 6 ? AppColors.brightGray : AppColors.blueJeans,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
