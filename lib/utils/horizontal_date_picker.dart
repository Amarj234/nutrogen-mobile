import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/utils/helper.dart';

class DatePicker extends StatelessWidget {
  const DatePicker(
    this.startDate, {
    super.key,
    this.initialSelectedDate,
    this.activeDates,
    this.inactiveDates,
    this.daysCount = 500,
    this.onDateChange,
  });

  final DateTime startDate;
  final DateTime? /*?*/ initialSelectedDate;
  final List<DateTime>? inactiveDates;
  final List<DateTime>? activeDates;
  final Function(DateTime selectedDate)? onDateChange;
  final int daysCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72.h,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            16.horizontalSpace,
            ListView.builder(
              itemCount: daysCount,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              primary: false,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                DateTime date;
                DateTime date0 = startDate.add(Duration(days: index));
                date = DateTime(date0.year, date0.month, date0.day);

                bool isDeactivated = false;
                if (inactiveDates != null) {
                  for (DateTime inactiveDate in inactiveDates!) {
                    if (DateUtils.isSameDay(date, inactiveDate)) {
                      isDeactivated = true;
                      break;
                    }
                  }
                }
                if (activeDates != null) {
                  isDeactivated = true;
                  for (DateTime activateDate in activeDates!) {
                    if (DateUtils.isSameDay(date, activateDate)) {
                      isDeactivated = false;
                      break;
                    }
                  }
                }

                bool isSelected =
                    DateUtils.isSameDay(date, initialSelectedDate);

                return InkWell(
                  borderRadius: BorderRadius.all(Radius.circular(24.r)),
                  child: Container(
                    width: 46.w,
                    margin: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(24.r)),
                      color: isSelected
                          ? AppColors.goldenPoppy
                          : AppColors.transparent,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(6.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            date.day.toString(), // Date
                            style: theme.textTheme.bodyLarge?.copyWith(
                              fontWeight: isSelected
                                  ? FontWeight.w500
                                  : FontWeight.w400,
                              color: isSelected
                                  ? AppColors.white
                                  : AppColors.quickSilver,
                            ),
                          ),
                          Text(
                            DateFormat('EEE').format(date), // WeekDay
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: isSelected
                                  ? FontWeight.w500
                                  : FontWeight.w400,
                              color: isSelected
                                  ? AppColors.white
                                  : AppColors.quickSilver,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    if (isDeactivated) return;

                    onDateChange?.call(date);
                  },
                );
              },
            ),
            20.horizontalSpace,
          ],
        ),
      ),
    );
  }
}
