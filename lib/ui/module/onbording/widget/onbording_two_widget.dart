import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/ui/module/onbording/onbording_provider.dart';
import 'package:nutrogen/utils/helper.dart';

class OnbordingTwoWidget extends HookConsumerWidget {
  const OnbordingTwoWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedAge =
        useState<String>(ref.read(registerModelProvider).age ?? '40');

    void onAge(int value) {
      selectedAge.value = '${value + 16}';
      ref.read(registerModelProvider.notifier).setAge('${value + 16}');
      ref.read(registerModelProvider.notifier).setDob(
            DateFormat('yyyy-MM-dd').format(
              DateTime.now().subtract(Duration(days: (value + 16) * 365)),
            ),
          );
    }

    return Column(
      children: [
        Text(
          loc.whatIsYourAge,
          style: theme.textTheme.displaySmall,
        ),
        Expanded(
          child: Stack(
            children: [
              ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    colors: [
                      AppColors.white.withOpacity(0.01),
                      AppColors.white,
                      AppColors.white,
                      AppColors.white.withOpacity(0.01),
                    ],
                    stops: const [0.11, 0.4, 0.5, 0.91],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ).createShader(bounds);
                },
                child: ListWheelScrollView(
                  controller: FixedExtentScrollController(
                    initialItem: (int.parse(selectedAge.value) - 16),
                  ),
                  perspective: 0.01,
                  squeeze: 1.0,
                  itemExtent: 70,
                  diameterRatio: 3.0,
                  overAndUnderCenterOpacity: 0.8,
                  onSelectedItemChanged: onAge,
                  physics: const FixedExtentScrollPhysics(),
                  children: List.generate(
                    60,
                    (index) => RotatedBox(
                      quarterTurns: 0,
                      child: Center(
                        child: Text(
                          '${index + 16}',
                          textAlign: TextAlign.center,
                          textScaler: const TextScaler.linear(1.5),
                          style: '${index + 16}' == selectedAge.value
                              ? theme.textTheme.displayLarge
                                  ?.copyWith(fontWeight: FontWeight.w700)
                              : theme.textTheme.displayLarge?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.darkSilver,
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                bottom: 0,
                right: 35,
                child: SvgPicture.asset(AppAssets.svgYearsOld),
              ),
            ],
          ),
        ),
        50.verticalSpace,
      ],
    );
  }
}
