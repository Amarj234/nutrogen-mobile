import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/utils/helper.dart';

class MobileAppDetails extends StatelessWidget {
  const MobileAppDetails({super.key});

  @override
  Widget build(BuildContext context) {
    List<Color> listcolor = [
      const Color(0xff365314),
      const Color(0xff22C55E),
      const Color(0xff0369A1),
      const Color(0xff1E293B),
      const Color(0xff171717),
      const Color(0xff991B1B),
      const Color(0xff854D0E),
      const Color(0xff0369A1),
    ];

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
          loc.mobileapps,
          style:
              theme.primaryTextTheme.bodyLarge?.copyWith(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            50.verticalSpace,
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10.w),
                  width: 82,
                  height: 82,
                  decoration: BoxDecoration(
                    color: AppColors.bluedarklite,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                5.verticalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Fitbit',
                      style: theme.textTheme.titleSmall
                          ?.copyWith(fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                    8.verticalSpace,
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 14.h,
                        horizontal: 20.w,
                      ),
                      alignment: Alignment.topRight,
                      decoration: BoxDecoration(
                        color: AppColors.goldenlight,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: AppColors.lightGray),
                      ),
                      child: Center(
                        child: Text(
                          loc.connect,
                          style: theme.primaryTextTheme.titleMedium,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            30.verticalSpace,
            Text(
              'According to the National Institutes of Health, nearly half of all adults in the United States have high blood pressure. If left untreated, high bloodAccording to the National Institutes of Health, nearly half of all adults in the United States have high blood pressure. If left untreated, high blood',
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: AppColors.eerieBlack),
            ),
            25.verticalSpace,
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: listcolor.map((e) {
                  return Container(
                    margin: EdgeInsets.only(right: 10.w),
                    width: 143,
                    height: 309,
                    decoration: BoxDecoration(
                      color: e,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  );
                }).toList(),
              ),
            ),
            30.verticalSpace,
          ],
        ),
      ),
    );
  }
}
