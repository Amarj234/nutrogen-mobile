import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/ui/common/input_textfield.dart';
import 'package:nutrogen/ui/module/genratedAiPlan/widget/selecte_item.dart';
import 'package:nutrogen/utils/helper.dart';

class UsePecentage extends HookConsumerWidget {
  const UsePecentage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> planList = [
      'High-Fiber',
      'Low-Fiber',
      'Low-Sodium',
      'Low-Magnesium',
      'Low-Potassium',
      'Low-Iron',
    ];
    final proteinPerDay = useTextEditingController();
    final fatPerDay = useTextEditingController();
    final carbsPerDay = useTextEditingController();

    final selectedDietaryRequirements = useState<List<String>>([]);

    void onDietaryRequirements(String text) {
      if (selectedDietaryRequirements.value.contains(text)) {
        final list = selectedDietaryRequirements.value;
        list.remove(text);

        selectedDietaryRequirements.value = [...list];
        return;
      }

      selectedDietaryRequirements.value = [
        ...selectedDietaryRequirements.value,
        text,
      ];
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        20.verticalSpace,
        Text(
          loc.proteinperday,
          style: theme.textTheme.headlineSmall,
        ),
        10.verticalSpace,
        InputTextfield(
          hint: '5',
          mycon: proteinPerDay,
          bordercolor: AppColors.lightGray,
          fillcolor: AppColors.white,
        ),
        20.verticalSpace,
        Text(
          loc.fatperday,
          style: theme.textTheme.headlineSmall,
        ),
        10.verticalSpace,
        InputTextfield(
          hint: '5',
          mycon: fatPerDay,
          bordercolor: AppColors.lightGray,
          fillcolor: AppColors.white,
        ),
        20.verticalSpace,
        Text(
          loc.carbsperday,
          style: theme.textTheme.headlineSmall,
        ),
        10.verticalSpace,
        InputTextfield(
          hint: '5',
          mycon: carbsPerDay,
          bordercolor: AppColors.lightGray,
          fillcolor: AppColors.white,
        ),
        20.verticalSpace,
        Text(
          loc.specificDietaryRequirements,
          style: theme.textTheme.headlineSmall,
        ),
        15.verticalSpace,
        SelectedItem(
          planList: planList,
          selectedList: selectedDietaryRequirements.value,
          onSelect: onDietaryRequirements,
        ),
      ],
    );
  }
}
