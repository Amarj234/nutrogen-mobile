import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/ui/module/genratedAiPlan/widget/selecte_item.dart';
import 'package:nutrogen/utils/helper.dart';

class ShopFiltersWidget extends StatelessWidget {
  const ShopFiltersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedCategory = useState<List<String>>([]);
    final selectedSubCategory = useState<List<String>>([]);
    final selectedSort = useState<List<String>>([]);

    void onCategory(String text) {
      if (selectedCategory.value.contains(text)) {
        final list = selectedCategory.value;
        list.remove(text);

        selectedCategory.value = [...list];
        return;
      }

      selectedCategory.value = [...selectedCategory.value, text];
    }

    void onSubCategory(String text) {
      if (selectedSubCategory.value.contains(text)) {
        final list = selectedSubCategory.value;
        list.remove(text);

        selectedSubCategory.value = [...list];
        return;
      }

      selectedSubCategory.value = [...selectedSubCategory.value, text];
    }

    void onSort(String text) {
      if (selectedSort.value.contains(text)) {
        final list = selectedSort.value;
        list.remove(text);

        selectedSort.value = [...list];
        return;
      }

      selectedSort.value = [...selectedSort.value, text];
    }

    final List<String> planList = [
      'High-Fiber',
      'Low-Fiber',
      'Low-Sodium',
      'Low-Magnesium',
      'Low-Potassium',
      'Low-Iron',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
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
        15.verticalSpace,
        Row(
          children: [
            Expanded(
              child: Text(
                loc.filters_,
                style: theme.textTheme.bodyLarge
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size(50.w, 30.h),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                loc.removeFilters,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.darkSilver,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
        8.verticalSpace,
        Text(
          loc.categories,
          style:
              theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        15.verticalSpace,
        SelectedItem(
          planList: planList,
          selectedList: selectedCategory.value,
          onSelect: onCategory,
        ),
        20.verticalSpace,
        Text(
          loc.subCategory,
          style: theme.textTheme.headlineSmall,
        ),
        15.verticalSpace,
        SelectedItem(
          planList: planList,
          selectedList: selectedSubCategory.value,
          onSelect: onSubCategory,
        ),
        20.verticalSpace,
        Text(
          loc.sort,
          style: theme.textTheme.headlineSmall,
        ),
        15.verticalSpace,
        SelectedItem(
          planList: planList,
          selectedList: selectedSort.value,
          onSelect: onSort,
        ),
        100.verticalSpace,
      ],
    );
  }
}
