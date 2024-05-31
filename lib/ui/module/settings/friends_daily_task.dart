import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/res/app_routers.dart';
import 'package:nutrogen/utils/helper.dart';

class FriendsDailyTask extends HookConsumerWidget {
  const FriendsDailyTask({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onClose() {
      context.pop();
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: onClose,
          padding: EdgeInsets.zero,
          icon: SvgPicture.asset(AppAssets.svgCloseGray),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Container(
              width: 37.w,
              height: 37.w,
              padding: EdgeInsets.all(6.w),
              decoration: const BoxDecoration(
                color: AppColors.cultured,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(AppAssets.svgPlusBg),
            ),
            onPressed: () {
              context.pop();
            },
          ),
        ],
        title: Text(
          loc.friends,
          style:
              theme.primaryTextTheme.bodyLarge?.copyWith(color: Colors.black),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        itemCount: 8,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              context.pushNamed(AppRouters.mobileAppDetails);
            },
            contentPadding: EdgeInsets.zero,
            title: Text(
              'Desirae Schleifer',
              style: theme.textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              'Connected',
              style: theme.textTheme.titleSmall
                  ?.copyWith(color: AppColors.darkSilver),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            leading: Container(
              width: 61.w,
              height: 61.h,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(AppAssets.avatar),
                  fit: BoxFit.cover,
                ),
              ),
              child: Align(
                alignment: Alignment.bottomRight,
                child: SvgPicture.asset(
                  AppAssets.online,
                  width: 12,
                  height: 12,
                ),
              ),
            ),
            trailing: SizedBox(
              width: 35,
              child: Align(
                alignment: Alignment.centerRight,
                child: PopupMenuButton<int>(
                  color: AppColors.white,
                  surfaceTintColor: AppColors.white,
                  elevation: 10,
                  splashRadius: 10.r,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  shadowColor: AppColors.black.withOpacity(0.5),
                  child: SvgPicture.asset(AppAssets.svgThreeDots),
                  itemBuilder: (context) => [
                    PopupMenuItem<int>(
                      value: 0,
                      height: 34.h,
                      padding: EdgeInsets.zero,
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 10, top: 10),
                        //   margin: EdgeInsets.symmetric(horizontal: 20.w),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: AppColors.platinum),
                          ),
                        ),
                        child: Row(
                          children: [
                            20.horizontalSpace,
                            SvgPicture.asset(AppAssets.svgeditIcon),
                            6.horizontalSpace,
                            Text(
                              'Edit quantity',
                              style: theme.textTheme.bodyMedium,
                            ),
                            20.horizontalSpace,
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                    PopupMenuItem<int>(
                      value: 0,
                      height: 34.h,
                      padding: EdgeInsets.zero,
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 10, top: 10),
                        //   margin: EdgeInsets.symmetric(horizontal: 20.w),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: AppColors.platinum),
                          ),
                        ),
                        child: Row(
                          children: [
                            20.horizontalSpace,
                            SvgPicture.asset(AppAssets.svghide),
                            6.horizontalSpace,
                            Text(
                              'Hide',
                              style: theme.textTheme.bodyMedium,
                            ),
                            20.horizontalSpace,
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                    PopupMenuItem<int>(
                      value: 0,
                      height: 34.h,
                      padding: EdgeInsets.zero,
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 10, top: 10),
                        //   margin: EdgeInsets.symmetric(horizontal: 20.w),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: AppColors.platinum),
                          ),
                        ),
                        child: Row(
                          children: [
                            20.horizontalSpace,
                            SvgPicture.asset(AppAssets.svgswap),
                            6.horizontalSpace,
                            Text(
                              'Swap',
                              style: theme.textTheme.bodyMedium,
                            ),
                            20.horizontalSpace,
                          ],
                        ),
                      ),
                      onTap: () {
                        context.pushNamed(AppRouters.swapFood);
                      },
                    ),
                    PopupMenuItem<int>(
                      value: 0,
                      height: 34.h,
                      padding: EdgeInsets.zero,
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 10, top: 10),
                        //   margin: EdgeInsets.symmetric(horizontal: 20.w),

                        child: Row(
                          children: [
                            20.horizontalSpace,
                            SvgPicture.asset(AppAssets.svgDelete),
                            6.horizontalSpace,
                            Text(
                              'Delete',
                              style: theme.textTheme.bodyMedium,
                            ),
                            20.horizontalSpace,
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
