import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrogen/res/app_colors.dart';

class RadioWidget extends StatelessWidget {
  const RadioWidget({
    required this.isSelected,
    super.key,
  });

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 21.w,
      height: 21.w,
      padding: EdgeInsets.all(2.w),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.w,
          color: isSelected ? AppColors.eerieBlack : AppColors.lightSkyBlue,
        ),
        shape: BoxShape.circle,
      ),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? AppColors.mikadoYellow : null,
        ),
      ),
    );
  }
}
