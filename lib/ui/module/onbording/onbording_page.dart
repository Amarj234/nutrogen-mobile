import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/providers.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/res/app_constants.dart';
import 'package:nutrogen/res/app_routers.dart';
import 'package:nutrogen/ui/common/state_popup.dart';
import 'package:nutrogen/ui/module/login/login_provider.dart';
import 'package:nutrogen/ui/module/onbording/onbording_provider.dart';
import 'package:nutrogen/ui/module/onbording/widget/onbording_five_widget.dart';
import 'package:nutrogen/ui/module/onbording/widget/onbording_four_widget.dart';
import 'package:nutrogen/ui/module/onbording/widget/onbording_one_widget.dart';
import 'package:nutrogen/ui/module/onbording/widget/onbording_six_widget.dart';
import 'package:nutrogen/ui/module/onbording/widget/onbording_three_widget.dart';
import 'package:nutrogen/ui/module/onbording/widget/onbording_two_widget.dart';
import 'package:nutrogen/ui/module/onbording/widget/stapper_widget.dart';
import 'package:nutrogen/utils/helper.dart';

class OnbordingPage extends HookConsumerWidget {
  const OnbordingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPage = useState(0);
    final pageCount = useMemoized(() => 6);

    void onBack() {
      context.pop();
    }

    void onPrevious() {
      if (selectedPage.value != 0) {
        selectedPage.value = selectedPage.value - 1;
      } else {
        context.pop();
      }
    }

    void onNext() {
      final request = ref.read(registerModelProvider);
      if (selectedPage.value == 3 && request.achievement == null) {
        showMessage(message: loc.pleaseSelectAchievement);
        return;
      } else if (selectedPage.value == 4 && request.howActiveYourAre == null) {
        showMessage(message: loc.pleaseSelectActiveLevel);
        return;
      } else if (selectedPage.value == 5 && request.mealPerDay == null) {
        showMessage(message: loc.pleaseSelectMealEatenPerDay);
        return;
      } else if (selectedPage.value == 5 &&
          request.mealPlanPreference == null) {
        showMessage(message: loc.pleaseSelectMealPlanPreferences);
        return;
      }

      if (selectedPage.value != (pageCount - 1)) {
        selectedPage.value = selectedPage.value + 1;
      } else {
        ref.read(registerProvider.notifier).registerCall(request: request);
      }
    }

    void onLogin() {
      final request = ref.read(registerModelProvider);
      ref.read(loginProvider.notifier).loginCall(
            email: '${request.email}',
            password: '${request.password}',
          );
    }

    ref.listen(
      loginProvider,
      (previous, next) => onStatePopup(
        next,
        onSuccess: (data) async {
          final request = ref.read(registerModelProvider);
          await ref
              .read(dbServiceProvider)
              .put(key: AppConstants.tokenKey, value: data?.r?.token);
          await ref.read(dbServiceProvider).put(
                key: AppConstants.userKey,
                value: data?.r?.user?.copyWith(password: request.password),
              );

          if (context.mounted) {
            context.goNamed(AppRouters.dashboard);
          }
        },
      ),
    );

    ref.listen(
      registerProvider,
      (previous, next) => onStatePopup(
        next,
        onSuccess: (data) => onLogin(),
      ),
    );

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            50.verticalSpace,
            Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: onBack,
                    icon: SvgPicture.asset(AppAssets.svgClose),
                  ),
                ),
                Text(
                  loc.setUpYourAccount,
                  style: theme.textTheme.titleMedium,
                ),
              ],
            ),
            4.verticalSpace,
            StapperWidget(
              selectedStep: (selectedPage.value + 1),
              stepCount: pageCount,
            ),
            30.verticalSpace,
            Expanded(
              child: IndexedStack(
                index: selectedPage.value,
                children: const [
                  OnbordingOneWidget(),
                  OnbordingTwoWidget(),
                  OnbordingThreeWidget(),
                  OnbordingFourWidget(),
                  OnbordingFiveWidget(),
                  OnbordingSixWidget(),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: onPrevious,
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.white,
                    fixedSize: Size(80.w, 60.h),
                  ),
                  icon: SvgPicture.asset(AppAssets.svgBackArrow),
                ),
                10.horizontalSpace,
                Expanded(
                  child: ElevatedButton(
                    onPressed: onNext,
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size.fromHeight(60.h),
                    ),
                    child: Text(
                      loc.next,
                      style: theme.primaryTextTheme.titleMedium,
                    ),
                  ),
                ),
              ],
            ),
            15.verticalSpace,
          ],
        ),
      ),
    );
  }
}
