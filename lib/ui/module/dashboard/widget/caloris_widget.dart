import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:nutrogen/utils/helper.dart';

class CaloriesWidget extends StatelessWidget {
  const CaloriesWidget({
    required this.name,
    required this.value,
    required this.svg,
    super.key,
  });

  final String name;
  final String value;
  final String svg;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: name,
      child: SizedBox(
        width: 125.w,
        child: Row(
          children: [
            SvgPicture.asset(svg),
            12.horizontalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  name,
                  style: theme.textTheme.labelLarge,
                ),
                Text(
                  value,
                  style: theme.textTheme.bodyLarge
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
