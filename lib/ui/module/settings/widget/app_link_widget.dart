import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/utils/helper.dart';

class AppLinkWidget extends StatelessWidget {
  const AppLinkWidget({required this.link, required this.icon, super.key});

  final String link;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 2.h,
        bottom: 2.h,
        left: 15.w,
        right: 2.w,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.lightGray),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            icon,
            colorFilter: icon == AppAssets.android
                ? const ColorFilter.mode(AppColors.greenlight, BlendMode.srcIn)
                : const ColorFilter.mode(AppColors.black, BlendMode.srcIn),
          ),
          8.horizontalSpace,
          Text(
            link,
            style: theme.textTheme.bodyMedium
                ?.copyWith(color: AppColors.darkSilver),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                Clipboard.setData(ClipboardData(text: link));
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 14.w),
                margin: EdgeInsets.only(left: 100.w),
                alignment: Alignment.topRight,
                decoration: BoxDecoration(
                  color: AppColors.goldenlight,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: AppColors.lightGray),
                ),
                child: Center(
                  child:
                      Text(loc.copy, style: theme.primaryTextTheme.titleMedium),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
