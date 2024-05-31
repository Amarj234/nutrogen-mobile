import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/data/model/package_list_model.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/ui/module/onbording/onbording_provider.dart';
import 'package:nutrogen/ui/module/paywall/paywall_provider.dart';
import 'package:nutrogen/utils/helper.dart';
import 'package:nutrogen/utils/helper_extension.dart';

class PackageCardWidget extends HookConsumerWidget {
  const PackageCardWidget({
    required this.package,
    required this.onTap,
    required this.parentIndex,
    super.key,
  });

  final int parentIndex;
  final PackageR package;
  final Function(String plan) onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPackage = ref.watch(registerModelProvider).package;
    final selectedPlan = ref.watch(registerModelProvider).packageType;
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: parentIndex == 0 ? 10.h : 0),
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: AppColors.white,
            border: selectedPackage == package.id
                ? Border.all(width: 2.w, color: AppColors.darkMidnightBlue)
                : Border.all(width: 1.w, color: AppColors.azureishWhite),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${package.name}',
                    style: theme.textTheme.headlineSmall,
                  ),
                  SvgPicture.asset(
                    parentIndex == 2
                        ? AppAssets.svgPremium
                        : parentIndex == 1
                            ? AppAssets.svgGold
                            : AppAssets.svgStandard,
                  ),
                ],
              ),
              ListView.separated(
                itemCount: package.packageFeature?.length ?? 0,
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                primary: false,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => 16.verticalSpace,
                itemBuilder: (context, index) => Row(
                  children: [
                    SvgPicture.asset(AppAssets.svgPoint),
                    10.horizontalSpace,
                    Text(
                      '${package.packageFeature?[index].featureName}',
                      style: theme.textTheme.titleSmall
                          ?.copyWith(color: AppColors.darkSilver),
                    ),
                  ],
                ),
              ),
              20.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () => onTap('m'),
                    style: OutlinedButton.styleFrom(
                      backgroundColor:
                          selectedPackage == package.id && selectedPlan == 'm'
                              ? AppColors.darkMidnightBlue
                              : AppColors.antiFlashWhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.h),
                      ),
                      side: BorderSide(
                        width: 1.w,
                        color: AppColors.azureishWhite,
                      ),
                      fixedSize: Size(164.w, 58.h),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          loc.monthly,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: selectedPackage == package.id &&
                                    selectedPlan == 'm'
                                ? AppColors.white
                                : null,
                          ),
                        ),
                        Text(
                          priceAccordingType(
                            type: 'm',
                            package: package,
                          ).priceFormat,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: selectedPackage == package.id &&
                                    selectedPlan == 'm'
                                ? AppColors.white
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        child: OutlinedButton(
                          onPressed: () => onTap('y'),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: selectedPackage == package.id &&
                                    selectedPlan == 'y'
                                ? AppColors.darkMidnightBlue
                                : AppColors.antiFlashWhite,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.h),
                            ),
                            side: BorderSide(
                              width: 1.w,
                              color: AppColors.azureishWhite,
                            ),
                            fixedSize: Size(164.w, 58.h),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                loc.yearly,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: selectedPackage == package.id &&
                                          selectedPlan == 'y'
                                      ? AppColors.white
                                      : null,
                                ),
                              ),
                              Text(
                                priceAccordingType(
                                  type: 'y',
                                  package: package,
                                ).priceFormat,
                                style: theme.textTheme.headlineSmall?.copyWith(
                                  color: selectedPackage == package.id &&
                                          selectedPlan == 'y'
                                      ? AppColors.white
                                      : null,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.mikadoYellow,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Text(
                            loc.percentSavings('55'),
                            style: theme.primaryTextTheme.titleSmall,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Visibility(
          visible: parentIndex == 0,
          child: Positioned(
            right: 50.w,
            top: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: AppColors.darkMidnightBlue,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                loc.popular,
                style: theme.primaryTextTheme.titleSmall,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
