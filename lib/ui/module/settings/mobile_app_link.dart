import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/ui/module/settings/widget/app_link_widget.dart';
import 'package:nutrogen/utils/helper.dart';

class MobileAppLink extends StatelessWidget {
  const MobileAppLink({super.key});

  @override
  Widget build(BuildContext context) {
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
            20.verticalSpace,
            Text(
              loc.appnamehere,
              style: theme.textTheme.headlineSmall,
            ),
            10.verticalSpace,
            const AppLinkWidget(
              icon: AppAssets.svgApple,
              link: 'www.links.com/linkink',
            ),
            10.verticalSpace,
            const AppLinkWidget(
              icon: AppAssets.android,
              link: 'www.links.com/linkink',
            ),
            30.verticalSpace,
            Text(
              loc.appnamehere,
              style: theme.textTheme.headlineSmall,
            ),
            10.verticalSpace,
            const AppLinkWidget(
              icon: AppAssets.svgApple,
              link: 'www.links.com/linkink',
            ),
            10.verticalSpace,
            const AppLinkWidget(
              icon: AppAssets.android,
              link: 'www.links.com/linkink',
            ),
            30.verticalSpace,
            Text(
              loc.appnamehere,
              style: theme.textTheme.headlineSmall,
            ),
            10.verticalSpace,
            const AppLinkWidget(
              icon: AppAssets.svgApple,
              link: 'www.links.com/linkink',
            ),
            10.verticalSpace,
            const AppLinkWidget(
              icon: AppAssets.android,
              link: 'www.links.com/linkink',
            ),
            30.verticalSpace,
          ],
        ),
      ),
    );
  }
}
