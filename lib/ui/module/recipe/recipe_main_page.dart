import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/res/app_routers.dart';
import 'package:nutrogen/ui/module/onbording/widget/stapper_widget.dart';
import 'package:nutrogen/ui/module/recipe/addRecipes/add_racipe_five.dart';
import 'package:nutrogen/ui/module/recipe/addRecipes/add_racipe_four.dart';
import 'package:nutrogen/ui/module/recipe/addRecipes/add_racipe_one.dart';
import 'package:nutrogen/ui/module/recipe/addRecipes/add_racipe_six.dart';
import 'package:nutrogen/ui/module/recipe/addRecipes/add_racipe_three.dart';
import 'package:nutrogen/ui/module/recipe/addRecipes/add_racipe_two.dart';
import 'package:nutrogen/ui/module/recipe/addRecipes/add_recipe_summary.dart';
import 'package:nutrogen/utils/helper.dart';

class RecipeMainPage extends HookConsumerWidget {
  const RecipeMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPage = useState(0);
    final pageCount = useMemoized(() => 7);

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
      backgroundColor: selectedPage.value == 1 ? AppColors.white : null,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          30.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              20.horizontalSpace,
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: onBack,
                icon: SvgPicture.asset(AppAssets.svgClose),
              ),
              15.horizontalSpace,
              Expanded(
                child: StapperWidget(
                  selectedStep: (selectedPage.value + 1),
                  stepCount: pageCount,
                  inactiveTrackColor: selectedPage.value == 1
                      ? AppColors.antiFlashWhite
                      : AppColors.white,
                ),
              ),
              20.horizontalSpace,
            ],
          ),
          Expanded(
            child: IndexedStack(
              index: selectedPage.value,
              children: const [
                AddRecipeOne(),
                AddRecipeTwo(),
                AddRecipeThree(),
                AddRecipeFour(),
                AddRecipeFive(),
                AddRecipeSix(),
                AddRecipeSummary(),
              ],
            ),
          ),
          selectedPage.value == 6
              ? Padding(
                  padding: selectedPage.value == 1
                      ? EdgeInsets.symmetric(horizontal: 20.h)
                      : EdgeInsets.zero,
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: onNext,
                          style: ElevatedButton.styleFrom(
                            side: const BorderSide(color: AppColors.eerieBlack),
                            fixedSize: Size.fromHeight(60.h),
                            backgroundColor: AppColors.white,
                          ),
                          child: Text(
                            loc.makechanges,
                            style: theme.primaryTextTheme.titleMedium
                                ?.copyWith(color: AppColors.eerieBlack),
                          ),
                        ),
                      ),
                      10.horizontalSpace,
                      Expanded(
                        child: ElevatedButton(
                          onPressed: onNext,
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size.fromHeight(60.h),
                          ),
                          child: Text(
                            loc.saveRecipe,
                            style: theme.primaryTextTheme.titleMedium,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    25.verticalSpace,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        children: [
                          Visibility(
                            visible: selectedPage.value != 0,
                            child: IconButton(
                              onPressed: onPrevious,
                              style: IconButton.styleFrom(
                                backgroundColor: AppColors.white,
                                fixedSize: Size(80.w, 60.h),
                              ),
                              icon: SvgPicture.asset(
                                AppAssets.svgBackArrow,
                              ),
                            ),
                          ),
                          10.horizontalSpace,
                          Visibility(
                            visible: selectedPage.value == 0,
                            child: 20.horizontalSpace,
                          ),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: onNext,
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size.fromHeight(60.h),
                              ),
                              child: Text(
                                selectedPage.value == 5
                                    ? loc.addRecipe
                                    : loc.next,
                                style: theme.primaryTextTheme.titleMedium,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: selectedPage.value == 0,
                            child: 20.horizontalSpace,
                          ),
                        ],
                      ),
                    ),
                    15.verticalSpace,
                    Visibility(
                      visible: selectedPage.value != 5,
                      child: Center(
                        child: Text(
                          loc.skipthisstep,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
          20.verticalSpace,
        ],
      ),
    );
  }
}
