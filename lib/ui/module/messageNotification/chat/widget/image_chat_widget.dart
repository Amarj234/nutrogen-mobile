import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/res/app_routers.dart';
import 'package:nutrogen/ui/common/image_widget.dart';
import 'package:nutrogen/utils/helper.dart';

class ImageChatWidget extends StatelessWidget {
  const ImageChatWidget({
    required this.isSender,
    required this.isPreviousDiffrent,
    super.key,
  });

  final bool isSender;
  final bool isPreviousDiffrent;

  @override
  Widget build(BuildContext context) {
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
                  child: ImageListWidget(
                    images: List.generate(1, (index) => AppAssets.jpgPlan),
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

class ImageListWidget extends StatelessWidget {
  const ImageListWidget({required this.images, super.key});

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    void onMediaTap() {
      if (images.length > 1) {
        context.pushNamed(AppRouters.mediaList, extra: images);
      } else {
        context.pushNamed(
          AppRouters.fullScreenMedia,
          extra: images,
          queryParameters: {'index': '0'},
        );
      }
    }

    return InkWell(
      onTap: onMediaTap,
      child: images.length > 1
          ? images.length > 2
              ? images.length > 3
                  ? Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: Hero(
                                  tag: '${images[0]}0',
                                  child: ImageWidget(
                                    images[0],
                                    fit: BoxFit.cover,
                                    height: double.maxFinite,
                                    width: double.maxFinite,
                                    radius: 8.r,
                                  ),
                                ),
                              ),
                              8.verticalSpace,
                              Expanded(
                                child: Hero(
                                  tag: '${images[1]}1',
                                  child: ImageWidget(
                                    images[1],
                                    fit: BoxFit.cover,
                                    height: double.maxFinite,
                                    width: double.maxFinite,
                                    radius: 8.r,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        8.horizontalSpace,
                        Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: Hero(
                                  tag: '${images[2]}2',
                                  child: ImageWidget(
                                    images[2],
                                    fit: BoxFit.cover,
                                    height: double.maxFinite,
                                    width: double.maxFinite,
                                    radius: 8.r,
                                  ),
                                ),
                              ),
                              8.verticalSpace,
                              Expanded(
                                child: Stack(
                                  alignment: Alignment.center,
                                  fit: StackFit.expand,
                                  children: [
                                    Hero(
                                      tag: '${images[3]}3',
                                      child: ImageWidget(
                                        images[3],
                                        fit: BoxFit.cover,
                                        height: double.maxFinite,
                                        width: double.maxFinite,
                                        radius: 8.r,
                                      ),
                                    ),
                                    Visibility(
                                      visible: images.length > 4,
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: double.maxFinite,
                                        width: double.maxFinite,
                                        decoration: BoxDecoration(
                                          color: AppColors.black.withOpacity(
                                            0.4,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                        ),
                                        child: Text(
                                          '4+',
                                          style: theme
                                              .primaryTextTheme.displayLarge,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        Expanded(
                          child: Hero(
                            tag: '${images[0]}0',
                            child: ImageWidget(
                              images[0],
                              fit: BoxFit.cover,
                              height: double.maxFinite,
                              width: double.maxFinite,
                              radius: 8.r,
                            ),
                          ),
                        ),
                        8.horizontalSpace,
                        Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: Hero(
                                  tag: '${images[1]}1',
                                  child: ImageWidget(
                                    images[1],
                                    fit: BoxFit.cover,
                                    height: double.maxFinite,
                                    width: double.maxFinite,
                                    radius: 8.r,
                                  ),
                                ),
                              ),
                              8.verticalSpace,
                              Expanded(
                                child: InkWell(
                                  onTap: () {},
                                  borderRadius: BorderRadius.circular(8.r),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    fit: StackFit.expand,
                                    children: [
                                      Hero(
                                        tag: '${images[2]}2',
                                        child: ImageWidget(
                                          images[2],
                                          fit: BoxFit.cover,
                                          height: double.maxFinite,
                                          width: double.maxFinite,
                                          radius: 8.r,
                                        ),
                                      ),
                                      Visibility(
                                        visible: images.length > 3,
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: double.maxFinite,
                                          width: double.maxFinite,
                                          decoration: BoxDecoration(
                                            color: AppColors.black.withOpacity(
                                              0.4,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                          ),
                                          child: Text(
                                            '3+',
                                            style: theme
                                                .primaryTextTheme.displayLarge,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
              : Row(
                  children: [
                    Expanded(
                      child: Hero(
                        tag: '${images[0]}0',
                        child: ImageWidget(
                          images[0],
                          fit: BoxFit.cover,
                          height: double.maxFinite,
                          width: double.maxFinite,
                          radius: 8.r,
                        ),
                      ),
                    ),
                    8.horizontalSpace,
                    Expanded(
                      child: Hero(
                        tag: '${images[1]}1',
                        child: ImageWidget(
                          images[1],
                          fit: BoxFit.cover,
                          height: double.maxFinite,
                          width: double.maxFinite,
                          radius: 8.r,
                        ),
                      ),
                    ),
                  ],
                )
          : Hero(
              tag: '${images[0]}0',
              child: ImageWidget(
                images[0],
                fit: BoxFit.cover,
                height: double.maxFinite,
                width: double.maxFinite,
                radius: 8.r,
              ),
            ),
    );
  }
}
