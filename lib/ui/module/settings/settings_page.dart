import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/providers.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/res/app_constants.dart';
import 'package:nutrogen/res/app_routers.dart';
import 'package:nutrogen/ui/common/state_popup.dart';
import 'package:nutrogen/ui/module/more/widget/settings_container.dart';
import 'package:nutrogen/utils/helper.dart';

class SettingsPage extends HookConsumerWidget {
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onLogout() {
      showCommonDialog(
        loc.areYouSureWantToLogout,
        buttonText: loc.yes,
        onOk: (context) async {
          await ref.read(dbServiceProvider).delete(key: AppConstants.tokenKey);
          await ref.read(dbServiceProvider).delete(key: AppConstants.userKey);
          if (context.mounted) {
            context.goNamed(AppRouters.login);
          }
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Container(
            width: 37.w,
            height: 37.w,
            padding: EdgeInsets.all(6.w),
            decoration: const BoxDecoration(
              color: AppColors.cultured,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(AppAssets.svgBackArrow),
          ),
          onPressed: () {
            context.pop();
          },
        ),
        centerTitle: true,
        title: Text(
          loc.settings,
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
                context.pushNamed(AppRouters.profileSettingsPage);
              },
              text: loc.profilesettings,
              svgPic: AppAssets.profilesettings,
            ),
            SettingsContainer(
              myFun: () {
                context.pushNamed(AppRouters.pushNotificationPage);
              },
              text: loc.pushNotifications,
              svgPic: AppAssets.pushnotification,
            ),
            SettingsContainer(
              myFun: () {
                context.pushNamed(AppRouters.paymentPlanPage);
              },
              text: loc.subscriptionandPayments,
              svgPic: AppAssets.pushnotification,
            ),
            SettingsContainer(
              text: loc.privacyPolicy,
              svgPic: AppAssets.privacylock,
            ),
            SettingsContainer(
              myFun: onLogout,
              text: loc.logout,
              svgPic: AppAssets.svgLogout,
            ),
          ],
        ),
      ),
    );
  }
}
