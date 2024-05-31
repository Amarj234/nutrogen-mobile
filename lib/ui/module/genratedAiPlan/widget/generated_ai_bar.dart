import 'package:flutter/material.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/utils/helper.dart';

class GeneratedAiBar extends StatelessWidget {
  const GeneratedAiBar({
    required this.yollowflex,
    required this.whiteflex,
    required this.index,
    super.key,
  });
  final int yollowflex;
  final int whiteflex;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: yollowflex,
            child: Container(
              height: 10,
              width: 100,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                color: AppColors.mikadoYellow,
              ),
            ),
          ),
          Container(
            height: 25,
            width: 75,
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 3,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.mikadoYellow,
            ),
            child: Text(
              'Step $index/5',
              style: theme.textTheme.titleSmall?.copyWith(color: Colors.white),
            ),
          ),
          Expanded(
            flex: whiteflex,
            child: Container(
              height: 10,
              width: 100,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
        ],
      ),
    );
  }
}
