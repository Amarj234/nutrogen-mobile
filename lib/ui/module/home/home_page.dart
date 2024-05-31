import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/res/app_routers.dart';
import 'package:nutrogen/ui/module/home/home_provider.dart';
import 'package:nutrogen/utils/helper.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isBootomNavHide = useState(false);
    final bottmNavAnimationController = useAnimationController(
      duration: const Duration(milliseconds: 400),
    )..forward();

    void onTap(int page) {
      switch (page) {
        case 1:
          GoRouter.of(context).goNamed(AppRouters.logFood);
          break;
        case 2:
          GoRouter.of(context).goNamed(AppRouters.newsFeed);
          break;
        case 3:
          GoRouter.of(context).goNamed(AppRouters.mealPlans);
          break;
        case 4:
          GoRouter.of(context).goNamed(AppRouters.more);
          break;
        default:
          GoRouter.of(context).goNamed(AppRouters.dashboard);
      }
    }

    int calculateSelectedIndex() {
      final String location = GoRouterState.of(context).uri.path;
      if (location.endsWith(AppRouters.logFood)) {
        return 1;
      } else if (location.endsWith(AppRouters.newsFeed)) {
        return 2;
      } else if (location.endsWith(AppRouters.mealPlans)) {
        return 3;
      } else if (location.endsWith(AppRouters.more)) {
        return 4;
      } else {
        return 0;
      }
    }

    ref.listen(bottomNavHideProvider, (previous, next) {
      if (previous != next) {
        isBootomNavHide.value = next;
        bottmNavAnimationController.reset();
        bottmNavAnimationController.forward();
      }
    });

    return Scaffold(
      body: child,
      extendBody: true,
      bottomNavigationBar: isBootomNavHide.value
          ? 0.verticalSpace
          : SlideTransition(
              position:
                  Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
                      .animate(bottmNavAnimationController),
              child: SizedBox(
                height: Platform.isIOS ? 110.h : 88.h,
                child: Stack(
                  fit: StackFit.expand,
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      AppAssets.pngNavBg,
                      fit: BoxFit.fill,
                    ),
                    BottomNavigationBar(
                      onTap: onTap,
                      showSelectedLabels: true,
                      showUnselectedLabels: true,
                      elevation: 0,
                      selectedItemColor: AppColors.white,
                      unselectedItemColor: AppColors.weldonBlue,
                      selectedLabelStyle: theme.primaryTextTheme.labelMedium,
                      unselectedLabelStyle: theme.primaryTextTheme.labelMedium,
                      currentIndex: calculateSelectedIndex(),
                      backgroundColor: AppColors.transparent,
                      type: BottomNavigationBarType.fixed,
                      items: [
                        navIcon(
                          loc.dashboard,
                          AppAssets.svgDashboard,
                          AppAssets.svgDashboardActive,
                        ),
                        navIcon(
                          loc.logFood,
                          AppAssets.svgLogFood,
                          AppAssets.svgLogFoodActive,
                        ),
                        navIcon(
                          loc.newsFeed,
                          AppAssets.svgNewsFeed,
                          AppAssets.svgNewsFeedActive,
                        ),
                        navIcon(
                          loc.mealPlans,
                          AppAssets.svgMealPlans,
                          AppAssets.svgMealPlansActive,
                        ),
                        navIcon(
                          loc.more,
                          AppAssets.svgMore,
                          AppAssets.svgMoreActive,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  BottomNavigationBarItem navIcon(String level, String svg, String activeSvg) {
    return BottomNavigationBarItem(
      label: level,
      icon: SvgPicture.asset(
        svg,
      ),
      activeIcon: SvgPicture.asset(
        activeSvg,
      ),
    );
  }
}
