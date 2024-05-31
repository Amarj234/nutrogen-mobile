import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/ui/module/genratedAiPlan/widget/use_grams.dart';
import 'package:nutrogen/ui/module/genratedAiPlan/widget/use_percentage.dart';
import 'package:nutrogen/utils/helper.dart';

import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';

class GenratedAiFive extends HookConsumerWidget {
  const GenratedAiFive({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController = useTabController(initialLength: 2);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  child: Text(
                    loc.macronutrients,
                    style: theme.textTheme.displaySmall,
                  ),
                ),
              ],
            ),
            20.verticalSpace,
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                color: AppColors.antiFlashWhite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.all(5.w),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(50.r),
                      ),
                      child: TabBar(
                        controller: tabController,
                        dividerHeight: 0,
                        labelStyle: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontFamily: AppAssets.fontPlusJakartaSans,
                        ),
                        unselectedLabelStyle:
                            theme.textTheme.titleSmall?.copyWith(
                          fontFamily: AppAssets.fontPlusJakartaSans,
                        ),
                        unselectedLabelColor: AppColors.darkSilver,
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelPadding: EdgeInsets.symmetric(vertical: 12.h),
                        indicator: BoxDecoration(
                          color: AppColors.brightGray,
                          borderRadius: BorderRadius.circular(50.r),
                        ), //Change background color from here
                        tabs: [
                          Text(loc.usepercentage),
                          Text(loc.usegrams),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            20.verticalSpace,
            SizedBox(
              height: MediaQuery.of(context).size.height - 300,
              child: TabBarView(
                controller: tabController,
                children: const [
                  UsePecentage(),
                  UseGrams(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
