import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/utils/helper.dart';

class InputTextfields extends HookConsumerWidget {
  const InputTextfields({
    required this.hint,
    required this.controller,
    required this.bordercolor,
    this.validator,
    super.key,
    this.inputFormatters,
    this.icon,
    this.isIcon = false,
    this.readonly = false,
    this.onSuffix,
    this.textcolor = AppColors.white,
    this.fillcolor,
    this.maxLines = 1,
    this.maxLength,
    this.fristIcon,
    this.focus,
    this.keyboardType,
  });
  final String hint;

  final bool isIcon;
  final Color textcolor;
  final Color bordercolor;
  final Color? fillcolor;
  final bool readonly;
  final FocusNode? focus;
  final int? maxLines;
  final int? maxLength;
  final String? icon;
  final String? fristIcon;
  final TextInputType? keyboardType;
  final Function()? onSuffix;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final focusNode = focus ?? useListenable(useFocusNode());
    return TextFormField(
      focusNode: focusNode,
      maxLines: maxLines,
      onTap: onSuffix,
      readOnly: readonly,
      maxLength: maxLength,
      keyboardType: keyboardType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      style: theme.textTheme.bodyMedium,
      inputFormatters: inputFormatters,
      validator: validator,
      decoration: InputDecoration(
        // icon: fristIcon != null
        //     ? Padding(
        //         padding:
        //             const EdgeInsets.only(bottom: 108.0, left: 20, right: 0),
        //         child: Image.asset(fristIcon!),
        //       )
        //     : Container(
        //         height: .1,
        //         width: .1,
        //       ),
        fillColor:
            focusNode?.hasFocus == true ? fillcolor : AppColors.antiFlashWhite,
        filled: fillcolor == null ? false : true,
        counter: 0.horizontalSpace,
        suffixIcon: isIcon
            ? InkWell(
                onTap: onSuffix,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(icon!),
                ),
              )
            : Container(
                width: 1,
              ),
        contentPadding: EdgeInsets.only(
          top: maxLines == 1 ? 1 : 20,
          bottom: 1,
          left: fristIcon != null ? 0 : 13,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            color: bordercolor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            color: bordercolor,
          ),
        ),
        hintStyle:
            theme.textTheme.bodyMedium?.copyWith(color: AppColors.darkSilver),
        hintText: hint,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: bordercolor),
          borderRadius: BorderRadius.circular(
            10.r,
          ),
        ),
      ),
    );
  }
}
