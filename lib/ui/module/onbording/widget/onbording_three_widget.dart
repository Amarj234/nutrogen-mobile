import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/ui/module/onbording/onbording_provider.dart';
import 'package:nutrogen/ui/module/onbording/widget/number_text_field_widget.dart';
import 'package:nutrogen/utils/helper.dart';
import 'package:nutrogen/utils/validation.dart';

class OnbordingThreeWidget extends HookConsumerWidget {
  const OnbordingThreeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timer = useRef<Timer?>(null);
    final selectedMesurementsUnit = useState<String>(
      ref.read(registerModelProvider).unitMeasurements ?? loc.imperial,
    );
    final selectedWeight = useState(
      double.tryParse('${ref.read(registerModelProvider).weight}') ?? 254.0,
    );
    final selectedHeight = useState(
      double.tryParse('${ref.read(registerModelProvider).height}') ?? 254.0,
    );

    void onMeasurementUnit(String text) {
      ref.read(registerModelProvider.notifier).setMeasurementUnit(text);
      selectedMesurementsUnit.value = text;
    }

    void onWeightMinus({bool isTouch = false}) {
      if (isTouch) {
        timer.value ??= Timer.periodic(
          const Duration(milliseconds: 50),
          (timer) {
            if (selectedWeight.value <= 0) return;
            selectedWeight.value =
                double.parse((selectedWeight.value - 0.1).toStringAsFixed(1));
            ref
                .read(registerModelProvider.notifier)
                .setWeight('${selectedWeight.value}');
          },
        );
      } else {
        if (selectedWeight.value <= 0) return;
        selectedWeight.value =
            double.parse((selectedWeight.value - 0.1).toStringAsFixed(1));
        ref
            .read(registerModelProvider.notifier)
            .setWeight('${selectedWeight.value}');
      }
    }

    void onWeightPlus({bool isTouch = false}) {
      if (isTouch) {
        timer.value ??= Timer.periodic(
          const Duration(milliseconds: 50),
          (timer) {
            selectedWeight.value =
                double.parse((selectedWeight.value + 0.1).toStringAsFixed(1));
            ref
                .read(registerModelProvider.notifier)
                .setWeight('${selectedWeight.value}');
          },
        );
      } else {
        selectedWeight.value =
            double.parse((selectedWeight.value + 0.1).toStringAsFixed(1));
        ref
            .read(registerModelProvider.notifier)
            .setWeight('${selectedWeight.value}');
      }
    }

    void onHeightMinus({bool isTouch = false}) {
      if (selectedHeight.value <= 0) return;
      if (isTouch) {
        timer.value ??= Timer.periodic(
          const Duration(milliseconds: 50),
          (timer) {
            selectedHeight.value =
                double.parse((selectedHeight.value - 0.1).toStringAsFixed(1));
            ref
                .read(registerModelProvider.notifier)
                .setHeight('${selectedHeight.value}');
          },
        );
      } else {
        selectedHeight.value =
            double.parse((selectedHeight.value - 0.1).toStringAsFixed(1));
        ref
            .read(registerModelProvider.notifier)
            .setHeight('${selectedHeight.value}');
      }
    }

    void onHeightPlus({bool isTouch = false}) {
      if (isTouch) {
        timer.value ??= Timer.periodic(
          const Duration(milliseconds: 50),
          (timer) {
            selectedHeight.value =
                double.parse((selectedHeight.value + 0.1).toStringAsFixed(1));
            ref
                .read(registerModelProvider.notifier)
                .setHeight('${selectedHeight.value}');
          },
        );
      } else {
        selectedHeight.value =
            double.parse((selectedHeight.value + 0.1).toStringAsFixed(1));
        ref
            .read(registerModelProvider.notifier)
            .setHeight('${selectedHeight.value}');
      }
    }

    void onTapUp() {
      timer.value?.cancel();
      timer.value = null;
    }

    void onWeigthNumber() async {
      await showModalBottomSheet(
        context: context,
        backgroundColor: AppColors.white,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
        ),
        builder: (context) => NumberTextFieldWidget(
          title:
              '${loc.enterWeigthBelow} (${selectedMesurementsUnit.value == loc.imperial ? loc.lbs : loc.kg})',
          hintText: loc.weigthUnit(
            selectedMesurementsUnit.value == loc.imperial ? loc.lbs : loc.kg,
          ),
          number: selectedWeight.value,
          validator: weightValidate,
          onConfirm: (number) {
            selectedWeight.value = number;
            ref
                .read(registerModelProvider.notifier)
                .setWeight('${selectedWeight.value}');
          },
        ),
      );
    }

    void onHeightNumber() async {
      await showModalBottomSheet(
        context: context,
        backgroundColor: AppColors.white,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
        ),
        builder: (context) => NumberTextFieldWidget(
          title:
              '${loc.enterHeightBelow} (${selectedMesurementsUnit.value == loc.imperial ? loc.inch : loc.cm})',
          hintText: loc.heightUnit(
            selectedMesurementsUnit.value == loc.imperial ? loc.inch : loc.cm,
          ),
          number: selectedHeight.value,
          validator: heightValidate,
          onConfirm: (number) {
            selectedHeight.value = number;
            ref
                .read(registerModelProvider.notifier)
                .setHeight('${selectedHeight.value}');
          },
        ),
      );
    }

    return Column(
      children: [
        Text(
          loc.letUsKnowTheMeasurements,
          style: theme.textTheme.displaySmall,
        ),
        50.verticalSpace,
        Text(
          loc.selectMeasurementUnit,
          style: theme.textTheme.headlineSmall,
        ),
        18.verticalSpace,
        Container(
          padding: EdgeInsets.all(6.w),
          margin: EdgeInsets.symmetric(horizontal: 40.w),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => onMeasurementUnit(loc.imperial),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 40.w, vertical: 10.h),
                    decoration: selectedMesurementsUnit.value == loc.imperial
                        ? BoxDecoration(
                            color: AppColors.darkMidnightBlue,
                            borderRadius: BorderRadius.circular(30.r),
                          )
                        : null,
                    child: Text(
                      loc.imperial,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: selectedMesurementsUnit.value == loc.imperial
                            ? AppColors.white
                            : null,
                      ),
                    ),
                  ),
                ),
              ),
              10.horizontalSpace,
              Expanded(
                child: InkWell(
                  onTap: () => onMeasurementUnit(loc.metric),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 40.w, vertical: 10.h),
                    decoration: selectedMesurementsUnit.value == loc.metric
                        ? BoxDecoration(
                            color: AppColors.darkMidnightBlue,
                            borderRadius: BorderRadius.circular(30.r),
                          )
                        : null,
                    child: Text(
                      loc.metric,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: selectedMesurementsUnit.value == loc.metric
                            ? AppColors.antiFlashWhite
                            : null,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        40.verticalSpace,
        Text(
          '${loc.letUsKnowYourWeight} (${selectedMesurementsUnit.value == loc.imperial ? loc.lbs : loc.kg})',
          style: theme.textTheme.headlineSmall,
        ),
        18.verticalSpace,
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          margin: EdgeInsets.symmetric(horizontal: 65.w),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: onWeightMinus,
                onLongPressStart: (_) => onWeightMinus(isTouch: true),
                onLongPressEnd: (_) => onTapUp(),
                child: SvgPicture.asset(AppAssets.svgMinus),
              ),
              5.horizontalSpace,
              Expanded(
                child: TextButton(
                  onPressed: onWeigthNumber,
                  child: Text(
                    '${selectedWeight.value}',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyLarge,
                  ),
                ),
              ),
              5.horizontalSpace,
              GestureDetector(
                onTap: onWeightPlus,
                onTapDown: (_) => onWeightPlus(isTouch: true),
                onTapUp: (_) => onTapUp(),
                child: SvgPicture.asset(AppAssets.svgPlus),
              ),
            ],
          ),
        ),
        40.verticalSpace,
        Text(
          '${loc.yourHeight} (${selectedMesurementsUnit.value == loc.imperial ? loc.inch : loc.cm})',
          style: theme.textTheme.headlineSmall,
        ),
        18.verticalSpace,
        Container(
          margin: EdgeInsets.symmetric(horizontal: 65.w),
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: onHeightMinus,
                onLongPressStart: (_) => onHeightMinus(isTouch: true),
                onLongPressEnd: (_) => onTapUp(),
                child: SvgPicture.asset(AppAssets.svgMinus),
              ),
              5.horizontalSpace,
              Expanded(
                child: TextButton(
                  onPressed: onHeightNumber,
                  child: Text(
                    '${selectedHeight.value}',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyLarge,
                  ),
                ),
              ),
              5.horizontalSpace,
              GestureDetector(
                onTap: onHeightPlus,
                onLongPressStart: (_) => onHeightPlus(isTouch: true),
                onLongPressEnd: (_) => onTapUp(),
                child: SvgPicture.asset(AppAssets.svgPlus),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
