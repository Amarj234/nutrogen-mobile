import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/ui/common/input_textfields.dart';
import 'package:nutrogen/utils/helper.dart';

class AddRecipeFour extends HookConsumerWidget {
  const AddRecipeFour({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchControllerList =
        useState([TextEditingController(text: 'Step 1')]);

    void reorder(int oldIndex, int newIndex) {
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }
      final item = searchControllerList.value.removeAt(oldIndex);
      searchControllerList.value.insert(newIndex, item);
    }

    void onNewStep() {
      searchControllerList.value = [
        ...searchControllerList.value,
        TextEditingController(
          text: 'Step ${searchControllerList.value.length + 1}',
        ),
      ];
    }

    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            loc.cookingsteps,
            style: theme.textTheme.displaySmall,
          ),
          10.verticalSpace,
          Container(
            padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 20.w),
            decoration: BoxDecoration(
              color: AppColors.blueberry,
              borderRadius: BorderRadius.circular(27.r),
            ),
            child: Text(
              loc.autogeneratecookingsteps,
              style:
                  theme.textTheme.titleMedium?.copyWith(color: AppColors.white),
            ),
          ),
          20.verticalSpace,
          ReorderableListView.builder(
            shrinkWrap: true,
            primary: false,
            physics: const ClampingScrollPhysics(),
            itemCount: searchControllerList.value.length,
            onReorder: reorder,
            itemBuilder: (context, index) {
              return Row(
                key: Key('$index'),
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: SvgPicture.asset(AppAssets.sixDot),
                  ),
                  10.horizontalSpace,
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: InputTextfields(
                        textcolor: AppColors.darkSilver,
                        maxLines: 3,
                        hint: searchControllerList.value[index].text,
                        controller: searchControllerList.value[index],
                        bordercolor: AppColors.lightGray,
                        fillcolor: AppColors.white,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          20.verticalSpace,
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: onNewStep,
            child: Container(
              width: 135.w,
              height: 37.w,
              padding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 6.w,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.white,
                // shape: BoxShape.circle,
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    AppAssets.plusBlue,
                    colorFilter: const ColorFilter.mode(
                      AppColors.black,
                      BlendMode.srcIn,
                    ),
                  ),
                  5.horizontalSpace,
                  Text(
                    'New step',
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: AppColors.black),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
