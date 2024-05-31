import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_routers.dart';
import 'package:nutrogen/ui/module/more/widget/settings_container.dart';
import 'package:nutrogen/utils/helper.dart';

class MorePage extends HookConsumerWidget {
  const MorePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          loc.more,
          style:
              theme.primaryTextTheme.bodyLarge?.copyWith(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            10.verticalSpace,
            SettingsContainer(
              myFun: () {
                context.pushNamed(AppRouters.shop);
              },
              text: loc.shop,
              svgPic: AppAssets.homeshop,
            ),
            SettingsContainer(
              myFun: () {
                context.pushNamed(AppRouters.groceryList);
              },
              text: loc.grocerylist,
              svgPic: AppAssets.cartbag,
            ),
            SettingsContainer(
              myFun: () {
                context.pushNamed(AppRouters.levels);
              },
              text: loc.tasksChallengesMilestones,
              svgPic: AppAssets.task,
            ),
            SettingsContainer(
              myFun: () {
                context.pushNamed(AppRouters.message);
              },
              text: loc.messages,
              svgPic: AppAssets.message,
            ),
            SettingsContainer(
              myFun: () {
                context.pushNamed(AppRouters.inviteFriendsPage);
              },
              text: loc.inviteFriends,
              svgPic: AppAssets.invite,
            ),
            SettingsContainer(
              myFun: () {
                context.pushNamed(AppRouters.mobileAppLink);
              },
              text: loc.relatedapps,
              svgPic: AppAssets.relatedapp,
            ),
            SettingsContainer(
              myFun: () {
                context.pushNamed(AppRouters.integratedMobileApps);
              },
              text: loc.integratedMobileapps,
              svgPic: AppAssets.integrated,
            ),
            SettingsContainer(
              myFun: () {
                context.pushNamed(AppRouters.settingsPage);
              },
              text: loc.settings,
              svgPic: AppAssets.moresetting,
            ),
          ],
        ),
      ),
    );
  }
}
