import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/ui/module/settings/widget/all_app_widget.dart';
import 'package:nutrogen/ui/module/settings/widget/connected_app_widget.dart';
import 'package:nutrogen/utils/helper.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';

class IntegratedMobileApps extends HookConsumerWidget {
  const IntegratedMobileApps({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController = useTabController(initialLength: 2);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 70.h,
        backgroundColor: AppColors.white,
        flexibleSpace: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              bottom: 20.h,
              child: Text(
                loc.mobileapps,
                style: theme.textTheme.bodyLarge
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            Positioned(
              left: 10.w,
              bottom: 10.h,
              child: IconButton(
                onPressed: () {
                  context.pop();
                },
                padding: EdgeInsets.zero,
                icon: SvgPicture.asset(AppAssets.svgCloseGray),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(),
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                //color: AppColors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    10.verticalSpace,
                    Container(
                      padding: EdgeInsets.all(5.w),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(50.r),
                      ),
                      child: TabBar(
                        controller: tabController,
                        dividerHeight: 0,
                        labelStyle: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontFamily: AppAssets.fontPlusJakartaSans,
                        ),
                        unselectedLabelStyle:
                            theme.textTheme.titleSmall?.copyWith(
                          fontFamily: AppAssets.fontPlusJakartaSans,
                        ),
                        unselectedLabelColor: AppColors.darkSilver,
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelPadding: EdgeInsets.symmetric(vertical: 12.h),
                        indicator: BoxDecoration(
                          color: AppColors.brightGray,
                          borderRadius: BorderRadius.circular(50.r),
                        ), //Change background color from here
                        tabs: [
                          Text(loc.all),
                          Text('${loc.connected} (0)'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height - 165,
              child: TabBarView(
                controller: tabController,
                children: const [
                  AllAppWidget(),
                  ConnectedAppWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
