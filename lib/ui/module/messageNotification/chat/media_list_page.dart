import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/res/app_routers.dart';
import 'package:nutrogen/ui/common/image_widget.dart';
import 'package:nutrogen/utils/helper.dart';

class MediaListPage extends HookConsumerWidget {
  const MediaListPage({required this.media, super.key});

  final List<String> media;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useListenable(useScrollController());

    onMedia(int index) {
      context.pushNamed(
        AppRouters.fullScreenMedia,
        extra: media,
        queryParameters: {'index': '$index'},
      );
    }

    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverAppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarIconBrightness:
                  scrollController.hasClients && scrollController.offset > 10
                      ? Brightness.light
                      : Brightness.dark,
              statusBarColor: AppColors.transparent,
              systemNavigationBarColor: AppColors.transparent,
            ),
            automaticallyImplyLeading: false,
            toolbarHeight: 70.h,
            pinned: true,
            backgroundColor: scrollController.hasClients
                ? scrollController.offset > 10
                    ? AppColors.black.withOpacity(0.4)
                    : AppColors.white
                : AppColors.white,
            flexibleSpace: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    4.horizontalSpace,
                    IconButton(
                      onPressed: () {
                        context.pop();
                      },
                      icon: SvgPicture.asset(
                        AppAssets.svgArrowBack,
                        colorFilter: ColorFilter.mode(
                          scrollController.hasClients
                              ? scrollController.offset < 10
                                  ? AppColors.graniteGray
                                  : AppColors.white
                              : AppColors.graniteGray,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    10.horizontalSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Amanda',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: scrollController.hasClients
                                  ? scrollController.offset > 10
                                      ? AppColors.white
                                      : AppColors.eerieBlack
                                  : AppColors.eerieBlack,
                            ),
                          ),
                          Text(
                            '6 photos • 10 Febuary 2024',
                            style: theme.textTheme.titleSmall
                                ?.copyWith(color: AppColors.goldenPoppy),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                10.verticalSpace,
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: media.length,
              (context, index) => Column(
                children: [
                  10.verticalSpace,
                  InkWell(
                    onTap: () => onMedia(index),
                    child: IntrinsicHeight(
                      child: Stack(
                        children: [
                          Hero(
                            tag: '${media[index]}$index',
                            child: ImageWidget(
                              media[index],
                              width: 1.sw,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              height: 40.h,
                              width: 80.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    AppColors.transparent,
                                    AppColors.black.withOpacity(0.1),
                                    AppColors.black.withOpacity(0.2),
                                  ],
                                  stops: const [0.1, 0.4, 0.8],
                                ),
                              ),
                              child: Text(
                                '6:26 pm',
                                style: theme.primaryTextTheme.bodySmall,
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
          ),
        ],
      ),
    );
  }
}
