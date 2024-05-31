import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/ui/common/image_widget.dart';
import 'package:nutrogen/utils/helper.dart';

class CartWidget extends HookConsumerWidget {
  const CartWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isNutroPoints = useState(false);

    void onNutroPoints(bool value) {
      isNutroPoints.value = value;
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.separated(
            shrinkWrap: true,
            primary: false,
            padding: EdgeInsets.symmetric(vertical: 20.w),
            itemBuilder: (context, index) => const CartItemWidget(),
            separatorBuilder: (context, index) => 30.verticalSpace,
            itemCount: 4,
          ),
          Divider(
            color: AppColors.platinum,
            thickness: 1.h,
            height: 30.w,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              'Frequently bought togather ',
              style: theme.textTheme.bodyLarge
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          15.verticalSpace,
          SizedBox(
            height: 75.h,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => const FrequentlyItemWidget(),
              separatorBuilder: (context, index) => 10.horizontalSpace,
              itemCount: 3,
            ),
          ),
          30.verticalSpace,
          Row(
            children: [
              20.horizontalSpace,
              Expanded(
                child: Text(
                  loc.subtotal,
                  style: theme.textTheme.bodyMedium,
                ),
              ),
              Text(
                loc.doller('97.00'),
                style: theme.textTheme.bodyMedium,
              ),
              20.horizontalSpace,
            ],
          ),
          15.verticalSpace,
          Row(
            children: [
              20.horizontalSpace,
              Expanded(
                child: Text(
                  loc.shippingHandling,
                  style: theme.textTheme.bodyMedium,
                ),
              ),
              Text(
                loc.doller('19.99'),
                style: theme.textTheme.bodyMedium,
              ),
              20.horizontalSpace,
            ],
          ),
          15.verticalSpace,
          Row(
            children: [
              20.horizontalSpace,
              Expanded(
                child: Text(
                  loc.tax,
                  style: theme.textTheme.bodyMedium,
                ),
              ),
              Text(
                loc.doller('4.00'),
                style: theme.textTheme.bodyMedium,
              ),
              20.horizontalSpace,
            ],
          ),
          20.verticalSpace,
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            padding: EdgeInsets.all(15.w),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      loc.useNutropoints,
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: AppColors.darkSilver),
                    ),
                    8.horizontalSpace,
                    SvgPicture.asset(
                      AppAssets.svgCoin,
                    ),
                    4.horizontalSpace,
                    Text(
                      loc.pointPts('400'),
                      style: theme.textTheme.bodyMedium,
                    ),
                    const Spacer(),
                    CupertinoSwitch(
                      value: isNutroPoints.value,
                      thumbColor: AppColors.goldenPoppy,
                      trackColor: AppColors.antiFlashWhite,
                      activeColor: AppColors.antiFlashWhite,
                      onChanged: onNutroPoints,
                    ),
                  ],
                ),
                Text(
                  '${loc.pointPts('234')} ${loc.willBeUsed}',
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(color: AppColors.darkSilver),
                ),
              ],
            ),
          ),
          15.verticalSpace,
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            padding:
                EdgeInsets.only(left: 15.w, right: 8.w, top: 2.h, bottom: 2.h),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    loc.addCoupon,
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: AppColors.darkSilver),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    minimumSize: Size.zero,
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    fixedSize: Size.fromHeight(38.h),
                    backgroundColor: AppColors.goldenPoppy,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    loc.apply,
                    style: theme.primaryTextTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
          30.verticalSpace,
          Row(
            children: [
              20.horizontalSpace,
              Expanded(
                child: Text(
                  loc.nutropointsDiscount,
                  style: theme.textTheme.bodyMedium,
                ),
              ),
              Text(
                '-${loc.doller('19.99')}',
                style: theme.textTheme.bodyLarge,
              ),
              20.horizontalSpace,
            ],
          ),
          15.verticalSpace,
          Row(
            children: [
              20.horizontalSpace,
              Expanded(
                child: Text(
                  loc.total,
                  style: theme.textTheme.bodyMedium,
                ),
              ),
              Text(
                loc.doller('23.00'),
                style: theme.textTheme.bodyLarge
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              20.horizontalSpace,
            ],
          ),
          30.verticalSpace,
        ],
      ),
    );
  }
}

class FrequentlyItemWidget extends StatelessWidget {
  const FrequentlyItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: AppColors.white,
      ),
      child: Row(
        children: [
          10.horizontalSpace,
          ImageWidget(
            AppAssets.jpgShopItem,
            radius: 8.r,
            width: 55.w,
            height: 55.w,
          ),
          10.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Grilled Chicken Cheese',
                  style: theme.textTheme.titleMedium,
                ),
                1.verticalSpace,
                Text(
                  loc.doller('4.00'),
                  style: theme.textTheme.titleSmall,
                ),
              ],
            ),
          ),
          10.horizontalSpace,
          IconButton(
            onPressed: () {},
            style: IconButton.styleFrom(
              backgroundColor: AppColors.brightGray,
              fixedSize: Size(40.w, 40.w),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            icon: SizedBox(
              width: 40.w,
              height: 40.w,
              child: SvgPicture.asset(AppAssets.svgPlusGray),
            ),
          ),
          10.horizontalSpace,
        ],
      ),
    );
  }
}

class CartItemWidget extends HookConsumerWidget {
  const CartItemWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timer = useRef<Timer?>(null);
    final quantity = useState(1);

    void onQuantityMinus({bool isTouch = false}) {
      if (isTouch) {
        timer.value ??= Timer.periodic(
          const Duration(milliseconds: 50),
          (timer) {
            if (quantity.value <= 1) return;

            quantity.value = quantity.value - 1;
          },
        );
      } else {
        if (quantity.value <= 1) return;

        quantity.value = quantity.value - 1;
      }
    }

    void onQuantityPlus({bool isTouch = false}) {
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

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        20.horizontalSpace,
        ImageWidget(
          AppAssets.jpgShopItem,
          radius: 10.r,
          width: 74.w,
          height: 74.w,
        ),
        15.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Non- fat plain strained yogurt',
                style: theme.textTheme.titleMedium,
              ),
              10.verticalSpace,
              Row(
                children: [
                  Container(
                    width: 116.w,
                    height: 40.h,
                    padding:
                        EdgeInsets.symmetric(vertical: 6.h, horizontal: 8.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.r),
                      color: AppColors.white,
                      border: Border.all(color: AppColors.platinum, width: 1.w),
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: onQuantityMinus,
                          onLongPressStart: (_) =>
                              onQuantityMinus(isTouch: true),
                          onLongPressEnd: (_) => onTapUp(),
                          child: SvgPicture.asset(
                            AppAssets.svgMinusGray,
                            width: 22.w,
                            height: 22.w,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '${quantity.value}',
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontFamily: AppAssets.fontPlusJakartaSans,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: onQuantityPlus,
                          onLongPressStart: (_) =>
                              onQuantityPlus(isTouch: true),
                          onLongPressEnd: (_) => onTapUp(),
                          child: SvgPicture.asset(
                            AppAssets.svgPlusGray,
                            width: 22.w,
                            height: 22.w,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Text(
                    loc.doller('231'),
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ],
          ),
        ),
        20.horizontalSpace,
      ],
    );
  }
}
