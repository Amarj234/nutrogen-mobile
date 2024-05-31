import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/ui/module/shopping/cart/cart_widget.dart';
import 'package:nutrogen/ui/module/shopping/cart/checkout_widget.dart';
import 'package:nutrogen/ui/module/shopping/cart/widget/stapper_widget.dart';
import 'package:nutrogen/utils/helper.dart';

class CartPage extends HookConsumerWidget {
  const CartPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPage = useState(0);

    void onBack() {
      selectedPage.value == 1 ? selectedPage.value = 0 : context.pop();
    }

    void onConfirmPayment() async {
      if (selectedPage.value == 0) {
        selectedPage.value = 1;
      } else {}
    }

    return PopScope(
      canPop: false,
      onPopInvoked: (_) => onBack(),
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 132.h,
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: ScreenUtil().statusBarHeight),
                    height: 108.h,
                    color: AppColors.white,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 20.w,
                          bottom: 0,
                          top: 0,
                          child: InkWell(
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
                        ),
                        Center(
                          child: Text(
                            loc.cart,
                            style: theme.textTheme.bodyLarge
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: -4.h,
                    left: 0,
                    right: 0,
                    child: StapperWidget(
                      selectedStep: selectedPage.value + 1,
                      stepCount: 2,
                    ),
                  ),
                ],
              ),
            ),
            3.verticalSpace,
            Row(
              children: [
                53.horizontalSpace,
                Text(
                  loc.yourBag,
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontFamily: AppAssets.fontPlusJakartaSans,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                Text(
                  loc.checkout,
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontFamily: AppAssets.fontPlusJakartaSans,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                45.horizontalSpace,
              ],
            ),
            10.verticalSpace,
            Expanded(
              child: IndexedStack(
                index: selectedPage.value,
                children: const [
                  CartWidget(),
                  CheckoutWidget(),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: 20.w,
                right: 20.w,
                top: 15.h,
                bottom: 20.h,
              ),
              decoration: BoxDecoration(
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, -14),
                    color: AppColors.black.withOpacity(0.15),
                    blurRadius: 85,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        loc.total,
                        style: theme.textTheme.titleSmall
                            ?.copyWith(color: AppColors.darkSilver),
                      ),
                      Text(
                        loc.doller('120.00'),
                        style: theme.textTheme.displaySmall,
                      ),
                    ],
                  ),
                  30.horizontalSpace,
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onConfirmPayment,
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size.fromHeight(50.h),
                      ),
                      child: Text(
                        selectedPage.value == 0
                            ? loc.confirmPaymentAddress
                            : loc.placeOrder,
                        style: theme.primaryTextTheme.headlineSmall,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
