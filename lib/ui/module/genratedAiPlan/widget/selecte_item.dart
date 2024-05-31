import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/utils/helper.dart';

class SelectedItem extends HookConsumerWidget {
  const SelectedItem({
    required this.planList,
    required this.selectedList,
    required this.onSelect,
    super.key,
  });
  final List<String> planList;
  final List<String> selectedList;
  final Function(String text) onSelect;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Wrap(
      direction: Axis.horizontal,
      runSpacing: 10.w,
      spacing: 10.w,
      children: List.generate(
        planList.length,
        (index) => InkWell(
          onTap: () => onSelect(planList[index]),
          borderRadius: BorderRadius.circular(30.r),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 18.w,
              vertical: 12.h,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.r),
              border: selectedList.contains(planList[index])
                  ? Border.all(
                      color: AppColors.azureishWhite,
                      width: 1.w,
                    )
                  : Border.all(
                      color: AppColors.azureishWhite,
                      width: 1.w,
                    ),
              color: selectedList.contains(planList[index])
                  ? AppColors.mikadoYellow
                  : AppColors.white,
            ),
            child: Text(
              planList[index],
              style: theme.textTheme.bodyMedium?.copyWith(
                color: selectedList.contains(planList[index])
                    ? AppColors.white
                    : null,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
