import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/utils/helper.dart';

class SettingsContainer extends StatelessWidget {
  const SettingsContainer({
    required this.svgPic,
    required this.text,
    super.key,
    this.myFun,
  });
  final String svgPic;
  final String text;
  final Function()? myFun;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: myFun,
      child: Container(
        margin: const EdgeInsets.only(right: 20),
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.platinum)),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              svgPic,
              colorFilter: const ColorFilter.mode(
                AppColors.darkMidnightBlue,
                BlendMode.srcIn,
              ),
            ),
            10.horizontalSpace,
            Text(
              text,
              style: theme.textTheme.headlineSmall,
            ),
          ],
        ),
      ),
    );
  }
}
