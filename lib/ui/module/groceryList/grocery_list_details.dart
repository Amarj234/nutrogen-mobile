import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/ui/module/groceryList/widget/grains_cereal_pasta.dart';
import 'package:nutrogen/ui/module/groceryList/widget/meat_seafood.dart';
import 'package:nutrogen/ui/module/logFood/log_food_page.dart';
import 'package:nutrogen/utils/helper.dart';

class GroceryListDetails extends HookConsumerWidget {
  const GroceryListDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController searchController = TextEditingController();

    final selectedTab = useState(loc.meatSeafoodEggs);
    final labelList = useMemoized(
      () => [
        loc.meatSeafoodEggs,
        loc.grainsCerealPasta,
        loc.exercise,
      ],
    );

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: ScreenUtil().statusBarHeight,
            color: AppColors.white,
          ),
          Expanded(
            child: NestedScrollView(
              // physics: const NeverScrollableScrollPhysics(),

              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  floating: false,
                  pinned: false,
                  automaticallyImplyLeading: false,
                  toolbarHeight: 42.h,
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
                              child: Container(
                                width: 37.w,
                                height: 37.w,
                                decoration: const BoxDecoration(
                                  color: AppColors.cultured,
                                  shape: BoxShape.circle,
                                ),
                                child: SvgPicture.asset(AppAssets.svgCloseGray),
                              ),
                            ),
                            10.horizontalSpace,
                            Expanded(
                              flex: 3,
                              child: Container(
                                height: 42.h,
                                decoration: BoxDecoration(
                                  color: AppColors.antiFlashWhite,
                                  borderRadius: BorderRadius.circular(35.r),
                                ),
                                child: Row(
                                  children: [
                                    20.horizontalSpace,
                                    SvgPicture.asset(
                                      //    width:17.w,
                                      AppAssets.greySearch,
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
                                          contentPadding: const EdgeInsets.only(
                                            top: 0,
                                            bottom: 10,
                                          ),
                                          hintText: loc.search,
                                          hintStyle: theme.textTheme.titleSmall
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
                            Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding:
                                    EdgeInsets.only(right: 15.w, left: 8.w),
                                child: PopupMenuButton<int>(
                                  color: AppColors.white,
                                  surfaceTintColor: AppColors.white,
                                  elevation: 10,
                                  splashRadius: 10.r,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  shadowColor: AppColors.black.withOpacity(0.5),
                                  child:
                                      SvgPicture.asset(AppAssets.svgThreeDots),
                                  itemBuilder: (context) => [
                                    PopupMenuItem<int>(
                                      value: 0,
                                      height: 34.h,
                                      padding: EdgeInsets.zero,
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                          bottom: 10,
                                          top: 10,
                                        ),
                                        //   margin: EdgeInsets.symmetric(horizontal: 20.w),
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: AppColors.platinum,
                                            ),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            20.horizontalSpace,
                                            SvgPicture.asset(
                                              AppAssets.svgsharelog,
                                            ),
                                            6.horizontalSpace,
                                            Text(
                                              'Share',
                                              style: theme.textTheme.bodyMedium,
                                            ),
                                            25.horizontalSpace,
                                          ],
                                        ),
                                      ),
                                      onTap: () {},
                                    ),
                                    PopupMenuItem<int>(
                                      value: 0,
                                      height: 34.h,
                                      padding: EdgeInsets.zero,
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                          bottom: 10,
                                          top: 10,
                                        ),
                                        //   margin: EdgeInsets.symmetric(horizontal: 20.w),

                                        child: Row(
                                          children: [
                                            20.horizontalSpace,
                                            SvgPicture.asset(
                                              AppAssets.svgDelete,
                                            ),
                                            6.horizontalSpace,
                                            Text(
                                              'Delete',
                                              style: theme.textTheme.bodyMedium,
                                            ),
                                            25.horizontalSpace,
                                          ],
                                        ),
                                      ),
                                      onTap: () {},
                                    ),
                                  ],
                                ),
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
                    minHeight: 65.h,
                    maxHeight: 0.h,
                    child: Stack(
                      children: [
                        Container(
                          height: 60.h,
                          color: AppColors.white,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              10.horizontalSpace,
                              ListView.builder(
                                padding: EdgeInsets.zero,
                                scrollDirection: Axis.horizontal,
                                primary: false,
                                shrinkWrap: true,
                                itemCount: labelList.length,
                                itemBuilder: (context, index) => Column(
                                  children: [
                                    TextButton(
                                      onPressed: () =>
                                          selectedTab.value = labelList[index],
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 15.w,
                                        ),
                                      ),
                                      child: Text(
                                        labelList[index],
                                        style: selectedTab.value ==
                                                labelList[index]
                                            ? theme.textTheme.headlineSmall
                                            : theme.textTheme.bodyMedium
                                                ?.copyWith(
                                                color: AppColors.darkSilver,
                                              ),
                                      ),
                                    ),
                                    Visibility(
                                      visible:
                                          selectedTab.value == labelList[index],
                                      child: Container(
                                        height: 7.h,
                                        width: 160.w,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            50.r,
                                          ),
                                          color: AppColors.darkMidnightBlue,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              20.horizontalSpace,
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              body: SizedBox(
                height: MediaQuery.of(context).size.height - 150,
                child: const SingleChildScrollView(
                  child: Column(
                    children: [
                      MeatSeafood(),
                      GrainsCerealPasta(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
