import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/res/app_routers.dart';
import 'package:nutrogen/ui/common/dropdown_widget.dart';
import 'package:nutrogen/utils/helper.dart';

class SwapFoodQty extends HookConsumerWidget {
  const SwapFoodQty({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final qty = useState(0);

    final timer = useRef<Timer?>(null);

    void onHeightMinus({bool isTouch = false, int? ind}) {
      if (qty.value <= 0) return;
      if (isTouch) {
        timer.value ??= Timer.periodic(
          const Duration(milliseconds: 50),
          (timer) {
            if (ind == 1) {
              if (qty.value > 0) {
                qty.value--;
              }
            } else {}
          },
        );
      } else {
        if (ind == 1) {
          if (qty.value > 0) {
            qty.value--;
          }
        } else {}
      }
    }

    void onHeightPlus({bool isTouch = false, int? ind}) {
      if (isTouch) {
        timer.value ??= Timer.periodic(
          const Duration(milliseconds: 50),
          (timer) {
            if (ind == 1) {
              qty.value++;
            } else {}
          },
        );
      } else {
        if (ind == 1) {
          qty.value++;
        } else {}
      }
    }

    void onTapUp() {
      timer.value?.cancel();
      timer.value = null;
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
      height: 310.h,
      child: Column(
        children: [
          SizedBox(
            width: 42.w,
            child: Divider(
              color: AppColors.platinum,
              thickness: 4.h,
            ),
          ),
          16.verticalSpace,
          Text(
            loc.addquantitytothefoods,
            style: theme.textTheme.displaySmall,
          ),
          25.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: Image.asset(
                  AppAssets.jpgBreakfast,
                  width: 54.w,
                  height: 54.w,
                ),
              ),
              8.horizontalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Non- fat plain strained yogurt',
                    style: theme.textTheme.titleMedium,
                  ),
                  1.verticalSpace,
                  Text(
                    '232 Kcal, Carbs 33g, Fat 8g, Protein 20g',
                    style: theme.textTheme.titleSmall
                        ?.copyWith(color: AppColors.darkSilver),
                  ),
                  10.verticalSpace,
                  SizedBox(
                    width: 250,
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColors.platinum),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                child: Text(
                                  '-',
                                  style: theme.textTheme.titleLarge,
                                ),
                                onTap: () => onHeightMinus(ind: 1),
                                onLongPressStart: (_) =>
                                    onHeightMinus(isTouch: true, ind: 1),
                                onLongPressEnd: (_) => onTapUp(),
                              ),
                              25.horizontalSpace,
                              Text(
                                qty.value.toString(),
                                textAlign: TextAlign.center,
                                style: theme.textTheme.bodyMedium,
                              ),
                              25.horizontalSpace,
                              GestureDetector(
                                child: Text(
                                  '+',
                                  style: theme.textTheme.titleLarge,
                                ),
                                onTap: () => onHeightPlus(ind: 1),
                                onLongPressStart: (_) =>
                                    onHeightPlus(isTouch: true, ind: 1),
                                onLongPressEnd: (_) => onTapUp(),
                              ),
                            ],
                          ),
                        ),
                        5.horizontalSpace,
                        SizedBox(
                          height: 40.h,
                          width: 100.w,
                          child: DropDownWidget(
                            textcolor: Colors.black,
                            bordercolor: AppColors.platinum,
                            onTap: (String? val) {},
                            list: const ['cup', 'tup'],
                            hint: 'cup',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          30.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 28.w),
            child: ElevatedButton(
              onPressed: () {
                context.pushNamed(AppRouters.groceryListDetails);
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.only(left: 26.w, right: 12.w),
                backgroundColor: AppColors.darkMidnightBlue,
                fixedSize: Size.fromHeight(52.w),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
    );
  }
}
