import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/data/model/recipe_level_model.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/utils/helper.dart';

class AllergyFilters extends HookConsumerWidget {
  const AllergyFilters({
    required this.recipeLevelData,
    required this.onApply,
    required this.selectedRecipeLevel,
    super.key,
  });

  final MapEntry<Pcid?, List<RecipeLevelData>?>? recipeLevelData;
  final List<RecipeLevelData>? selectedRecipeLevel;
  final Function(MapEntry<Pcid?, List<RecipeLevelData>?> levelData) onApply;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFilterPreference =
        useState<List<RecipeLevelData>>([...?selectedRecipeLevel]);

    void onFilter(RecipeLevelData? levelData) {
      if (selectedFilterPreference.value.contains(levelData)) {
        final recipeList = selectedFilterPreference.value;
        recipeList.remove(levelData);

        selectedFilterPreference.value = [...recipeList];
        return;
      }

      selectedFilterPreference.value = [
        ...selectedFilterPreference.value,
        levelData!,
      ];
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          15.verticalSpace,
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: 42.w,
              child: Divider(
                color: AppColors.platinum,
                thickness: 4.h,
              ),
            ),
          ),
          16.verticalSpace,
          Text(
            '${recipeLevelData?.key?.categoryName}:',
            style: theme.textTheme.bodyLarge
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          10.verticalSpace,
          Text(
            loc.selectexclude,
            style: theme.textTheme.titleSmall
                ?.copyWith(color: AppColors.darkSilver),
          ),
          20.verticalSpace,
          Wrap(
            direction: Axis.horizontal,
            runSpacing: 10.w,
            spacing: 10.w,
            children: List.generate(
              recipeLevelData?.value?.length ?? 0,
              (index) => InkWell(
                onTap: () => onFilter(recipeLevelData?.value?[index]),
                borderRadius: BorderRadius.circular(30.r),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.r),
                    border: selectedFilterPreference.value
                            .contains(recipeLevelData?.value?[index])
                        ? Border.all(
                            color: AppColors.azureishWhite,
                            width: 1.w,
                          )
                        : Border.all(
                            color: AppColors.azureishWhite,
                            width: 1.w,
                          ),
                    color: selectedFilterPreference.value
                            .contains(recipeLevelData?.value?[index])
                        ? AppColors.mikadoYellow
                        : AppColors.white,
                  ),
                  child: Text(
                    '${recipeLevelData?.value?[index].categoryName}',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: selectedFilterPreference.value
                              .contains(recipeLevelData?.value?[index])
                          ? AppColors.white
                          : null,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          ),
          30.verticalSpace,
          Center(
            child: ElevatedButton(
              onPressed: () {
                context.pop();
                onApply(
                  MapEntry(
                    recipeLevelData?.key,
                    selectedFilterPreference.value,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50.w),
              ),
              child: Text(
                loc.apply,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          30.verticalSpace,
        ],
      ),
    );
  }
}
