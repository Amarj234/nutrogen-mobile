import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/ui/common/image_widget.dart';
import 'package:nutrogen/utils/helper.dart';

class NotificationPage extends HookConsumerWidget {
  const NotificationPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onClose() {
      context.pop();
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 88.h,
        backgroundColor: AppColors.white,
        flexibleSpace: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              bottom: 20.h,
              child: Text(
                loc.notifications,
                style: theme.textTheme.bodyLarge
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            Positioned(
              left: 10.w,
              bottom: 10.h,
              child: IconButton(
                onPressed: onClose,
                padding: EdgeInsets.zero,
                icon: SvgPicture.asset(AppAssets.svgCloseGray),
              ),
            ),
          ],
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(20.w),
        itemBuilder: (context, index) => const NotificationWidget(),
        separatorBuilder: (context, index) => Divider(
          color: AppColors.brightGray,
          height: 40.h,
          thickness: 1.h,
        ),
        itemCount: 20,
      ),
    );
  }
}

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ImageWidget(
              AppAssets.jpgReview,
              width: 50.w,
              height: 50.w,
              radius: 50.r,
            ),
            12.horizontalSpace,
            Expanded(
              child: Text.rich(
                TextSpan(
                  text:
                      'uch as Greek-stylenonfat plain straineuch as Greek-stylenonfat',
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(color: AppColors.graniteGray, height: 1.4),
                  children: [
                    WidgetSpan(child: 4.horizontalSpace),
                    TextSpan(
                      text: 'plain straine',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.graniteGray,
                        fontWeight: FontWeight.w700,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        8.verticalSpace,
        Container(
          margin: EdgeInsets.only(left: 62.w),
          child: Text(
            '1 hr ago',
            style: theme.textTheme.labelLarge
                ?.copyWith(color: AppColors.spanishGray),
          ),
        ),
      ],
    );
  }
}
