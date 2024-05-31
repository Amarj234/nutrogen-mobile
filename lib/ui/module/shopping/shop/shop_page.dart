import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/res/app_routers.dart';
import 'package:nutrogen/ui/common/image_widget.dart';
import 'package:nutrogen/ui/module/logFood/log_food_page.dart';
import 'package:nutrogen/ui/module/shopping/shop/widget/shop_filter_widget.dart';
import 'package:nutrogen/utils/helper.dart';

class ShopPage extends HookConsumerWidget {
  const ShopPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();

    void onBack() {
      context.pop();
    }

    void onCart() {
      context.pushNamed(AppRouters.cart);
    }

    void onItemTap() {
      context.pushNamed(AppRouters.productDetails);
    }

    void onFilter() async {
      await showModalBottomSheet(
        backgroundColor: AppColors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.6,
          maxChildSize: 0.9,
          builder: (context, scrollController) => Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Stack(
              alignment: Alignment.center,
              children: [
                SingleChildScrollView(
                  controller: scrollController,
                  child: const ShopFiltersWidget(),
                ),
                Positioned(
                  bottom: 30.h,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(172.w, 55.h),
                    ),
                    child: Text(
                      loc.apply,
                      style: theme.primaryTextTheme.headlineSmall,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
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
                  toolbarHeight: 32.h,
                  backgroundColor: AppColors.white,
                  flexibleSpace: Column(
                    children: [
                      10.verticalSpace,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              borderRadius: BorderRadius.circular(100),
                              onTap: onBack,
                              child: Container(
                                height: 40.w,
                                width: 40.w,
                                decoration: const BoxDecoration(
                                  color: AppColors.antiFlashWhite,
                                  shape: BoxShape.circle,
                                ),
                                padding: EdgeInsets.all(8.w),
                                child: SvgPicture.asset(AppAssets.svgBackArrow),
                              ),
                            ),
                            Text(
                              loc.shop,
                              style: theme.textTheme.bodyLarge
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                            InkWell(
                              borderRadius: BorderRadius.circular(100),
                              onTap: onCart,
                              child: Container(
                                height: 40.w,
                                width: 40.w,
                                decoration: const BoxDecoration(
                                  color: AppColors.antiFlashWhite,
                                  shape: BoxShape.circle,
                                ),
                                padding: EdgeInsets.all(8.w),
                                child:
                                    SvgPicture.asset(AppAssets.svgCartOutline),
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
                  floating: false,
                  delegate: SliverAppBarDelegate(
                    minHeight: 68.h,
                    maxHeight: 0.h,
                    child: Container(
                      padding: EdgeInsets.only(bottom: 8.h),
                      color: AppColors.white,
                      child: Row(
                        children: [
                          20.horizontalSpace,
                          Expanded(
                            child: Container(
                              height: 50.h,
                              decoration: BoxDecoration(
                                color: AppColors.antiFlashWhite,
                                borderRadius: BorderRadius.circular(35.r),
                              ),
                              child: Row(
                                children: [
                                  20.horizontalSpace,
                                  SvgPicture.asset(
                                    AppAssets.greySearch,
                                    width: 22.w,
                                    height: 22.w,
                                  ),
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
                                          color: AppColors.quickSilver,
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
                          InkWell(
                            borderRadius: BorderRadius.circular(100),
                            onTap: onFilter,
                            child: Container(
                              height: 40.w,
                              width: 40.w,
                              decoration: const BoxDecoration(
                                color: AppColors.antiFlashWhite,
                                shape: BoxShape.circle,
                              ),
                              padding: EdgeInsets.all(8.w),
                              child: SvgPicture.asset(AppAssets.settingsOption),
                            ),
                          ),
                          20.horizontalSpace,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
              body: GridView.builder(
                itemCount: 20,
                padding: EdgeInsets.all(20.w),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15.w,
                  crossAxisSpacing: 15.w,
                  mainAxisExtent: 258.h,
                ),
                itemBuilder: (context, index) => ShopItemWidget(
                  onTap: onItemTap,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ShopItemWidget extends StatelessWidget {
  const ShopItemWidget({required this.onTap, super.key});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15.r),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ImageWidget(
                    AppAssets.jpgShopItem,
                    radius: 10.r,
                  ),
                  Positioned(
                    right: 8.w,
                    top: 8.w,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.r),
                        color: AppColors.antiFlashWhite,
                      ),
                      child: Text(
                        'Protein - Casein',
                        style: theme.textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontFamily: AppAssets.fontPlusJakartaSans,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              14.verticalSpace,
              Text(
                'Buttered Corn win Chilli',
                style: theme.textTheme.titleSmall,
              ),
              2.verticalSpace,
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    loc.doller('213'),
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  5.horizontalSpace,
                  Text(
                    loc.inStock.toLowerCase(),
                    style: theme.textTheme.titleSmall
                        ?.copyWith(color: AppColors.darkSilver),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
