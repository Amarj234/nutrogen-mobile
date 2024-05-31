import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/data/model/package_list_model.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_routers.dart';
import 'package:nutrogen/ui/common/state_view.dart';
import 'package:nutrogen/ui/module/onbording/onbording_provider.dart';
import 'package:nutrogen/ui/module/paywall/paywall_provider.dart';
import 'package:nutrogen/ui/module/paywall/widget/package_card_widget.dart';
import 'package:nutrogen/utils/helper.dart';

class PaywallFirstPage extends HookConsumerWidget {
  const PaywallFirstPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onPackage(PackageR package, String plan) {
      ref.read(registerModelProvider.notifier).setPackage('${package.id}');
      ref.read(registerModelProvider.notifier).setPackageType(plan);
      ref
          .read(registerModelProvider.notifier)
          .setPackagePrice(priceAccordingType(type: plan, package: package));

      context.pushNamed(AppRouters.paywallSecond, extra: package);
    }

    return Scaffold(
      body: Stack(
        children: [
          Image.asset(AppAssets.pngPaywellBg),
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                150.verticalSpace,
                Padding(
                  padding: EdgeInsets.only(right: 200.w),
                  child: Text(
                    loc.selectAPackageThatFitsYou,
                    style: theme.textTheme.displayMedium,
                  ),
                ),
                22.verticalSpace,
                Expanded(
                  child: Consumer(
                    builder: (context, ref, child) {
                      final packageData = ref.watch(
                        packageListCallProvider(
                          branchId:
                              '${ref.watch(registerModelProvider).branchID}',
                        ),
                      );

                      return onStateView(
                        packageData,
                        child: (data) => ListView.separated(
                          itemBuilder: (context, index) => PackageCardWidget(
                            package: data[index],
                            parentIndex: index,
                            onTap: (plan) => onPackage(data[index], plan),
                          ),
                          separatorBuilder: (context, index) =>
                              10.verticalSpace,
                          itemCount: data.length,
                        ),
                      );
                    },
                  ),
                ),
                40.verticalSpace,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
