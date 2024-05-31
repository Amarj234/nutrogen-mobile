import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/providers.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/res/app_constants.dart';
import 'package:nutrogen/res/app_routers.dart';
import 'package:nutrogen/ui/common/state_popup.dart';
import 'package:nutrogen/utils/helper.dart';

class DrawerWidget extends HookConsumerWidget {
  const DrawerWidget({required this.controller, super.key});

  final ZoomDrawerController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onLogout() {
      controller.close?.call();
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

    return Padding(
      padding: EdgeInsets.all(0.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
            ),
            child: Row(
              children: [
                SvgPicture.asset(AppAssets.svgInviteFriends),
                14.horizontalSpace,
                Text(
                  loc.inviteFriends,
                  style: theme.textTheme.titleMedium
                      ?.copyWith(color: AppColors.white),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
            ),
            child: Row(
              children: [
                SvgPicture.asset(AppAssets.svgContactUs),
                14.horizontalSpace,
                Text(
                  loc.contactUs,
                  style: theme.textTheme.titleMedium
                      ?.copyWith(color: AppColors.white),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
            ),
            child: Row(
              children: [
                SvgPicture.asset(AppAssets.svgPrivacyPolicy),
                14.horizontalSpace,
                Text(
                  loc.privacyPolicy,
                  style: theme.textTheme.titleMedium
                      ?.copyWith(color: AppColors.white),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
            ),
            child: Row(
              children: [
                SvgPicture.asset(AppAssets.svgTermsOfUse),
                14.horizontalSpace,
                Text(
                  loc.termsOfUse,
                  style: theme.textTheme.titleMedium
                      ?.copyWith(color: AppColors.white),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
            ),
            child: Row(
              children: [
                SvgPicture.asset(AppAssets.svgRateUs),
                14.horizontalSpace,
                Text(
                  loc.rateUs,
                  style: theme.textTheme.titleMedium
                      ?.copyWith(color: AppColors.white),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
            ),
            child: Row(
              children: [
                SvgPicture.asset(AppAssets.svgSettings),
                14.horizontalSpace,
                Text(
                  loc.settings,
                  style: theme.textTheme.titleMedium
                      ?.copyWith(color: AppColors.white),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: onLogout,
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
            ),
            child: Row(
              children: [
                SvgPicture.asset(AppAssets.svgLogout),
                14.horizontalSpace,
                Text(
                  loc.logout,
                  style: theme.textTheme.titleMedium
                      ?.copyWith(color: AppColors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
