import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/res/app_routers.dart';
import 'package:nutrogen/utils/helper.dart';

class InviteFriendsPage extends StatelessWidget {
  const InviteFriendsPage({super.key});

  @override
  Widget build(BuildContext context) {
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
          loc.inviteFriends,
          style:
              theme.primaryTextTheme.bodyLarge?.copyWith(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            80.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppAssets.invitefriend),
              ],
            ),
            10.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: Text(
                textAlign: TextAlign.center,
                'Get 10% of Status Points from any friends who sign-up.',
                style: theme.textTheme.displaySmall,
              ),
            ),
            10.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: Text(
                textAlign: TextAlign.center,
                'Get status points faster to spend in the shop or donate to help kids with meals.',
                style: theme.textTheme.bodyMedium,
              ),
            ),
            30.verticalSpace,
            ElevatedButton(
              onPressed: () {
                context.pushNamed(AppRouters.inviteFromFriends);
              },
              style: ElevatedButton.styleFrom(
                fixedSize: Size.fromHeight(55.h),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 68.w),
                child: Text(
                  loc.invitenow,
                  style: theme.primaryTextTheme.titleMedium,
                ),
              ),
            ),
            20.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: Text(
                textAlign: TextAlign.center,
                'We will send a login link and you both 15% off the next month.',
                style: theme.textTheme.bodyMedium
                    ?.copyWith(color: AppColors.darkSilver),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
