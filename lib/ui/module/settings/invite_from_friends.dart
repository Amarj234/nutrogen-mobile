import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/ui/common/input_textfields.dart';
import 'package:nutrogen/utils/helper.dart';

class InviteFromFriends extends HookConsumerWidget {
  const InviteFromFriends({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = useTextEditingController();
    final email = useTextEditingController();
    final phone = useTextEditingController();
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.verticalSpace,
            Text(
              loc.name,
              style: theme.textTheme.headlineSmall,
            ),
            10.verticalSpace,
            InputTextfields(
              hint: loc.typehere,
              controller: name,
              bordercolor: AppColors.lightGray,
              fillcolor: AppColors.white,
            ),
            20.verticalSpace,
            Text(
              loc.email,
              style: theme.textTheme.headlineSmall,
            ),
            10.verticalSpace,
            InputTextfields(
              hint: loc.email,
              controller: email,
              bordercolor: AppColors.lightGray,
              fillcolor: AppColors.white,
            ),
            20.verticalSpace,
            Text(
              loc.phonenumber,
              style: theme.textTheme.headlineSmall,
            ),
            10.verticalSpace,
            InputTextfields(
              hint: loc.phonenumber,
              controller: phone,
              bordercolor: AppColors.lightGray,
              fillcolor: AppColors.white,
            ),
            20.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {},
                  child: Container(
                    width: 200.w,
                    height: 37.w,
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.w,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.white,
                      // shape: BoxShape.circle,
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          AppAssets.plusBlue,
                          colorFilter: const ColorFilter.mode(
                            AppColors.black,
                            BlendMode.srcIn,
                          ),
                        ),
                        5.horizontalSpace,
                        Text(
                          loc.addanotherfriend,
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(color: AppColors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () {
                    //context.pushNamed(AppRouters.taskCompletedPage);
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
              ),
            ),
            30.verticalSpace,
          ],
        ),
      ),
    );
  }
}
