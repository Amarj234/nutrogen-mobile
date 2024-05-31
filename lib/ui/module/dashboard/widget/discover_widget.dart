import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/utils/helper.dart';

class DiscoverWidget extends StatelessWidget {
  const DiscoverWidget({required this.title, required this.svg, super.key});

  final String title;
  final String svg;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(svg),
          6.verticalSpace,
          Text(
            title,
            style: theme.textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
