import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/utils/helper.dart';

class PushNotificationPage extends HookConsumerWidget {
  const PushNotificationPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final switchValue1 = useState(true);
    final switchValue2 = useState(true);
    final switchValue3 = useState(true);
    final switchValue4 = useState(true);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(AppAssets.svgCloseGray),
          onPressed: () {
            context.pop();
          },
        ),
        centerTitle: true,
        title: Text(
          loc.pushNotifications,
          style:
              theme.primaryTextTheme.bodyLarge?.copyWith(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            10.verticalSpace,
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: AppColors.platinum)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    loc.notificationtype,
                    style: theme.textTheme.headlineSmall,
                  ),
                  CupertinoSwitch(
                    onLabelColor: AppColors.white,
                    thumbColor: AppColors.blueberry,
                    activeColor: AppColors.white,
                    value: switchValue1.value,
                    onChanged: (value) {
                      switchValue1.value = value;
                    },
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: AppColors.platinum)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    loc.notificationtype,
                    style: theme.textTheme.headlineSmall,
                  ),
                  CupertinoSwitch(
                    thumbColor: AppColors.blueberry,
                    activeColor: AppColors.white,
                    value: switchValue2.value,
                    onChanged: (value) {
                      switchValue2.value = value;
                    },
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: AppColors.platinum)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    loc.notificationtype,
                    style: theme.textTheme.headlineSmall,
                  ),
                  CupertinoSwitch(
                    thumbColor: AppColors.blueberry,
                    activeColor: AppColors.white,
                    value: switchValue3.value,
                    onChanged: (value) {
                      switchValue3.value = value;
                    },
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: AppColors.platinum)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    loc.notificationtype,
                    style: theme.textTheme.headlineSmall,
                  ),
                  CupertinoSwitch(
                    thumbColor: AppColors.blueberry,
                    activeColor: AppColors.white,
                    value: switchValue4.value,
                    onChanged: (value) {
                      switchValue4.value = value;
                    },
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
