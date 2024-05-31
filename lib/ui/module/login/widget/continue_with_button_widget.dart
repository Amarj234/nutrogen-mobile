import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nutrogen/utils/helper.dart';

class ContinueWithButton extends StatelessWidget {
  const ContinueWithButton({
    required this.text,
    required this.svg,
    required this.color,
    required this.onTap,
    super.key,
  });

  final Color color;
  final String text;
  final String svg;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        elevation: 0,
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        fixedSize: Size(1.sw, 50.h),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: SvgPicture.asset(
              svg,
              width: 20,
              height: 20,
            ),
          ),
          Text(
            text,
            style: theme.primaryTextTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
