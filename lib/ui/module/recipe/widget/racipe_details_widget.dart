import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/ui/module/mealPlanDetailsOverview/widget/review_widget.dart';
import 'package:nutrogen/utils/helper.dart';

class RecipeDetailsWidget extends StatelessWidget {
  const RecipeDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    void onFollowThisPlan() {}

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              loc.butteredCornwinChilli,
              style: theme.textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.w700,
                fontFamily: AppAssets.fontPlusJakartaSans,
              ),
            ),
            10.verticalSpace,
            Text(
              'By Amanda Cooper',
              style: theme.textTheme.titleSmall
                  ?.copyWith(color: AppColors.darkSilver),
            ),
            10.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                6.horizontalSpace,
                SvgPicture.asset(
                  AppAssets.clock,
                  width: 24,
                  colorFilter: const ColorFilter.mode(
                    AppColors.eerieBlack,
                    BlendMode.srcIn,
                  ),
                ),
                6.horizontalSpace,
                Text(
                  '25 Mins',
                  style: theme.textTheme.titleSmall
                      ?.copyWith(color: AppColors.eerieBlack),
                ),
                6.horizontalSpace,
                Container(
                  width: 5.w,
                  height: 5.w,
                  decoration: const BoxDecoration(
                    color: AppColors.eerieBlack,
                    shape: BoxShape.circle,
                  ),
                ),
                6.horizontalSpace,
                Text(
                  '711 cal',
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(color: AppColors.eerieBlack),
                ),
                6.horizontalSpace,
                Container(
                  width: 5.w,
                  height: 5.w,
                  decoration: const BoxDecoration(
                    color: AppColors.eerieBlack,
                    shape: BoxShape.circle,
                  ),
                ),
                6.horizontalSpace,
                SvgPicture.asset(
                  AppAssets.towUser,
                  width: 24,
                  height: 24,
                  colorFilter: const ColorFilter.mode(
                    AppColors.eerieBlack,
                    BlendMode.srcIn,
                  ),
                ),
                6.horizontalSpace,
                Text(
                  '3',
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(color: AppColors.eerieBlack),
                ),
                6.horizontalSpace,
                Container(
                  width: 5.w,
                  height: 5.w,
                  decoration: const BoxDecoration(
                    color: AppColors.eerieBlack,
                    shape: BoxShape.circle,
                  ),
                ),
                6.horizontalSpace,
                SvgPicture.asset(
                  AppAssets.svgbag,
                  width: 24,
                  colorFilter: const ColorFilter.mode(
                    AppColors.eerieBlack,
                    BlendMode.srcIn,
                  ),
                ),
                6.horizontalSpace,
                Text(
                  '5',
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(color: AppColors.eerieBlack),
                ),
              ],
            ),
            10.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cal',
                      style: theme.textTheme.titleMedium,
                    ),
                    Text(
                      '670g',
                      style: theme.textTheme.titleSmall
                          ?.copyWith(color: AppColors.darkSilver),
                    ),
                  ],
                ),
                30.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Fat',
                      style: theme.textTheme.titleMedium,
                    ),
                    Text(
                      '234g 23%',
                      style: theme.textTheme.titleSmall
                          ?.copyWith(color: AppColors.darkSilver),
                    ),
                  ],
                ),
                30.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Protein',
                      style: theme.textTheme.titleMedium,
                    ),
                    Text(
                      '234g 23%',
                      style: theme.textTheme.titleSmall
                          ?.copyWith(color: AppColors.darkSilver),
                    ),
                  ],
                ),
                30.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Carbs',
                      style: theme.textTheme.titleMedium,
                    ),
                    Text(
                      '234g 23%',
                      style: theme.textTheme.titleSmall
                          ?.copyWith(color: AppColors.darkSilver),
                    ),
                  ],
                ),
                40.horizontalSpace,
              ],
            ),
            18.verticalSpace,
            Text(
              loc.cookingsteps,
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
                  Text(
                    'According to the National Institutes of Health, nearly half of all adults in the United States have high blood pressure. If left untreated, high blood',
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ],
            ),
            20.verticalSpace,
            Text(
              loc.ingredients,
              style: theme.textTheme.bodyLarge
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            ListView.builder(
              itemCount: 5,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 15.h),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: AppColors.platinum),
                    ),
                  ),
                  child: FoodWidget(
                    index: 3,
                    onOptionMenu: () {},
                  ),
                );
              },
            ),
            40.verticalSpace,
            Row(
              children: [
                Text(
                  loc.reviews,
                  style: theme.textTheme.bodyLarge
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                SvgPicture.asset(
                  AppAssets.svgStar,
                  width: 24.w,
                  height: 24.w,
                  colorFilter: const ColorFilter.mode(
                    AppColors.goldenPoppy,
                    BlendMode.srcIn,
                  ),
                ),
                4.horizontalSpace,
                Text(
                  '4.9',
                  style: theme.textTheme.displaySmall,
                ),
              ],
            ),
            18.verticalSpace,
            SizedBox(
              height: 300.h,
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: 3,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => 15.horizontalSpace,
                itemBuilder: (context, index) => const ReviewWidget(),
              ),
            ),
            100.verticalSpace,
            Center(
              child: ElevatedButton(
                onPressed: onFollowThisPlan,
                child: Text(
                  loc.followThisPlan,
                  style: theme.primaryTextTheme.headlineSmall,
                ),
              ),
            ),
            40.verticalSpace,
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
