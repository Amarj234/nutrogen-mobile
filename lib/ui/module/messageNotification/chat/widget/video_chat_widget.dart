import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/res/app_routers.dart';
import 'package:nutrogen/ui/common/image_widget.dart';
import 'package:nutrogen/utils/helper.dart';

class VideoChatWidget extends StatelessWidget {
  const VideoChatWidget({
    required this.isSender,
    required this.videoUrl,
    required this.isPreviousDiffrent,
    super.key,
  });

  final String videoUrl;
  final bool isSender;
  final bool isPreviousDiffrent;

  @override
  Widget build(BuildContext context) {
    void onMediaTap() {
      context.pushNamed(
        AppRouters.fullScreenMedia,
        extra: [videoUrl],
        queryParameters: {'index': '0'},
      );
    }

    return Container(
      margin: EdgeInsets.only(
        left: isSender ? 90.w : 0.w,
        right: isSender ? 0.w : 90.w,
      ),
      child: Column(
        crossAxisAlignment:
            isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(isSender ? 10.r : 0),
                topRight: Radius.circular(10.r),
                bottomLeft: Radius.circular(10.r),
                bottomRight: Radius.circular(isSender ? 0 : 10.r),
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 270.h,
                  child: InkWell(
                    onTap: onMediaTap,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Hero(
                          tag: videoUrl,
                          child: ImageWidget(
                            AppAssets.jpgShopItem,
                            fit: BoxFit.cover,
                            height: double.maxFinite,
                            width: double.maxFinite,
                            radius: 8.r,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: double.maxFinite,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: AppColors.black.withOpacity(
                              0.4,
                            ),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Icon(
                            Icons.play_circle_outline_rounded,
                            size: 50.w,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                6.verticalSpace,
                Text(
                  'Hey👋, Graphic Designer is better than UI UX Designer😎',
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          8.verticalSpace,
          Visibility(
            visible: isPreviousDiffrent,
            child: Column(
              children: [
                Text(
                  isSender ? '1:00 PM • You' : '1:00 PM • Amanda',
                  style: theme.textTheme.bodySmall,
                ),
                30.verticalSpace,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
