import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/ui/module/onbording/widget/active_sheet_widget.dart';
import 'package:nutrogen/utils/helper.dart';

class SelectorButtonWidget extends StatelessWidget {
  const SelectorButtonWidget({
    required this.title,
    required this.selectedGoal,
    required this.onTap,
    this.tooltipText,
    super.key,
  });

  final String title;
  final String? selectedGoal;
  final VoidCallback onTap;
  final String? tooltipText;

  @override
  Widget build(BuildContext context) {
    void onTooltip() {
      showModalBottomSheet(
        context: context,
        backgroundColor: AppColors.white,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
        ),
        builder: (context) => ActiveSheetWidget(
          title: loc.activity(title),
          text: '$tooltipText',
        ),
      );
    }

    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: EdgeInsets.only(left: 20.w, right: 12.w),
        fixedSize: Size.fromHeight(56.h),
        backgroundColor: title == selectedGoal ? null : AppColors.white,
        side: BorderSide(color: AppColors.azureishWhite, width: 1.w),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Visibility(
            visible: tooltipText != null,
            child: Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: onTooltip,
                child: SvgPicture.asset(AppAssets.svgTooltip),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 40.w, right: 40.w),
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: title == selectedGoal
                  ? theme.primaryTextTheme.bodyMedium
                  : theme.textTheme.bodyMedium,
            ),
          ),
          Visibility(
            visible: title == selectedGoal,
            child: Align(
              alignment: Alignment.centerRight,
              child: SvgPicture.asset(AppAssets.svgTick),
            ),
          ),
        ],
      ),
    );
  }
}
