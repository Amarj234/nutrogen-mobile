import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/ui/common/image_widget.dart';
import 'package:nutrogen/ui/module/shopping/cart/widget/payment_method_sheet.dart';
import 'package:nutrogen/utils/helper.dart';

class CheckoutWidget extends HookConsumerWidget {
  const CheckoutWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onEditPaymentMethod() async {
      await showModalBottomSheet(
        context: context,
        backgroundColor: AppColors.white,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
        ),
        builder: (context) => const PaymentMethodSheet(),
      );
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          20.verticalSpace,
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        loc.address,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                    IconButton(
                      padding: EdgeInsets.all(2.w),
                      style: IconButton.styleFrom(fixedSize: Size(40.w, 40.w)),
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        AppAssets.svgEdit,
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.center,
                  height: 130.h,
                  width: 1.sw,
                  decoration: BoxDecoration(
                    color: AppColors.cultured,
                    borderRadius: BorderRadius.circular(7.r),
                  ),
                  child: const Text('MAP'),
                ),
                15.verticalSpace,
                Row(
                  children: [
                    SvgPicture.asset(AppAssets.svgMarker),
                    6.horizontalSpace,
                    Text(
                      '22 elm street, Dodge ave, Los Angeles, CA',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),
          15.verticalSpace,
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        loc.paymentMethod,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                    IconButton(
                      padding: EdgeInsets.all(2.w),
                      style: IconButton.styleFrom(fixedSize: Size(40.w, 40.w)),
                      onPressed: onEditPaymentMethod,
                      icon: SvgPicture.asset(
                        AppAssets.svgEdit,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const ImageWidget(AppAssets.masterCard),
                    6.horizontalSpace,
                    Text(
                      '**** 2324',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
                8.verticalSpace,
              ],
            ),
          ),
          15.verticalSpace,
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            padding: EdgeInsets.all(20.h),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  loc.orderSummary,
                  style: theme.textTheme.bodyLarge
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: 15.h),
                  shrinkWrap: true,
                  primary: false,
                  itemBuilder: (context, index) => Row(
                    children: [
                      Expanded(
                        child: Text(
                          '3x Egg packets',
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                      Text(
                        loc.doller('97.00'),
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  separatorBuilder: (context, index) => 16.verticalSpace,
                  itemCount: 6,
                ),
                Divider(
                  color: AppColors.platinum,
                  thickness: 1.h,
                  height: 0,
                ),
                15.verticalSpace,
                Row(
                  children: [
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
                  ],
                ),
                15.verticalSpace,
                Row(
                  children: [
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
                  ],
                ),
                15.verticalSpace,
                Row(
                  children: [
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
                  ],
                ),
                15.verticalSpace,
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        loc.pointsDiscount,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                    Text(
                      '-${loc.doller('19.99')}',
                      style: theme.textTheme.bodyLarge,
                    ),
                  ],
                ),
                15.verticalSpace,
                Row(
                  children: [
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
                  ],
                ),
              ],
            ),
          ),
          50.verticalSpace,
        ],
      ),
    );
  }
}
