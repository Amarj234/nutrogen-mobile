import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/res/app_routers.dart';
import 'package:nutrogen/utils/helper.dart';

class ChallengeDetailsWidget extends StatelessWidget {
  const ChallengeDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    //void onFollowThisPlan() {}

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              loc.completedWeeklyShoppingList,
              style: theme.textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.w700,
                fontFamily: AppAssets.fontPlusJakartaSans,
              ),
            ),
            20.verticalSpace,
            Row(
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
                10.horizontalSpace,
                Text(
                  '400 Pts',
                  style: theme.textTheme.displaySmall
                      ?.copyWith(color: AppColors.eerieBlack),
                ),
              ],
            ),
            20.verticalSpace,
            LinearProgressIndicator(
              backgroundColor: AppColors.whitegrey,
              value: 0.7,
              minHeight: 10.h,
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.darkMidnightBlue,
              ),
              borderRadius: BorderRadius.circular(50.r),
            ),
            8.verticalSpace,
            Text(
              '60% complete',
              style: theme.primaryTextTheme.titleSmall
                  ?.copyWith(color: AppColors.eerieBlack),
            ),
            10.verticalSpace,
            18.verticalSpace,
            Text(
              loc.stepstocompletethechallenge,
              style: theme.textTheme.bodyLarge
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            10.verticalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 0; i < 3; i++) ...[
                  8.verticalSpace,
                  Text(
                    'Step ${1 + i}',
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  8.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        AppAssets.clock,
                        width: 18,
                        colorFilter: const ColorFilter.mode(
                          AppColors.eerieBlack,
                          BlendMode.srcIn,
                        ),
                      ),
                      6.horizontalSpace,
                      Text(
                        'Complete in first 4 days',
                        style: theme.textTheme.titleSmall
                            ?.copyWith(color: AppColors.eerieBlack),
                      ),
                      6.horizontalSpace,
                    ],
                  ),
                  8.verticalSpace,
                  Text(
                    'According to the National Institutes of Health, nearly half of all adults in the United States have high blood pressure. If left untreated, high blood',
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ],
            ),
            40.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.pushNamed(AppRouters.taskCompletedPage);
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size.fromHeight(60.h),
                  ),
                  child: Text(
                    loc.startthechallenge,
                    style: theme.primaryTextTheme.titleMedium,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FoodWidget extends StatelessWidget {
  const FoodWidget({
    required this.onOptionMenu,
    required this.index,
    super.key,
  });
  final int index;
  final VoidCallback onOptionMenu;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: Image.asset(
            AppAssets.jpgBreakfast,
            width: 54.w,
            height: 54.w,
            opacity: const AlwaysStoppedAnimation(1),
          ),
        ),
        8.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '1 pc Grilled Chicken Cheese',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: AppColors.eerieBlack,
                ),
              ),
              1.verticalSpace,
              Text(
                '232 Kcal',
                style: theme.textTheme.titleSmall
                    ?.copyWith(color: AppColors.darkSilver),
              ),
            ],
          ),
        ),

        // InkWell(
        //     onTap: onOptionMenu,
        //     child: SvgPicture.asset(AppAssets.svgThreeDots))
      ],
    );
  }
}
