import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/ui/common/state_view.dart';
import 'package:nutrogen/ui/module/onbording/onbording_provider.dart';
import 'package:nutrogen/utils/helper.dart';

class OnbordingSixWidget extends HookConsumerWidget {
  const OnbordingSixWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedEatenPerDay =
        useState<String?>(ref.read(registerModelProvider).mealPerDay);
    final selectedPlanPreference = useState<List<String>>(
      ref.read(registerModelProvider).mealPlanPreference?.split(',') ?? [],
    );

    void onEatenPerDay(String text) {
      ref.read(registerModelProvider.notifier).setMealPerDay(text);
      selectedEatenPerDay.value = text;
    }

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            loc.mealPreference,
            style: theme.textTheme.displaySmall,
          ),
        ),
        30.verticalSpace,
        Consumer(
          builder: (context, ref, child) {
            final propData = ref.watch(registerPropProvider(type: '4'));
            return onStateView(
              propData,
              child: (data) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data?[0].propName ?? loc.mealsEatenPerDay,
                    style: theme.textTheme.headlineSmall,
                  ),
                  10.verticalSpace,
                  Wrap(
                    direction: Axis.horizontal,
                    spacing: 16.w,
                    children: List.generate(
                      data?.length ?? 0,
                      (index) => InkWell(
                        onTap: () => onEatenPerDay(
                          '${data?[index].propAlternativeName}',
                        ),
                        borderRadius: BorderRadius.circular(30.r),
                        child: Container(
                          width: 38.w,
                          height: 38.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: selectedEatenPerDay.value ==
                                    '${data?[index].propAlternativeName}'
                                ? null
                                : Border.all(
                                    color: AppColors.azureishWhite,
                                    width: 1.w,
                                  ),
                            color: selectedEatenPerDay.value ==
                                    '${data?[index].propAlternativeName}'
                                ? AppColors.blueberry
                                : AppColors.white,
                          ),
                          child: Text(
                            '${data?[index].propAlternativeName}',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              color: selectedEatenPerDay.value ==
                                      '${data?[index].propAlternativeName}'
                                  ? AppColors.white
                                  : null,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        30.verticalSpace,
        Consumer(
          builder: (context, ref, child) {
            final propData = ref.watch(registerPropProvider(type: '3'));
            return onStateView(
              propData,
              child: (data) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data?[0].propName ?? loc.mealPlanPreferences,
                    style: theme.textTheme.headlineSmall,
                  ),
                  14.verticalSpace,
                  Wrap(
                    direction: Axis.horizontal,
                    runSpacing: 10.w,
                    spacing: 10.w,
                    children: List.generate(
                      data?.length ?? 0,
                      (index) => InkWell(
                        onTap: () => onPlanPreference(
                          '${data?[index].propAlternativeName}',
                        ),
                        borderRadius: BorderRadius.circular(30.r),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 12.h,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.r),
                            border: selectedPlanPreference.value.contains(
                              '${data?[index].propAlternativeName}',
                            )
                                ? null
                                : Border.all(
                                    color: AppColors.azureishWhite,
                                    width: 1.w,
                                  ),
                            color: selectedPlanPreference.value.contains(
                              '${data?[index].propAlternativeName}',
                            )
                                ? AppColors.mikadoYellow
                                : AppColors.white,
                          ),
                          child: Text(
                            '${data?[index].propAlternativeName}',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              color: selectedPlanPreference.value.contains(
                                '${data?[index].propAlternativeName}',
                              )
                                  ? AppColors.white
                                  : null,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
