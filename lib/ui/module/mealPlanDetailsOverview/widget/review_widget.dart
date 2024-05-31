import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/utils/helper.dart';

class ReviewWidget extends StatelessWidget {
  const ReviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.w,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50.r),
                child: Image.asset(
                  AppAssets.jpgReview,
                  width: 40.w,
                  height: 40.w,
                ),
              ),
              15.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Samantha Payne',
                      style: theme.textTheme.headlineSmall,
                    ),
                    2.verticalSpace,
                    Text(
                      '@Sam.Payne90',
                      style: theme.textTheme.titleSmall
                          ?.copyWith(color: AppColors.darkSilver),
                    ),
                    4.verticalSpace,
                    RatingBar(
                      initialRating: 3.5,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 20.w,
                      minRating: 1,
                      ignoreGestures: true,
                      ratingWidget: RatingWidget(
                        full: SvgPicture.asset(AppAssets.svgRateFull),
                        half: SvgPicture.asset(AppAssets.svgRateHalf),
                        empty: SvgPicture.asset(AppAssets.svgRateEmpty),
                      ),
                      itemPadding: EdgeInsets.symmetric(horizontal: 2.w),
                      onRatingUpdate: (rating) {},
                    ),
                  ],
                ),
              ),
            ],
          ),
          24.verticalSpace,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: AppColors.cultured,
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  AppAssets.svgRightBg,
                ),
                8.horizontalSpace,
                Text(
                  loc.verifiedPurchase,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: AppColors.darkMidnightBlue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          8.verticalSpace,
          Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit ut aliquam, purus sit amet luctus venenatis, lectus magna fringilla urna, porttitor rhoncus dolor purus non enim praesent elementum facilisis leo, vel',
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyMedium,
          ),
          const Spacer(),
          Text(
            '23 Nov 2021',
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.titleSmall
                ?.copyWith(color: AppColors.darkSilver),
          ),
        ],
      ),
    );
  }
}
