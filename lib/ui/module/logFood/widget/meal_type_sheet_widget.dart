import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/utils/helper.dart';

class MealTypeSheetWidget extends StatelessWidget {
  const MealTypeSheetWidget({required this.onTap, super.key});

  final Function(String type) onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
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
          loc.whatMealDoYouWantToAdd,
          style: theme.textTheme.displaySmall,
        ),
        30.verticalSpace,
        ListTile(
          onTap: () {
            onTap(loc.breakfast);
          },
          title: Text(
            loc.breakfast,
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall,
          ),
        ),
        Container(
          color: AppColors.lightGray,
          width: 1.sw,
          height: 1.h,
        ),
        ListTile(
          onTap: () => onTap(loc.lunch),
          title: Text(
            loc.lunch,
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall,
          ),
        ),
        Container(
          color: AppColors.lightGray,
          width: 1.sw,
          height: 1.h,
        ),
        ListTile(
          onTap: () => onTap(loc.snacks),
          title: Text(
            loc.snacks,
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall,
          ),
        ),
        Container(
          color: AppColors.lightGray,
          width: 1.sw,
          height: 1.h,
        ),
        ListTile(
          onTap: () => onTap(loc.dinner),
          title: Text(
            loc.dinner,
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall,
          ),
        ),
        40.verticalSpace,
      ],
    );
  }
}
