import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/ui/module/genratedAiPlan/widget/selecte_item.dart';
import 'package:nutrogen/utils/helper.dart';

class RecipeFiltersWidget extends HookConsumerWidget {
  const RecipeFiltersWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final budget = useState(75.0);
    final userRatings = useState(75.0);
    List<String> planList = [
      'High-Fiber',
      'Low-Fiber',
      'Low-Sodium',
      'Low-Magnesium',
      'Low-Potassium',
      'Low-Iron',
    ];
    List<String> planList2 = [
      '15 min',
      '30 min',
      '40 min',
      '50 min',
      '1hr+',
    ];
    List<String> planList3 = [
      'Winter',
      'Summer',
      'Spring',
      'Holidays',
      'Snowy',
    ];

    final selectedFoodType = useState<List<String>>([]);

    void onFoodType(String text) {
      if (selectedFoodType.value.contains(text)) {
        final list = selectedFoodType.value;
        list.remove(text);

        selectedFoodType.value = [...list];
        return;
      }

      selectedFoodType.value = [...selectedFoodType.value, text];
    }

    final selectedMealType = useState<List<String>>([]);

    void onMealType(String text) {
      if (selectedMealType.value.contains(text)) {
        final list = selectedMealType.value;
        list.remove(text);

        selectedMealType.value = [...list];
        return;
      }

      selectedMealType.value = [...selectedMealType.value, text];
    }

    final selectedCookingMethod = useState<List<String>>([]);

    void onCookingMethod(String text) {
      if (selectedCookingMethod.value.contains(text)) {
        final list = selectedCookingMethod.value;
        list.remove(text);

        selectedCookingMethod.value = [...list];
        return;
      }

      selectedCookingMethod.value = [...selectedCookingMethod.value, text];
    }

    final selectedIngredients = useState<List<String>>([]);

    void onIngredients(String text) {
      if (selectedIngredients.value.contains(text)) {
        final list = selectedIngredients.value;
        list.remove(text);

        selectedIngredients.value = [...list];
        return;
      }

      selectedIngredients.value = [...selectedIngredients.value, text];
    }

    final selectedPreparationTime = useState<List<String>>([]);

    void onPreparationTime(String text) {
      if (selectedPreparationTime.value.contains(text)) {
        final list = selectedPreparationTime.value;
        list.remove(text);

        selectedPreparationTime.value = [...list];
        return;
      }

      selectedPreparationTime.value = [...selectedPreparationTime.value, text];
    }

    final selectedSeasonorOccasion = useState<List<String>>([]);

    void onSeasonorOccasion(String text) {
      if (selectedSeasonorOccasion.value.contains(text)) {
        final list = selectedSeasonorOccasion.value;
        list.remove(text);

        selectedSeasonorOccasion.value = [...list];
        return;
      }

      selectedSeasonorOccasion.value = [
        ...selectedSeasonorOccasion.value,
        text,
      ];
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        15.verticalSpace,
        Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: 42.w,
            child: Divider(
              color: AppColors.platinum,
              thickness: 4.h,
            ),
          ),
        ),
        16.verticalSpace,
        Text(
          loc.allergyFilters,
          style: theme.textTheme.displaySmall,
        ),
        10.verticalSpace,
        Text(
          loc.selectexclude,
          style:
              theme.textTheme.titleSmall?.copyWith(color: AppColors.darkSilver),
        ),
        20.verticalSpace,
        Text(
          loc.foodType,
          style: theme.textTheme.headlineSmall,
        ),
        15.verticalSpace,
        SelectedItem(
          planList: planList,
          selectedList: selectedFoodType.value,
          onSelect: onFoodType,
        ),
        20.verticalSpace,
        Text(
          loc.mealType,
          style: theme.textTheme.headlineSmall,
        ),
        15.verticalSpace,
        SelectedItem(
          planList: planList,
          selectedList: selectedMealType.value,
          onSelect: onMealType,
        ),
        20.verticalSpace,
        Text(
          loc.cookingMethod,
          style: theme.textTheme.headlineSmall,
        ),
        15.verticalSpace,
        SelectedItem(
          planList: planList,
          selectedList: selectedCookingMethod.value,
          onSelect: onCookingMethod,
        ),
        20.verticalSpace,
        Text(
          loc.ingredients,
          style: theme.textTheme.headlineSmall,
        ),
        15.verticalSpace,
        SelectedItem(
          planList: planList,
          selectedList: selectedIngredients.value,
          onSelect: onIngredients,
        ),
        20.verticalSpace,
        Text(
          loc.preparationtime,
          style: theme.textTheme.headlineSmall,
        ),
        15.verticalSpace,
        SelectedItem(
          planList: planList2,
          selectedList: selectedPreparationTime.value,
          onSelect: onPreparationTime,
        ),
        20.verticalSpace,
        Text(
          loc.byNutritionalContent,
          style: theme.textTheme.headlineSmall,
        ),
        15.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            cotanteWigget('Carbs', '0'),
            cotanteWigget('Carbs', '0'),
            cotanteWigget('Fat', '0'),
          ],
        ),
        20.verticalSpace,
        Text(
          loc.seasonorOccasion,
          style: theme.textTheme.headlineSmall,
        ),
        15.verticalSpace,
        SelectedItem(
          planList: planList3,
          selectedList: selectedSeasonorOccasion.value,
          onSelect: onSeasonorOccasion,
        ),
        20.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              loc.byBudget,
              style: theme.textTheme.headlineSmall,
            ),
            Text(
              'Max \$215',
              style: theme.textTheme.titleSmall,
            ),
          ],
        ),
        10.verticalSpace,
        SliderTheme(
          data: theme.sliderTheme.copyWith(
            overlayShape: SliderComponentShape.noOverlay,
          ),
          child: Slider(
            overlayColor: const MaterialStatePropertyAll(AppColors.transparent),
            thumbColor: AppColors.darkMidnightBlue,
            activeColor: AppColors.goldenPoppy,
            inactiveColor: AppColors.whitegrey,
            min: 0.0,
            max: 100.0,
            value: budget.value,
            onChanged: (value) {
              budget.value = value;
            },
          ),
        ),
        20.verticalSpace,
        Row(
          children: [
            Expanded(
              child: Text(
                loc.userratings,
                style: theme.textTheme.headlineSmall,
              ),
            ),
            SvgPicture.asset(AppAssets.svgStarBlack),
            3.horizontalSpace,
            Text(
              '3',
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
        10.verticalSpace,
        SliderTheme(
          data: theme.sliderTheme.copyWith(
            trackShape: CustomTrackShape(
              currentPosition: userRatings.value,
              defaultPlayers: 30,
              maxPlayers: 100,
              minPlayers: 0,
              selectedPathBarWidth: 5,
            ),
            overlayShape: SliderComponentShape.noOverlay,
          ),
          child: Slider(
            overlayColor: const MaterialStatePropertyAll(AppColors.transparent),
            thumbColor: AppColors.darkMidnightBlue,
            activeColor: AppColors.goldenPoppy,
            inactiveColor: AppColors.whitegrey,
            min: 0.0,
            max: 100.0,
            value: userRatings.value,
            onChanged: (value) {
              userRatings.value = value;
            },
          ),
        ),
        100.verticalSpace,
      ],
    );
  }

  Container cotanteWigget(String txt, value) {
    return Container(
      width: 110.w,
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 12.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: AppColors.azureishWhite,
          width: 1.w,
        ),
        color: AppColors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            value,
            style: theme.textTheme.titleSmall
                ?.copyWith(color: AppColors.darkSilver),
          ),
          20.horizontalSpace,
          Text(
            txt,
            style: theme.textTheme.titleSmall,
          ),
        ],
      ),
    );
  }
}

class CustomTrackShape extends SliderTrackShape {
  final double maxPlayers;
  final double defaultPlayers;
  final double minPlayers;
  final double selectedPathBarWidth;
  final double currentPosition;
  double trackWidth = 0;

  CustomTrackShape({
    required this.maxPlayers,
    required this.defaultPlayers,
    required this.minPlayers,
    required this.currentPosition,
    this.selectedPathBarWidth = 3,
  });

  @override
  Rect getPreferredRect({
    RenderBox? parentBox,
    Offset offset = Offset.zero,
    SliderThemeData? sliderTheme,
    bool? isEnabled,
    bool? isDiscrete,
  }) {
    final double thumbWidth = sliderTheme?.thumbShape
            ?.getPreferredSize(
              isEnabled == true,
              isDiscrete == true,
            )
            .width ??
        0;
    final double trackHeight = sliderTheme?.trackHeight ?? 0;
    assert(thumbWidth >= 0);
    assert(trackHeight >= 0);
    assert((parentBox?.size.width ?? 0) >= thumbWidth);
    assert((parentBox?.size.height ?? 0) >= trackHeight);

    final double trackTop =
        offset.dy + ((parentBox?.size.height ?? 0) - trackHeight) / 2;
    final double trackLeft = offset.dx + thumbWidth / 2;
    trackWidth = (parentBox?.size.width ?? 0) - thumbWidth;

    return Rect.fromLTWH(
      trackLeft,
      trackTop,
      trackWidth,
      trackHeight,
    );
  }

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required Offset thumbCenter,
    required TextDirection textDirection,
    Offset? secondaryOffset,
    bool? isEnabled,
    bool? isDiscrete,
  }) {
    // Check for slider track height
    if (sliderTheme.trackHeight == 0) return;
    // Get the rect that we just calculated
    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    // Calculate the width for which the default players
    // will be covered on the slider track shape
    double defaultPlayerWidth = (trackWidth / maxPlayers) * defaultPlayers;
    double currentPositionWidth = (trackWidth / maxPlayers) * currentPosition;

    // calculating the paint
    // for the default path (initial width)
    final Paint defaultPathPaint = Paint()
      ..color = sliderTheme.activeTrackColor ?? AppColors.goldenPoppy
      ..style = PaintingStyle.fill;

    // calculate the path segment for
    // the default width
    final defaultPathSegment = Path()
      ..addRect(
        Rect.fromPoints(
          Offset(trackRect.left, trackRect.top),
          Offset(
            trackRect.left +
                (currentPositionWidth >= defaultPlayerWidth
                    ? defaultPlayerWidth
                    : currentPositionWidth),
            trackRect.bottom,
          ),
        ),
      )
      ..addRect(
        Rect.fromPoints(
          Offset(
            (trackRect.left +
                (currentPositionWidth >= defaultPlayerWidth
                    ? defaultPlayerWidth
                    : currentPositionWidth) +
                10),
            trackRect.top,
          ),
          Offset(
            trackRect.right,
            trackRect.bottom,
          ),
        ),
      )
      ..lineTo(trackRect.left, trackRect.bottom)
      ..arcTo(
        Rect.fromPoints(
          Offset(trackRect.left + 5, trackRect.top),
          Offset(trackRect.left - 5, trackRect.bottom),
        ),
        -pi * 3 / 2,
        pi,
        false,
      );

    context.canvas.drawPath(defaultPathSegment, defaultPathPaint);

    //calculate the paint for the path segment
    // that is unselected (inactive track)
    final unselectedPathPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = sliderTheme.inactiveTrackColor ?? AppColors.lightGray;

    final unselectedPathSegment = Path()
      ..addRect(
        Rect.fromPoints(
          Offset(trackRect.right, trackRect.top),
          Offset(
            trackRect.left + currentPositionWidth,
            trackRect.bottom,
          ),
        ),
      )
      ..addArc(
        Rect.fromPoints(
          Offset(trackRect.right - 5, trackRect.bottom),
          Offset(trackRect.right + 5, trackRect.top),
        ),
        -pi / 2,
        pi,
      );

    context.canvas.drawPath(unselectedPathSegment, unselectedPathPaint);
  }
}
