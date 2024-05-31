import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/ui/module/onbording/onbording_provider.dart';
import 'package:nutrogen/utils/helper.dart';

class GenratedAiPlanFour extends HookConsumerWidget {
  const GenratedAiPlanFour({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final planList = useMemoized(
      () => [
        'Celery Free',
        'Crustacean-Free',
        'Dairy Free',
        'Eggs Free',
        'Fish Free',
        'Pork-Free',
        'Keto Friendly',
        'Gluten Free',
        'Immuno-Supportive',
        'Paleo',
        'Pescatarian',
        'Peanuts Free',
        'Red Meat Free',
        'Soy-Free',
        'Sugar Conscious',
        'Sesame Free',
        'Tree Nuts Free',
        'Vegan',
        'Vegetarian',
      ],
    );

    final selectedPlanPreference = useState<List<String>>(
      ref.read(registerModelProvider).mealPlanPreference?.split(',') ?? [],
    );
    void onPlanPreference(String text) {
      if (selectedPlanPreference.value.contains(text)) {
        final planList = selectedPlanPreference.value;
        planList.remove(text);
        ref
            .read(registerModelProvider.notifier)
            .setMealPlanPreference([...planList].join(', '));
        selectedPlanPreference.value = [...planList];
        return;
      }
      ref.read(registerModelProvider.notifier).setMealPlanPreference(
            [...selectedPlanPreference.value, text].join(','),
          );
      selectedPlanPreference.value = [...selectedPlanPreference.value, text];
    }

    TextEditingController searchController = TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  loc.healthAllergies,
                  style: theme.textTheme.displaySmall,
                ),
              ],
            ),
            15.verticalSpace,
            Container(
              // margin: EdgeInsets.symmetric(horizontal: 20.w),
              height: 50.h,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(35.r),
              ),
              child: Row(
                children: [
                  20.horizontalSpace,
                  SvgPicture.asset(
                    AppAssets.svgSearchYellow,
                    colorFilter: const ColorFilter.mode(
                      AppColors.quickSilver,
                      BlendMode.srcIn,
                    ),
                  ),
                  6.horizontalSpace,
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: AppColors.smokyBlack,
                      ),
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.only(top: 0, bottom: 0),
                        hintText: loc.search,
                        hintStyle: theme.textTheme.titleSmall?.copyWith(
                          color: AppColors.darkSilver,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            20.verticalSpace,
            Wrap(
              direction: Axis.horizontal,
              runSpacing: 10.w,
              spacing: 10.w,
              children: List.generate(
                planList.length,
                (index) => InkWell(
                  onTap: () => onPlanPreference(planList[index]),
                  borderRadius: BorderRadius.circular(30.r),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 12.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.r),
                      border:
                          selectedPlanPreference.value.contains(planList[index])
                              ? Border.all(
                                  color: AppColors.azureishWhite,
                                  width: 1.w,
                                )
                              : Border.all(
                                  color: AppColors.azureishWhite,
                                  width: 1.w,
                                ),
                      color:
                          selectedPlanPreference.value.contains(planList[index])
                              ? AppColors.mikadoYellow
                              : AppColors.white,
                    ),
                    child: Text(
                      planList[index],
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: selectedPlanPreference.value
                                .contains(planList[index])
                            ? AppColors.white
                            : null,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
