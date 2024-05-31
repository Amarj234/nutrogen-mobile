import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/ui/module/shopping/cart/widget/card_info_sheet.dart';
import 'package:nutrogen/utils/helper.dart';

class PaymentMethodSheet extends HookConsumerWidget {
  const PaymentMethodSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onEditCreditDebitCard() async {
      context.pop();
      await showModalBottomSheet(
        context: context,
        backgroundColor: AppColors.white,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
        ),
        builder: (context) => const CardInfoSheet(),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        15.verticalSpace,
        Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: 42.w,
            child: Divider(
              color: AppColors.platinum,
              thickness: 4.h,
            ),
          ),
        ),
        16.verticalSpace,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(
            loc.changePaymentMethod,
            style: theme.textTheme.bodyLarge
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        20.verticalSpace,
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.h),
          onTap: onEditCreditDebitCard,
          leading: FittedBox(
            child: Row(
              children: [
                SvgPicture.asset(AppAssets.svgCreditCard),
                10.horizontalSpace,
                Text(
                  loc.creditDebitCard,
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
        Divider(
          color: AppColors.platinum,
          thickness: 1.h,
          height: 1.h,
        ),
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.h),
          onTap: () {},
          leading: SvgPicture.asset(AppAssets.svgApplePay),
        ),
        Divider(
          color: AppColors.platinum,
          thickness: 1.h,
          height: 1.h,
        ),
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.h),
          onTap: () {},
          leading: SvgPicture.asset(AppAssets.svgStripePay),
        ),
        Divider(
          color: AppColors.platinum,
          thickness: 1.h,
          height: 1.h,
        ),
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.h),
          onTap: () {},
          leading: SvgPicture.asset(AppAssets.svgPaypal),
        ),
        Divider(
          color: AppColors.platinum,
          thickness: 1.h,
          height: 1.h,
        ),
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.h),
          onTap: () {},
          leading: SvgPicture.asset(AppAssets.svgGpay),
        ),
        30.verticalSpace,
      ],
    );
  }
}
