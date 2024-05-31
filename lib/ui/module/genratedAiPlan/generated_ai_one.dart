import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/ui/common/input_textfields.dart';
import 'package:nutrogen/ui/module/onbording/onbording_provider.dart';
import 'package:nutrogen/utils/helper.dart';

class GenratedAiOne extends HookConsumerWidget {
  const GenratedAiOne({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedEatenPerDay =
        useState<String?>(ref.read(registerModelProvider).mealPerDay);
    final carbsPerDaycon = useTextEditingController();
    final chooseStartDate = useTextEditingController();
    final howManyDay = useTextEditingController();
    void onEatenPerDay(String text) {
      ref.read(registerModelProvider.notifier).setMealPerDay(text);
      selectedEatenPerDay.value = text;
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  child: Text(
                    loc.addinformation,
                    style: theme.textTheme.displaySmall,
                  ),
                ),
              ],
            ),
            20.verticalSpace,
            Text(
              loc.choosestartdate,
              style: theme.textTheme.headlineSmall,
            ),
            10.verticalSpace,
            InputTextfields(
              onSuffix: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                chooseStartDate.text =
                    DateFormat('dd/MM/yyyy').format(pickedDate!);
              },
              isIcon: true,
              readonly: true,
              icon: AppAssets.date,
              hint: '23 May, 2023',
              controller: chooseStartDate,
              bordercolor: AppColors.lightGray,
              fillcolor: AppColors.white,
            ),
            20.verticalSpace,
            Text(
              loc.carbsperday,
              style: theme.textTheme.headlineSmall,
            ),
            10.verticalSpace,
            InputTextfields(
              hint: '5',
              controller: carbsPerDaycon,
              bordercolor: AppColors.lightGray,
              fillcolor: AppColors.white,
            ),
            20.verticalSpace,
            Text(
              loc.mealsEatenPerDay,
              style: theme.textTheme.headlineSmall,
            ),
            10.verticalSpace,
            Wrap(
              direction: Axis.horizontal,
              spacing: 16.w,
              children: List.generate(
                4,
                (index) => InkWell(
                  onTap: () => onEatenPerDay('${index + 3}'),
                  borderRadius: BorderRadius.circular(30.r),
                  child: Container(
                    width: 38.w,
                    height: 38.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: selectedEatenPerDay.value == '${index + 3}'
                          ? null
                          : Border.all(
                              color: AppColors.azureishWhite,
                              width: 1.w,
                            ),
                      color: selectedEatenPerDay.value == '${index + 3}'
                          ? AppColors.blueberry
                          : AppColors.white,
                    ),
                    child: Text(
                      '${index + 3}',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: selectedEatenPerDay.value == '${index + 3}'
                            ? AppColors.white
                            : null,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            20.verticalSpace,
            Text(
              loc.howmanydays,
              style: theme.textTheme.headlineSmall,
            ),
            10.verticalSpace,
            InputTextfields(
              hint: '5',
              controller: howManyDay,
              bordercolor: AppColors.lightGray,
              fillcolor: AppColors.white,
            ),
          ],
        ),
      ),
    );
  }
}
