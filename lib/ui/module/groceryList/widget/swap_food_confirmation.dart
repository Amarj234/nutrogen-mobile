import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/utils/helper.dart';

class SwapFoodConfirmation extends HookConsumerWidget {
  const SwapFoodConfirmation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
      height: 220,
      width: MediaQuery.of(context).size.width,
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Text(
              loc.areyousurefooditem,
              style: theme.textTheme.displaySmall,
            ),
          ),
          30.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  //context.pushNamed(AppRouters.groceryListDetails);
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.only(left: 26.w, right: 12.w),
                  backgroundColor: AppColors.darkMidnightBlue,
                  fixedSize: Size.fromWidth(130.w),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      loc.yesSwap,
                      style: theme.primaryTextTheme.headlineSmall,
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  //context.pushNamed(AppRouters.groceryListDetails);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.r),
                    border: Border.all(color: AppColors.eerieBlack),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        loc.dontSwap,
                        style: theme.primaryTextTheme.headlineSmall?.copyWith(
                          color: AppColors.darkMidnightBlue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
