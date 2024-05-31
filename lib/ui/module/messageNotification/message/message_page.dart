import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/res/app_routers.dart';
import 'package:nutrogen/utils/helper.dart';

class MessagePage extends HookConsumerWidget {
  const MessagePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();

    void onClose() {
      context.pop();
    }

    void onAdd() {
      context.pushNamed(AppRouters.friendsDailyTask);
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 65.h,
        backgroundColor: AppColors.white,
        flexibleSpace: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                15.horizontalSpace,
                IconButton(
                  onPressed: onClose,
                  padding: EdgeInsets.zero,
                  icon: SvgPicture.asset(AppAssets.svgCloseGray),
                ),
                Expanded(
                  child: TextField(
                    controller: searchController,
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: AppColors.smokyBlack,
                    ),
                    decoration: InputDecoration(
                      isDense: true,
                      filled: true,
                      fillColor: AppColors.antiFlashWhite,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.r),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.r),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.r),
                        borderSide: BorderSide.none,
                      ),
                      prefixIconConstraints: BoxConstraints(
                        maxHeight: 20.w,
                        maxWidth: 40.w,
                      ),
                      prefixIcon: Align(
                        alignment: Alignment.centerRight,
                        child: SvgPicture.asset(
                          AppAssets.svgSearchYellow,
                          colorFilter: const ColorFilter.mode(
                            AppColors.quickSilver,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 12.h,
                      ),
                      hintText: loc.search,
                      hintStyle: theme.textTheme.titleSmall?.copyWith(
                        color: AppColors.quickSilver,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: onAdd,
                  padding: EdgeInsets.zero,
                  icon: SvgPicture.asset(AppAssets.svgPlusBg),
                ),
                15.horizontalSpace,
              ],
            ),
            8.verticalSpace,
          ],
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        itemCount: 8,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              context.pushNamed(AppRouters.chat);
            },
            contentPadding: EdgeInsets.zero,
            title: Text(
              'Desirae Schleifer',
              style: theme.textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              'Hey There what\'s up? is everything a...',
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
                  image: AssetImage(AppAssets.avatar),
                  fit: BoxFit.cover,
                ),
              ),
              child: Align(
                alignment: Alignment.bottomRight,
                child: SvgPicture.asset(
                  AppAssets.online,
                  width: 12,
                  height: 12,
                ),
              ),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '04:43',
                  style: theme.textTheme.labelLarge,
                ),
                6.verticalSpace,
                Visibility(
                  visible: true,
                  replacement: Container(
                    width: 20.w,
                    height: 20.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.r),
                      color: AppColors.blue,
                    ),
                    child: Text(
                      '2+',
                      style: theme.primaryTextTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  child: SvgPicture.asset(AppAssets.svgDoubleTick),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
