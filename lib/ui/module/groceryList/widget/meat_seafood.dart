import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/res/app_routers.dart';
import 'package:nutrogen/utils/helper.dart';

class MeatSeafood extends StatelessWidget {
  const MeatSeafood({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20.w),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      loc.meatSeafoodEggs,
                      style: theme.textTheme.displaySmall,
                    ),
                    Text(
                      '12 ${loc.items}',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 18.0),
                  child: IconButton(
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    icon: SvgPicture.asset(AppAssets.svgPlusBg),
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 4,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ListTile(
                    // onTap: (){context.pushNamed(AppRouters.groceryListDetails);},
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
                                padding:
                                    const EdgeInsets.only(bottom: 10, top: 10),
                                //   margin: EdgeInsets.symmetric(horizontal: 20.w),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom:
                                        BorderSide(color: AppColors.platinum),
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
                                padding:
                                    const EdgeInsets.only(bottom: 10, top: 10),
                                //   margin: EdgeInsets.symmetric(horizontal: 20.w),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom:
                                        BorderSide(color: AppColors.platinum),
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
                                padding:
                                    const EdgeInsets.only(bottom: 10, top: 10),
                                //   margin: EdgeInsets.symmetric(horizontal: 20.w),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom:
                                        BorderSide(color: AppColors.platinum),
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
                                padding:
                                    const EdgeInsets.only(bottom: 10, top: 10),
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
                    title: Text(
                      'Shrimp, steamed or boiled',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: index == 1
                            ? AppColors.eerieBlack.withOpacity(.5)
                            : AppColors.eerieBlack,
                      ),
                    ),
                    subtitle: Row(
                      children: [
                        Text(
                          '12 pcs',
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: index == 1
                                ? AppColors.darkSilver.withOpacity(.5)
                                : AppColors.darkSilver,
                          ),
                        ),
                        6.horizontalSpace,
                        Container(
                          width: 5.w,
                          height: 5.w,
                          decoration: const BoxDecoration(
                            color: AppColors.darkSilver,
                            shape: BoxShape.circle,
                          ),
                        ),
                        6.horizontalSpace,
                        Text(
                          '234 cal',
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: index == 1
                                ? AppColors.darkSilver.withOpacity(.5)
                                : AppColors.darkSilver,
                          ),
                        ),
                      ],
                    ),
                    leading: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: index == 1
                            ? AppColors.goldenPoppy
                            : AppColors.antiFlashWhite,
                      ),
                      child: SvgPicture.asset(
                        AppAssets.svgRight,
                        colorFilter: ColorFilter.mode(
                          index == 1 ? AppColors.white : AppColors.weldonBlue,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    decoration: BoxDecoration(
                      border: index == 3
                          ? const Border()
                          : const Border(
                              bottom: BorderSide(color: AppColors.platinum),
                            ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
