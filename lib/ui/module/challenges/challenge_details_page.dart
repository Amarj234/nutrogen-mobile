import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/ui/module/challenges/widget/challenge_details_widget.dart';
import 'package:nutrogen/utils/helper.dart';

class ChallengeDetailsPage extends HookConsumerWidget {
  const ChallengeDetailsPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onClose() {
      context.pop();
    }

    void onShare() {}

    return Scaffold(
      body: Column(
        children: [
          Container(
            color: AppColors.white,
            height: ScreenUtil().statusBarHeight,
          ),
          Expanded(
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  floating: true,
                  pinned: true,
                  automaticallyImplyLeading: false,
                  toolbarHeight: 0,
                  collapsedHeight: 28.h,
                  expandedHeight: 180.h,
                  backgroundColor: AppColors.white,
                  flexibleSpace: Stack(
                    fit: StackFit.expand,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Image.asset(
                          AppAssets.jpgMealPlanDetailsHeader,
                          fit: BoxFit.fitWidth,
                          height: 230.h,
                          width: 1.sw,
                        ),
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        margin: EdgeInsets.all(20.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: onClose,
                              padding: EdgeInsets.zero,
                              icon: SvgPicture.asset(AppAssets.svgCloseGray),
                            ),
                            10.horizontalSpace,
                            Expanded(
                              child: Text(
                                loc.challengedetails,
                                textAlign: TextAlign.center,
                                style: theme.primaryTextTheme.displaySmall
                                    ?.copyWith(
                                  fontFamily: AppAssets.fontPlusJakartaSans,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(7.r),
                              margin: EdgeInsets.only(bottom: 5.h),
                              width: 40.w,
                              height: 40.h,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColors.antiFlashWhite,
                                borderRadius: BorderRadius.circular(50.r),
                              ),
                              child: SvgPicture.asset(AppAssets.hart),
                            ),
                            IconButton(
                              onPressed: onShare,
                              padding: EdgeInsets.zero,
                              icon: SvgPicture.asset(AppAssets.svgShare),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: -2,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          padding: EdgeInsets.only(left: 20.w, right: 20.w),
                          decoration: BoxDecoration(
                            color: AppColors.antiFlashWhite,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(35.r),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              body: const ChallengeDetailsWidget(),
            ),
          ),
        ],
      ),
    );
  }
}
