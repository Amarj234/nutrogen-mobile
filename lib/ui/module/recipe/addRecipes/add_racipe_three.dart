import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/ui/common/input_textfields.dart';
import 'package:nutrogen/ui/common/liner_dropdowm_widget.dart';
import 'package:nutrogen/utils/helper.dart';

class AddRecipeThree extends HookConsumerWidget {
  const AddRecipeThree({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value1 = useState('Grams');
    final value2 = useState('Grams');
    final value3 = useState('Grams');

    final chickenNeckRibs = useTextEditingController();
    final cupChoppedCherries = useTextEditingController();
    final chickenNeckOrRibs = useTextEditingController();

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  child: Text(
                    loc.ingredientsdetails,
                    style: theme.textTheme.displaySmall,
                  ),
                ),
              ],
            ),
            25.verticalSpace,
            Text(
              loc.chickenneckorribs,
              style: theme.textTheme.headlineSmall,
            ),
            12.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: InputTextfields(
                    hint: '5',
                    controller: chickenNeckOrRibs,
                    bordercolor: AppColors.lightGray,
                    fillcolor: AppColors.white,
                  ),
                ),
                15.horizontalSpace,
                Expanded(
                  child: LinerDropdownWidget(
                    textcolor: AppColors.black,
                    list: const ['Grams', 'Litre', 'Cup'],
                    hint: value1.value,
                    bordercolor: AppColors.lightGray,
                    onItem: (String? val) {
                      value1.value = val ?? 'Grams';
                    },
                    fillcolor: AppColors.white,
                    iswhite: true,
                  ),
                ),
                15.horizontalSpace,
                InkWell(
                  onTap: () {
                    value1.value = '';
                  },
                  child: SvgPicture.asset(AppAssets.cross),
                ),
              ],
            ),
            20.verticalSpace,
            Text(
              loc.cupchoppedcherries,
              style: theme.textTheme.headlineSmall,
            ),
            12.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: InputTextfields(
                    hint: '5',
                    controller: cupChoppedCherries,
                    bordercolor: AppColors.lightGray,
                    fillcolor: AppColors.white,
                  ),
                ),
                15.horizontalSpace,
                Expanded(
                  child: LinerDropdownWidget(
                    textcolor: AppColors.black,
                    list: const ['Grams', 'Litre', 'Cup'],
                    hint: value2.value,
                    bordercolor: AppColors.lightGray,
                    onItem: (String? val) {
                      value2.value = val ?? 'Grams';
                    },
                    fillcolor: AppColors.white,
                    iswhite: true,
                  ),
                ),
                15.horizontalSpace,
                InkWell(
                  onTap: () {
                    value2.value = '';
                  },
                  child: SvgPicture.asset(AppAssets.cross),
                ),
              ],
            ),
            20.verticalSpace,
            Text(
              loc.chickenneckorribs,
              style: theme.textTheme.headlineSmall,
            ),
            12.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: InputTextfields(
                    hint: '5',
                    controller: chickenNeckRibs,
                    bordercolor: AppColors.lightGray,
                    fillcolor: AppColors.white,
                  ),
                ),
                15.horizontalSpace,
                Expanded(
                  child: LinerDropdownWidget(
                    textcolor: AppColors.black,
                    list: const ['Grams', 'Litre', 'Cup'],
                    hint: value3.value,
                    bordercolor: AppColors.lightGray,
                    onItem: (String? val) {
                      value3.value = val ?? 'Grams';
                    },
                    fillcolor: AppColors.white,
                    iswhite: true,
                  ),
                ),
                15.horizontalSpace,
                InkWell(
                  onTap: () {
                    value3.value = '';
                  },
                  child: SvgPicture.asset(AppAssets.cross),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
