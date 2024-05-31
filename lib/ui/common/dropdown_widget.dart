import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/utils/helper.dart';

class DropDownWidget extends StatelessWidget {
  const DropDownWidget({
    required this.list,
    required this.hint,
    required this.onTap,
    required this.textcolor,
    required this.bordercolor,
    super.key,
    this.fillcolor,
    this.radius = 20,
  });
  final List<String> list;
  final String hint;
  final Color textcolor;
  final Color bordercolor;
  final Color? fillcolor;
  final double radius;
  final Function(String? val) onTap;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      dropdownColor: Colors.white,
      icon: Padding(
        padding: EdgeInsets.only(right: 10.w, top: 4.w),
        child: SvgPicture.asset(
          AppAssets.downArrow,
        ),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $hint';
        }
        return null;
      },
      style: theme.textTheme.bodyMedium,
      decoration: InputDecoration(
        fillColor: fillcolor,
        filled: fillcolor == null ? false : true,
        contentPadding: EdgeInsets.zero,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(
            color: bordercolor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(
            color: bordercolor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: bordercolor),
          borderRadius: BorderRadius.circular(radius),
        ),
        hintStyle: theme.textTheme.bodyMedium,
      ),
      hint: Text(
        hint,
        style: theme.textTheme.bodyMedium,
      ),
      items: list
          .map(
            (label) => DropdownMenuItem(
              value: label,
              child: Text(
                label.toString(),
                style: theme.textTheme.bodyMedium,
              ),
            ),
          )
          .toList(),

      onChanged: onTap, //what you need for height
    );
  }
}
