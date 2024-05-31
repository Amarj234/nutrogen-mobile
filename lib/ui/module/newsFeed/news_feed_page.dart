import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/res/app_routers.dart';
import 'package:nutrogen/ui/module/newsFeed/widget/feed_post_widget.dart';
import 'package:nutrogen/ui/module/newsFeed/widget/feed_racipe_widget.dart';
import 'package:nutrogen/ui/module/newsFeed/widget/normal_post_widget.dart';
import 'package:nutrogen/utils/helper.dart';

class NewsFeedPage extends HookConsumerWidget {
  const NewsFeedPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
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
              child: SvgPicture.asset(AppAssets.messageicon),
            ),
            onPressed: () {
              context.pushNamed(AppRouters.message);
            },
          ),
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
              context.pushNamed(AppRouters.createNewsFeed);
            },
          ),
        ],
        title: Text(
          loc.newsFeed,
          style:
              theme.primaryTextTheme.bodyLarge?.copyWith(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    context.pushNamed(AppRouters.newsFeedDetails);
                  },
                  child: const FeedPostWidget(
                    buttontxt: 'Weekly challenge',
                    isshowpoint: true,
                    isshowActive: true,
                  ),
                ),
                const FeedRacipeWidget(
                  buttontxt: 'Weekly challenge',
                  isshowpoint: true,
                  isshowActive: true,
                ),
                const NormalPostWidget(
                  buttontxt: 'Weekly challenge',
                  isshowpoint: true,
                  isshowActive: true,
                ),
                20.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
