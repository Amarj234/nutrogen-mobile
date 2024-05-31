import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';

class CustomFireProgress extends StatelessWidget {
  const CustomFireProgress({
    required this.progress,
    required this.child,
    super.key,
  });

  final double progress;
  final Widget Function(Color) child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: LinearProgressIndicator(
            backgroundColor: AppColors.metallicBlue,
            value: progress,
            minHeight: 7.h,
            valueColor: const AlwaysStoppedAnimation<Color>(
              AppColors.goldenPoppy,
            ),
            borderRadius: BorderRadius.circular(50.r),
          ),
        ),
        Row(
          children: [
            if (progress != 0)
              Spacer(
                flex: (progress * 100).toInt(),
              ),
            Container(
              margin: EdgeInsets.only(bottom: 10.h),
              child: Image.asset(
                AppAssets.pngFire,
              ),
            ),
            if (progress < 1.0)
              Spacer(
                flex: 100 - (progress * 100).toInt(),
              ),
          ],
        ),
        Row(
          children: [
            const Spacer(
              flex: 85,
            ),
            child.call(
              progress >= 0.85
                  ? AppColors.mikadoYellow
                  : AppColors.metallicBlue,
            ),
            const Spacer(
              flex: 15,
            ),
          ],
        ),
      ],
    );
  }
}
