import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/utils/helper.dart';

class DiscoverRowWidget extends StatelessWidget {
  const DiscoverRowWidget({required this.svg, required this.title, super.key});
  final String svg;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width / 2) - 25,
      height: 85,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(svg),
          10.horizontalSpace,
          SizedBox(
            width: 120.w,
            child: Text(
              title,
              style: theme.textTheme.titleMedium,
            ),
          ),
        ],
      ),
    );
  }
}
