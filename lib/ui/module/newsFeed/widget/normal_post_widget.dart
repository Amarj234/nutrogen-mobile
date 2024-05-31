import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/utils/helper.dart';

class NormalPostWidget extends StatelessWidget {
  const NormalPostWidget({
    required this.buttontxt,
    super.key,
    this.isshowpoint = false,
    this.isshowActive = false,
  });
  final bool isshowpoint;
  final bool isshowActive;
  final String buttontxt;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            onTap: () {},
            contentPadding: EdgeInsets.zero,
            title: Text(
              'Komol Kuchkarov',
              style: theme.textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              '@kkuchkarov',
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
                  image: AssetImage(AppAssets.userAccount),
                  fit: BoxFit.cover,
                ),
              ),
              // child: Align(
              //   alignment: Alignment.bottomRight,
              //   child: SvgPicture.asset(
              //     AppAssets.online,
              //     width: 12,
              //     height: 12,
              //   ),
              // ),
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
                  child: SvgPicture.asset(AppAssets.svgthreedotRow),
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
                      onTap: () {},
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
          ),
          Text(
            'Powermeal',
            style: theme.textTheme.bodyMedium,
          ),
          10.verticalSpace,
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.r),
                child: Image.asset(
                  AppAssets.jpgProductDetailsHeader,
                  //opacity: const AlwaysStoppedAnimation(.7),
                ),
              ),
            ],
          ),
          10.verticalSpace,
          Row(
            children: [
              SvgPicture.asset(AppAssets.redHeart),
              5.horizontalSpace,
              Text(
                '1.5k',
                style: theme.textTheme.bodyMedium,
              ),
              10.horizontalSpace,
              SvgPicture.asset(AppAssets.comment),
              5.horizontalSpace,
              Text(
                '300',
                style: theme.textTheme.bodyMedium,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Image.asset(AppAssets.postSendpng),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
