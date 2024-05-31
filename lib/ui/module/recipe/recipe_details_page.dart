import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/ui/module/logFood/log_food_page.dart';
import 'package:nutrogen/ui/module/recipe/widget/racipe_details_widget.dart';
import 'package:nutrogen/utils/helper.dart';

class RecipeDetailsPage extends HookConsumerWidget {
  const RecipeDetailsPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onClose() {
      context.pop();
    }

    void onShare() {}

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverAppBarDelegate(
              minHeight: 120.h,
              maxHeight: 230.h,
              child: Stack(
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
                    margin: EdgeInsets.only(
                      left: 20.w,
                      right: 20.w,
                      bottom: 10.h,
                      top: ScreenUtil().statusBarHeight + 8.h,
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: onClose,
                          padding: EdgeInsets.zero,
                          icon: SvgPicture.asset(AppAssets.svgCloseGray),
                        ),
                        10.horizontalSpace,
                        Expanded(
                          child: Text(
                            loc.recipedetails,
                            textAlign: TextAlign.center,
                            style:
                                theme.primaryTextTheme.displaySmall?.copyWith(
                              fontFamily: AppAssets.fontPlusJakartaSans,
                            ),
                          ),
                        ),
                        Container(
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
                      height: 30.h,
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
          ),
        ],
        body: const RecipeDetailsWidget(),
      ),
    );
  }
}
