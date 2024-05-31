import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/ui/module/onbording/onbording_provider.dart';
import 'package:nutrogen/utils/helper.dart';

class OnbordingOneWidget extends HookConsumerWidget {
  const OnbordingOneWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedGender =
        useState<String?>(ref.read(registerModelProvider).gender ?? loc.male);

    void onGender(String text) {
      ref.read(registerModelProvider.notifier).setGender(text);
      selectedGender.value = text;
    }

    return Column(
      children: [
        Text(
          loc.selectYourGender,
          style: theme.textTheme.displaySmall,
        ),
        150.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => onGender(loc.male),
              borderRadius: BorderRadius.circular(10.r),
              child: Column(
                children: [
                  Container(
                    width: 120.w,
                    height: 120.w,
                    padding: EdgeInsets.all(30.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: selectedGender.value == loc.male
                          ? AppColors.blueberry
                          : AppColors.white,
                    ),
                    child: SvgPicture.asset(
                      AppAssets.svgMale,
                      colorFilter: ColorFilter.mode(
                        selectedGender.value == loc.male
                            ? AppColors.white
                            : AppColors.smokyBlack,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  10.verticalSpace,
                  Text(
                    loc.male,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: selectedGender.value == loc.male
                          ? AppColors.eerieBlack
                          : AppColors.quickSilver,
                    ),
                  ),
                ],
              ),
            ),
            34.horizontalSpace,
            InkWell(
              onTap: () => onGender(loc.female),
              borderRadius: BorderRadius.circular(10.r),
              child: Column(
                children: [
                  Container(
                    width: 120.w,
                    height: 120.w,
                    padding: EdgeInsets.all(26.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: selectedGender.value == loc.female
                          ? AppColors.blueberry
                          : AppColors.white,
                    ),
                    child: SvgPicture.asset(
                      AppAssets.svgFemale,
                      colorFilter: ColorFilter.mode(
                        selectedGender.value == loc.female
                            ? AppColors.white
                            : AppColors.smokyBlack,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  10.verticalSpace,
                  Text(
                    loc.female,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: selectedGender.value == loc.female
                          ? AppColors.eerieBlack
                          : AppColors.quickSilver,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
