import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/res/app_routers.dart';

class GoRouteObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness:
            route.settings.name == AppRouters.productDetails ||
                    route.settings.name == AppRouters.recipeDetails ||
                    route.settings.name == AppRouters.mealPlanDetails
                ? Brightness.light
                : Brightness.dark,
        statusBarColor: AppColors.transparent,
        systemNavigationBarColor: AppColors.transparent,
      ),
    );
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: previousRoute?.settings.name ==
                    AppRouters.productDetails ||
                previousRoute?.settings.name == AppRouters.recipeDetails ||
                previousRoute?.settings.name == AppRouters.mealPlanDetails ||
                route.settings.name == AppRouters.fullScreenMedia
            ? Brightness.light
            : Brightness.dark,
        statusBarColor: AppColors.transparent,
        systemNavigationBarColor: AppColors.transparent,
      ),
    );
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    // print('MyTest didRemove: $route');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    // print('MyTest didReplace: $newRoute');
  }
}
