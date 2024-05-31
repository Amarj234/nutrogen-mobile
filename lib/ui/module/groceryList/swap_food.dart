import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/res/app_routers.dart';
import 'package:nutrogen/ui/module/groceryList/widget/swap_food_confirmation.dart';
import 'package:nutrogen/ui/module/groceryList/widget/swap_food_qty.dart';
import 'package:nutrogen/ui/module/logFood/log_food_page.dart';
import 'package:nutrogen/utils/helper.dart';

class SwapFood extends HookConsumerWidget {
  const SwapFood({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();

    void foodConfirmation() async {
      await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
        ),
        builder: (context) => const SwapFoodConfirmation(),
      );
    }

    void onAddTo() async {
      await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
        ),
        builder: (context) => const SwapFoodQty(),
      );
    }

    void onScan() {
      context.pushNamed(AppRouters.scanBarcode);
    }

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: ScreenUtil().statusBarHeight,
            color: AppColors.white,
          ),
          Expanded(
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  floating: false,
                  pinned: false,
                  automaticallyImplyLeading: false,
                  toolbarHeight: 120.h,
                  backgroundColor: AppColors.white,
                  flexibleSpace: Column(
                    children: [
                      10.verticalSpace,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                context.pop();
                              },
                              padding: EdgeInsets.zero,
                              icon: SvgPicture.asset(AppAssets.svgCloseGray),
                            ),
                            Text(
                              loc.swapfood,
                              style: theme.textTheme.bodyLarge
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                            Container(
                              width: 40,
                            ),
                          ],
                        ),
                      ),
                      8.verticalSpace,
                      Row(
                        children: [
                          20.horizontalSpace,
                          Expanded(
                            flex: 3,
                            child: Container(
                              height: 60.h,
                              decoration: BoxDecoration(
                                color: AppColors.antiFlashWhite,
                                borderRadius: BorderRadius.circular(35.r),
                              ),
                              child: Row(
                                children: [
                                  20.horizontalSpace,
                                  SvgPicture.asset(AppAssets.svgSearchYellow),
                                  6.horizontalSpace,
                                  Expanded(
                                    child: TextField(
                                      controller: searchController,
                                      style:
                                          theme.textTheme.titleSmall?.copyWith(
                                        color: AppColors.smokyBlack,
                                      ),
                                      decoration: InputDecoration(
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
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                              onPressed: onScan,
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                elevation: 0,
                                fixedSize: Size.fromHeight(60.h),
                                backgroundColor: AppColors.antiFlashWhite,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(35.r),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(AppAssets.svgScan),
                                  4.horizontalSpace,
                                  Text(
                                    loc.scan,
                                    style: theme.primaryTextTheme.titleMedium
                                        ?.copyWith(
                                      color: AppColors.darkMidnightBlue,
                                      fontFamily: AppAssets.fontPlusJakartaSans,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          20.horizontalSpace,
                        ],
                      ),
                      10.verticalSpace,
                    ],
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  floating: false,
                  delegate: SliverAppBarDelegate(
                    minHeight: 50.h,
                    maxHeight: 50.h,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20.w, vertical: 15),
                      child: Stack(
                        children: [
                          Text(
                            loc.recommendedAlternateoptions,
                            style: theme.textTheme.headlineSmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
              body: Stack(
                children: [
                  ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        foodConfirmation();
                      },
                      child: AddFoodWidget(
                        isAdded: index == 3,
                      ),
                    ),
                    separatorBuilder: (context, index) => 10.verticalSpace,
                    itemCount: 20,
                  ),
                  Positioned(
                    left: 150.w,
                    right: 150.w,
                    bottom: 50.h,
                    child: ElevatedButton(
                      onPressed: onAddTo,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.darkMidnightBlue,
                        fixedSize: Size.fromHeight(52.h),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            loc.swapfood,
                            style: theme.primaryTextTheme.headlineSmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AddFoodWidget extends StatelessWidget {
  const AddFoodWidget({required this.isAdded, super.key});

  final bool isAdded;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: Image.asset(
            AppAssets.jpgBreakfast,
            width: 73.w,
            height: 73.w,
          ),
        ),
        6.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Cup chopped cherries',
                style: theme.textTheme.titleMedium,
              ),
              1.verticalSpace,
              Text(
                '1 Cup , 254 Kcal',
                style: theme.textTheme.titleSmall
                    ?.copyWith(color: AppColors.darkSilver),
              ),
            ],
          ),
        ),
        6.horizontalSpace,
        IconButton(
          onPressed: () {},
          style: IconButton.styleFrom(padding: EdgeInsets.all(3.w)),
          icon: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isAdded ? AppColors.goldenlight : AppColors.white,
            ),
            child: SvgPicture.asset(
              colorFilter: ColorFilter.mode(
                isAdded ? AppColors.white : AppColors.eerieBlack,
                BlendMode.srcIn,
              ),
              isAdded ? AppAssets.svgRight : AppAssets.svgRight,
              height: 25.w,
            ),
          ),
        ),
      ],
    );
  }
}
