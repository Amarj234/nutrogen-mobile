import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/ui/common/radio_widget.dart';
import 'package:nutrogen/utils/helper.dart';

class PackageButtonWidget extends StatelessWidget {
  const PackageButtonWidget({
    required this.isSelected,
    required this.title,
    required this.price,
    required this.onTap,
    this.isOffer = false,
    super.key,
  });

  final bool isOffer;
  final bool isSelected;
  final String title;
  final String price;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: isOffer ? 10.h : 0),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(30.r),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              decoration: BoxDecoration(
                color: isSelected ? null : AppColors.white,
                borderRadius: BorderRadius.circular(30.r),
                border: Border.all(
                  width: isSelected ? 2.w : 1.w,
                  color: isSelected
                      ? AppColors.darkMidnightBlue
                      : AppColors.azureishWhite,
                ),
              ),
              child: Row(
                children: [
                  RadioWidget(
                    isSelected: isSelected,
                  ),
                  8.horizontalSpace,
                  Text(
                    title,
                    style: theme.textTheme.bodyMedium,
                  ),
                  const Spacer(),
                  Text(
                    price,
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        ),
        Visibility(
          visible: isOffer,
          child: Align(
            alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: AppColors.mikadoYellow,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                loc.percentSavings('55'),
                style: theme.primaryTextTheme.titleSmall,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
