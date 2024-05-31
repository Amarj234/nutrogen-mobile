import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/utils/helper.dart';
import 'package:nutrogen/utils/horizontal_date_picker.dart';
import 'package:nutrogen/ui/module/aiGenerateMealPlan/widget/breakfast_edit_widget.dart';

class MealDetails extends HookConsumerWidget {
  const MealDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = useState(DateTime.now());

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          1.verticalSpace,
          Container(
            color: Colors.white,
            height: 6,
          ),
          Container(
            padding: EdgeInsets.only(bottom: 10.h),
            width: MediaQuery.of(context).size.width,
            color: AppColors.white,
            child: DatePicker(
              DateTime.now(),
              initialSelectedDate: selectedDate.value,
              onDateChange: (date) {
                selectedDate.value = date;
              },
            ),
          ),
          15.verticalSpace,
          Container(
            width: 1.sw,
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
            ),
            child: ListView.separated(
              itemCount: 3,
              primary: false,
              shrinkWrap: true,
              separatorBuilder: (context, index) => 15.verticalSpace,
              itemBuilder: (context, index) => BreakfastEditWidget(
                onAddMeal: () {},
                title: index == 0
                    ? 'Breakfast'
                    : index == 1
                        ? 'Lunch'
                        : 'Snacks',
              ),
            ),
          ),
          100.verticalSpace,
          Center(
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                loc.followThisPlan,
                style: theme.primaryTextTheme.headlineSmall,
              ),
            ),
          ),
          40.verticalSpace,
        ],
      ),
    );
  }
}
