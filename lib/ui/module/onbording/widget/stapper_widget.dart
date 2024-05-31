import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/utils/helper.dart';

class StapperWidget extends StatelessWidget {
  const StapperWidget({
    required this.stepCount,
    required this.selectedStep,
    this.inactiveTrackColor = AppColors.white,
    super.key,
  });

  final int stepCount;
  final int selectedStep;
  final Color inactiveTrackColor;

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: AppColors.mikadoYellow,
        inactiveTrackColor: inactiveTrackColor,
        trackShape: const CustomSliderTrackShape(),
        trackHeight: 10.h,
        thumbColor: AppColors.white,
        tickMarkShape: const RoundSliderTickMarkShape(),
        activeTickMarkColor: AppColors.mikadoYellow,
        inactiveTickMarkColor: AppColors.white,
        overlayShape: SliderComponentShape.noOverlay,
        valueIndicatorShape: SliderComponentShape.noOverlay,
        thumbShape: CustomSliderThumbRect(
          thumbRadius: 30.r,
          min: 0,
          max: stepCount,
          thumbHeight: 30.h,
        ),
      ),
      child: Slider(
        value: selectedStep.toDouble(),
        min: 0,
        max: stepCount.toDouble(),
        onChanged: (value) {},
      ),
    );
  }
}

class CustomSliderTrackShape extends RoundedRectSliderTrackShape {
  const CustomSliderTrackShape();
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    Offset offset = Offset.zero,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight ?? 30;
    final trackLeft = offset.dx;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    final trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}

class CustomSliderThumbRect extends SliderComponentShape {
  final double thumbRadius;
  final double thumbHeight;
  final int min;
  final int max;

  const CustomSliderThumbRect({
    required this.thumbRadius,
    required this.thumbHeight,
    required this.min,
    required this.max,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final rRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(center.dx * .915, center.dy),
        width: thumbHeight * 2.5,
        height: thumbHeight * .9,
      ),
      Radius.circular(thumbRadius * .6),
    );

    final paint = Paint()
      ..color = sliderTheme.activeTrackColor ?? AppColors.red
      ..style = PaintingStyle.fill;

    TextSpan span = TextSpan(
      style: theme.primaryTextTheme.titleSmall,
      text: getValue(value),
    );
    TextPainter tp = TextPainter(
      text: span,
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    Offset textCenter =
        Offset(center.dx * .915 - (tp.width / 2), center.dy - (tp.height / 2));

    canvas.drawRRect(rRect, paint);
    tp.paint(canvas, textCenter);
  }

  String getValue(double value) {
    return 'Step ${(min + (max - min) * value).round()}/$max';
  }
}
