import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/utils/helper.dart';

class TaskCompletedPage extends StatelessWidget {
  const TaskCompletedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkMidnightBlue,
      body: SafeArea(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          //  crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            100.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  loc.monthlyTaskcompleted,
                  style: theme.textTheme.bodyLarge
                      ?.copyWith(color: AppColors.white),
                ),
              ],
            ),
            20.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  loc.pickingHealthySnacks,
                  style: theme.textTheme.displayMedium
                      ?.copyWith(color: AppColors.white, fontSize: 30),
                ),
              ],
            ),
            20.verticalSpace,
            Image.asset(
              AppAssets.roundfire,
              height: 200,
            ),
            20.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.goldenPoppy,
                  ),
                  child: SvgPicture.asset(
                    width: 10,
                    AppAssets.svgStar,
                    colorFilter: const ColorFilter.mode(
                      AppColors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                5.horizontalSpace,
                Text(
                  '400 Pts',
                  style: theme.textTheme.displaySmall
                      ?.copyWith(color: AppColors.white),
                ),
              ],
            ),
            20.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: LinearProgressIndicator(
                backgroundColor: AppColors.whitegrey.withOpacity(.3),
                value: 0.9,
                minHeight: 10.h,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppColors.white,
                ),
                borderRadius: BorderRadius.circular(50.r),
              ),
            ),
            8.verticalSpace,
            Text(
              '100% complete',
              style: theme.primaryTextTheme.titleSmall,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () {
                    //context.pushNamed(AppRouters.taskCompletedPage);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.goldenPoppy,
                    fixedSize: Size.fromHeight(60.h),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 68.w),
                    child: Text(
                      loc.claimReward,
                      style: theme.primaryTextTheme.titleMedium,
                    ),
                  ),
                ),
              ),
            ),
            30.verticalSpace,
          ],
        ),
      ),
    );
  }
}
