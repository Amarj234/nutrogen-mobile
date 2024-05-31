import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/ui/module/logFood/log_food_page.dart';
import 'package:nutrogen/ui/module/recipe/widget/recipe_list.dart';
import 'package:nutrogen/utils/helper.dart';

class FavouritesRecipe extends HookConsumerWidget {
  const FavouritesRecipe({super.key});

  @override
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: ScreenUtil().statusBarHeight,
            color: AppColors.white,
          ),
          Expanded(
            child: NestedScrollView(
              physics: const NeverScrollableScrollPhysics(),
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  floating: false,
                  pinned: false,
                  automaticallyImplyLeading: false,
                  toolbarHeight: 70.h,
                  backgroundColor: AppColors.white,
                  flexibleSpace: Column(
                    children: [
                      10.verticalSpace,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: SvgPicture.asset(AppAssets.svgCloseGray),
                            ),
                            Container(
                              width: 360.w,
                              padding: const EdgeInsets.symmetric(
                                vertical: 20,
                              ),
                              decoration: const BoxDecoration(
                                color: AppColors.white,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      height: 42.h,
                                      decoration: BoxDecoration(
                                        color: AppColors.antiFlashWhite,
                                        borderRadius:
                                            BorderRadius.circular(35.r),
                                      ),
                                      child: Row(
                                        children: [
                                          20.horizontalSpace,
                                          SvgPicture.asset(
                                            AppAssets.svgSearchYellow,
                                            colorFilter: const ColorFilter.mode(
                                              AppColors.quickSilver,
                                              BlendMode.srcIn,
                                            ),
                                          ),
                                          6.horizontalSpace,
                                          Expanded(
                                            child: TextField(
                                              controller: searchController,
                                              style: theme.textTheme.titleSmall
                                                  ?.copyWith(
                                                color: AppColors.smokyBlack,
                                              ),
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.only(
                                                  top: 0,
                                                  bottom: 10,
                                                ),
                                                hintText: loc.search,
                                                hintStyle: theme
                                                    .textTheme.titleSmall
                                                    ?.copyWith(
                                                  color: AppColors.darkSilver,
                                                ),
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  10.horizontalSpace,
                                  Container(
                                    padding: EdgeInsets.all(8.w),
                                    decoration: const BoxDecoration(
                                      color: AppColors.cultured,
                                      shape: BoxShape.circle,
                                    ),
                                    child: SvgPicture.asset(
                                      AppAssets.settingsOption,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: SliverAppBarDelegate(
                    minHeight: 5.h,
                    maxHeight: 0.h,
                    child: const Stack(
                      children: [],
                    ),
                  ),
                ),
              ],
              body: SizedBox(
                height: MediaQuery.of(context).size.height - 150,
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  scrollDirection: Axis.vertical,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(top: 20.h),
                      child: const RecipeList(favorate: true),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
