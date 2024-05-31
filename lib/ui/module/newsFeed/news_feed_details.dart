import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/ui/module/newsFeed/widget/feed_post_widget.dart';
import 'package:nutrogen/utils/helper.dart';

class NewsFeedDetails extends HookConsumerWidget {
  const NewsFeedDetails({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    RichText convertHashtag(String text) {
      List<String> split = text.split(RegExp('#'));
      List<String> hashtags = split.getRange(1, split.length).fold([], (t, e) {
        var texts = e.split(' ');
        if (texts.length > 1) {
          return List.from(t)
            ..addAll(['#${texts.first}', (e.substring(texts.first.length))]);
        }
        return List.from(t)..add('#${texts.first}');
      });
      return RichText(
        text: TextSpan(
          children: [
            TextSpan(text: split.first, style: theme.textTheme.bodyMedium),
            ...hashtags.map(
              (text) => text.contains('#')
                  ? TextSpan(
                      text: text,
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: AppColors.blueberry),
                    )
                  : TextSpan(text: text, style: theme.textTheme.bodyMedium),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: SvgPicture.asset(AppAssets.svgCloseGray),
          onPressed: () {
            context.pop();
          },
        ),
        title: Text(
          loc.post,
          style:
              theme.primaryTextTheme.bodyLarge?.copyWith(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const FeedPostWidget(
                  buttontxt: 'Weekly challenge',
                  isshowpoint: true,
                  isshowActive: true,
                ),
                20.verticalSpace,
                ListTile(
                  titleAlignment: ListTileTitleAlignment.top,
                  onTap: () {},
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    'kiero_d @kiero_d ·2d',
                    style: theme.textTheme.headlineSmall
                        ?.copyWith(fontWeight: FontWeight.w500),
                  ),
                  subtitle: convertHashtag(
                    'Interesting Nicola that not one reply or tag on this #UX talent shout out in the 24hrs since your tweet here......🤔',
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
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 78.w),
                  child: Text(
                    '1 reply',
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: AppColors.blueberry),
                  ),
                ),
                10.verticalSpace,
                ListTile(
                  titleAlignment: ListTileTitleAlignment.top,
                  onTap: () {},
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    'kiero_d @kiero_d ·2d',
                    style: theme.textTheme.headlineSmall
                        ?.copyWith(fontWeight: FontWeight.w500),
                  ),
                  subtitle: convertHashtag(
                    'Interesting Nicola that not one reply or tag on this #UX talent shout out in the 24hrs since your tweet here......🤔',
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
                  ),
                ),
                10.verticalSpace,
                ListTile(
                  titleAlignment: ListTileTitleAlignment.top,
                  onTap: () {},
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    'kiero_d @kiero_d ·2d',
                    style: theme.textTheme.headlineSmall
                        ?.copyWith(fontWeight: FontWeight.w500),
                  ),
                  subtitle: convertHashtag(
                    'Interesting Nicola that not one reply or tag on this #UX talent shout out in the 24hrs since your tweet here......🤔',
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
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
