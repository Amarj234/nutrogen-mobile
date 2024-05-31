import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/utils/helper.dart';

class ActiveSheetWidget extends StatelessWidget {
  const ActiveSheetWidget({required this.title, required this.text, super.key});

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          16.verticalSpace,
          SizedBox(
            width: 42.w,
            child: Divider(
              color: AppColors.platinum,
              thickness: 4.h,
            ),
          ),
          16.verticalSpace,
          Text(
            title,
            textAlign: TextAlign.center,
            style: theme.textTheme.displaySmall,
          ),
          10.verticalSpace,
          Text(
            text,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleSmall
                ?.copyWith(color: AppColors.darkSilver, height: 1.6),
          ),
          40.verticalSpace,
        ],
      ),
    );
  }
}
