import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/data/model/package_list_model.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/res/app_routers.dart';
import 'package:nutrogen/ui/common/state_popup.dart';
import 'package:nutrogen/ui/module/onbording/onbording_provider.dart';
import 'package:nutrogen/ui/module/paywall/paywall_provider.dart';
import 'package:nutrogen/ui/module/paywall/widget/package_button_widget.dart';
import 'package:nutrogen/ui/module/paywall/widget/point_widget.dart';
import 'package:nutrogen/utils/helper.dart';
import 'package:nutrogen/utils/helper_extension.dart';

class PaywallSecondPage extends HookConsumerWidget {
  const PaywallSecondPage({required this.package, super.key});

  final PackageR? package;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPackageType = ref.watch(registerModelProvider).packageType;

    void onPackage(String plan) {
      ref.read(registerModelProvider.notifier).setPackage('${package?.id}');
      ref.read(registerModelProvider.notifier).setPackageType(plan);
      ref
          .read(registerModelProvider.notifier)
          .setPackagePrice(priceAccordingType(type: plan, package: package));
    }

    void onStart() {
      final package = ref.read(registerModelProvider).package;
      if (package == null || package == '') {
        showMessage(message: loc.pleaseSelectPackage);
        return;
      }
      context.pushNamed(AppRouters.onbording);
    }

    return Scaffold(
      body: Stack(
        children: [
          Image.asset(AppAssets.pngPaywellBg),
          Padding(
            padding: EdgeInsets.all(20.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  170.verticalSpace,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Image.asset(AppAssets.pngLogo),
                  ),
                  18.verticalSpace,
                  Padding(
                    padding: EdgeInsets.only(right: 80.w),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: loc.your,
                            style: theme.textTheme.displayLarge,
                          ),
                          WidgetSpan(child: 8.horizontalSpace),
                          TextSpan(
                            text: loc.fitness,
                            style: theme.textTheme.displayLarge
                                ?.copyWith(color: AppColors.darkMidnightBlue),
                          ),
                          WidgetSpan(child: 8.horizontalSpace),
                          TextSpan(
                            text: loc.journeyStartsHere,
                            style: theme.textTheme.displayLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
                  ListView.separated(
                    itemCount: package?.packageFeature?.length ?? 0,
                    shrinkWrap: true,
                    primary: false,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => 16.verticalSpace,
                    itemBuilder: (context, index) => PointWidget(
                      title: '${package?.packageFeature?[index].featureName}',
                      subTitle: 'uch as Greek-stylenonfat plain strained',
                    ),
                  ),
                  40.verticalSpace,
                  PackageButtonWidget(
                    isOffer: true,
                    isSelected: selectedPackageType == 'y',
                    title: loc.yearly,
                    price: priceAccordingType(type: 'y', package: package)
                        .priceFormat,
                    onTap: () => onPackage('y'),
                  ),
                  10.verticalSpace,
                  PackageButtonWidget(
                    isSelected: selectedPackageType == 'm',
                    title: loc.monthly,
                    price: priceAccordingType(type: 'm', package: package)
                        .priceFormat,
                    onTap: () => onPackage('m'),
                  ),
                  12.verticalSpace,
                  Text(
                    loc.billedAtTheStartOfEveryCycleAfterFreeTrial,
                    style: theme.textTheme.labelLarge
                        ?.copyWith(color: AppColors.darkSilver),
                  ),
                  Text(
                    loc.plansRenewAutomaticallyChangePlansOrCancelAnytime,
                    style: theme.textTheme.labelLarge
                        ?.copyWith(color: AppColors.darkSilver),
                  ),
                  50.verticalSpace,
                  ElevatedButton(
                    onPressed: onStart,
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(1.sw, 60.h),
                    ),
                    child: Text(
                      loc.startIMonthFreeTrial,
                      style: theme.primaryTextTheme.headlineSmall,
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
