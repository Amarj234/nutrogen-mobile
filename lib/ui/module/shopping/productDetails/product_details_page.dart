import 'dart:async';

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
import 'package:nutrogen/ui/module/mealPlanDetailsOverview/widget/review_widget.dart';
import 'package:nutrogen/utils/helper.dart';

class ProductDetailsPage extends HookConsumerWidget {
  const ProductDetailsPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timer = useRef<Timer?>(null);
    final selectedSize = useState(1);
    final quantity = useState(10);
    void onBack() {
      context.pop();
    }

    void onCart() {
      context.pushNamed(AppRouters.cart);
    }

    void onMinus({bool isTouch = false}) {
      if (isTouch) {
        timer.value ??= Timer.periodic(
          const Duration(milliseconds: 50),
          (timer) {
            if (quantity.value <= 0) return;
            quantity.value = quantity.value - 1;
          },
        );
      } else {
        if (quantity.value <= 0) return;
        quantity.value = quantity.value - 1;
      }
    }

    void onPlus({bool isTouch = false}) {
      if (isTouch) {
        timer.value ??= Timer.periodic(
          const Duration(milliseconds: 50),
          (timer) {
            quantity.value = quantity.value + 1;
          },
        );
      } else {
        quantity.value = quantity.value + 1;
      }
    }

    void onTapUp() {
      timer.value?.cancel();
      timer.value = null;
    }

    void onAddToCart() {}

    return Scaffold(
      body: Stack(
        children: [
          NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverPersistentHeader(
                pinned: true,
                delegate: SliverAppBarDelegate(
                  minHeight: 100.h,
                  maxHeight: 380.h,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      const ImageWidget(AppAssets.jpgProductDetailsHeader),
                      SizedBox(
                        height: 150.h,
                        width: 1.sw,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.black,
                                AppColors.black.withOpacity(0),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: const [0.0, 1.0],
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          height: 50.h,
                          margin: EdgeInsets.only(
                            left: 20.w,
                            right: 20.w,
                            bottom: 10.h,
                            top: ScreenUtil().statusBarHeight + 8.h,
                          ),
                          child: Row(
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
                                  child:
                                      SvgPicture.asset(AppAssets.svgBackArrow),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  loc.shop,
                                  textAlign: TextAlign.center,
                                  style: theme.primaryTextTheme.bodyLarge,
                                ),
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
                                  padding: EdgeInsets.all(2.w),
                                  child: SvgPicture.asset(AppAssets.svgShare),
                                ),
                              ),
                              10.horizontalSpace,
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
                                  child: SvgPicture.asset(
                                    AppAssets.svgCartOutline,
                                  ),
                                ),
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
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  20.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Text(
                      'Grilled Chicken Cheese',
                      style: theme.textTheme.displaySmall,
                    ),
                  ),
                  2.verticalSpace,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      20.horizontalSpace,
                      Text(
                        loc.doller('213'),
                        style: theme.textTheme.displaySmall,
                      ),
                      6.horizontalSpace,
                      Text(
                        loc.or,
                        style: theme.textTheme.bodyMedium,
                      ),
                      4.horizontalSpace,
                      SvgPicture.asset(AppAssets.svgCoin),
                      4.horizontalSpace,
                      Text(
                        loc.pointPts('400'),
                        style: theme.textTheme.bodyMedium,
                      ),
                      20.horizontalSpace,
                    ],
                  ),
                  10.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Text(
                      'According to the National Institutes of Health, nearly half of all adults in the United States have high blood pressure. If left untreated, high bloodAccording to the National Institutes of Health, nearly half of all adults in the United States have high blood pressure. If left untreated, high blood',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                  20.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Text(
                      loc.size,
                      style: theme.textTheme.bodyLarge
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  8.verticalSpace,
                  SizedBox(
                    height: 42.h,
                    child: ListView.separated(
                      itemCount: 3,
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) => 8.horizontalSpace,
                      itemBuilder: (context, index) => SizeWidget(
                        isSelected: selectedSize.value == index,
                        onTap: () => selectedSize.value = index,
                      ),
                    ),
                  ),
                  20.verticalSpace,
                  Row(
                    children: [
                      20.horizontalSpace,
                      Expanded(
                        child: Text(
                          loc.quantity,
                          style: theme.textTheme.bodyLarge
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(
                        loc.inStock,
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(color: AppColors.darkSilver),
                      ),
                      10.horizontalSpace,
                      Container(
                        width: 140.w,
                        padding: EdgeInsets.all(4.w),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: onMinus,
                              onLongPressStart: (_) => onMinus(isTouch: true),
                              onLongPressEnd: (_) => onTapUp(),
                              child: Container(
                                width: 40.w,
                                height: 40.w,
                                padding: EdgeInsets.all(8.w),
                                decoration: BoxDecoration(
                                  color: AppColors.brightGray,
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child: SvgPicture.asset(
                                  AppAssets.svgMinusGray,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                '${quantity.value}',
                                textAlign: TextAlign.center,
                                style: theme.textTheme.bodyLarge,
                              ),
                            ),
                            GestureDetector(
                              onTap: onPlus,
                              onLongPressStart: (_) => onPlus(isTouch: true),
                              onLongPressEnd: (_) => onTapUp(),
                              child: Container(
                                width: 40.w,
                                height: 40.w,
                                padding: EdgeInsets.all(8.w),
                                decoration: BoxDecoration(
                                  color: AppColors.brightGray,
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child: SvgPicture.asset(
                                  AppAssets.svgPlusGray,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      20.horizontalSpace,
                    ],
                  ),
                  20.verticalSpace,
                  Row(
                    children: [
                      20.horizontalSpace,
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
                      20.horizontalSpace,
                    ],
                  ),
                  14.verticalSpace,
                  SizedBox(
                    height: 300.h,
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      itemCount: 3,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) => 15.horizontalSpace,
                      itemBuilder: (context, index) => const ReviewWidget(),
                    ),
                  ),
                  120.verticalSpace,
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 1.sw,
              padding: EdgeInsets.only(
                left: 20.w,
                right: 20.w,
                top: 20.h,
                bottom: 30.h,
              ),
              color: AppColors.white,
              child: ElevatedButton(
                onPressed: onAddToCart,
                style:
                    ElevatedButton.styleFrom(fixedSize: Size.fromHeight(52.h)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppAssets.svgCartOutline,
                      colorFilter: const ColorFilter.mode(
                        AppColors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                    6.horizontalSpace,
                    Text(
                      loc.addToCart,
                      style: theme.primaryTextTheme.headlineSmall,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SizeWidget extends StatelessWidget {
  const SizeWidget({
    required this.onTap,
    required this.isSelected,
    super.key,
  });

  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 10.h,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.mikadoYellow : AppColors.white,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Text(
          '1kg / 60 Serves',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: isSelected ? AppColors.white : AppColors.vampireBlack,
          ),
        ),
      ),
    );
  }
}
