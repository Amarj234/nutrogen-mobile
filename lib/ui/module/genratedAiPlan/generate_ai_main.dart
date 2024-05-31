import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/res/app_routers.dart';
import 'package:nutrogen/ui/module/genratedAiPlan/generated_ai_five.dart';
import 'package:nutrogen/ui/module/genratedAiPlan/generated_ai_four.dart';
import 'package:nutrogen/ui/module/genratedAiPlan/generated_ai_one.dart';
import 'package:nutrogen/ui/module/genratedAiPlan/generated_ai_plan_three.dart';
import 'package:nutrogen/ui/module/genratedAiPlan/generated_ai_six.dart';
import 'package:nutrogen/ui/module/genratedAiPlan/genrated_ai_plan_page.dart';
import 'package:nutrogen/ui/module/onbording/widget/stapper_widget.dart';
import 'package:nutrogen/utils/helper.dart';

class GenerateAiMain extends HookConsumerWidget {
  const GenerateAiMain({super.key});

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
      // final request = ref.read(registerModelProvider);
      // if (selectedPage.value == 3 && request.achievement == null) {
      //   showMessage(message: loc.pleaseSelectAchievement);
      //   return;
      // } else if (selectedPage.value == 4 && request.howActiveYourAre == null) {
      //   showMessage(message: loc.pleaseSelectActiveLevel);
      //   return;
      // } else if (selectedPage.value == 5 && request.mealPerDay == null) {
      //   showMessage(message: loc.pleaseSelectMealEatenPerDay);
      //   return;
      // } else if (selectedPage.value == 5 &&
      //     request.mealPlanPreference == null) {
      //   showMessage(message: loc.pleaseSelectMealPlanPreferences);
      //   return;
      // }

      if (selectedPage.value != (pageCount - 1)) {
        selectedPage.value = selectedPage.value + 1;
      } else {
        context.pushNamed(AppRouters.aiGenerateMealPlan);
        // ref.read(registerProvider.notifier).registerCall(request: request);
      }
    }

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            20.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: onBack,
                  icon: SvgPicture.asset(AppAssets.svgClose),
                ),
                SizedBox(
                  width: 330.w,
                  child: StapperWidget(
                    selectedStep: (selectedPage.value + 1),
                    stepCount: pageCount,
                  ),
                ),
              ],
            ),
            Expanded(
              child: IndexedStack(
                index: selectedPage.value,
                children: const [
                  GenratedAiOne(),
                  GenratedAiPlanPage(),
                  GenratedAiPlanThree(),
                  GenratedAiPlanFour(),
                  GenratedAiFive(),
                  GenratedAiPlanSix(),
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
            Center(
              child: Text(
                loc.skipthisstep,
                style: theme.textTheme.bodyMedium?.copyWith(
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
