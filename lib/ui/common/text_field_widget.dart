import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/utils/helper.dart';

class TextFieldWidget extends HookConsumerWidget {
  const TextFieldWidget({
    required this.controller,
    required this.hintText,
    this.validator,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.bottomRound = false,
    this.topRound = false,
    this.borderRight = true,
    this.borderLeft = true,
    this.onTap,
    this.suffix,
    this.maxLength,
    this.formatter,
    super.key,
  });

  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType keyboardType;
  final bool bottomRound;
  final bool topRound;
  final bool borderLeft;
  final bool borderRight;
  final int? maxLength;
  final Widget? suffix;
  final List<TextInputFormatter>? formatter;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFocused = useState(false);
    final focusNode = useFocusNode();
    useEffect(
      () {
        focusNode.addListener(() {
          isFocused.value = focusNode.hasFocus;
        });
        return null;
      },
      [],
    );
    return Container(
      padding: EdgeInsets.only(
        right: suffix != null ? 10.w : 20.w,
        left: 20.w,
        top: 4.h,
        bottom: 4.h,
      ),
      decoration: BoxDecoration(
        color: isFocused.value ? AppColors.white : AppColors.transparent,
        border: Border(
          top: BorderSide(
            color: isFocused.value ? AppColors.darkSilver : AppColors.lightGray,
            width: 1.w,
            style: isFocused.value
                ? BorderStyle.solid
                : topRound
                    ? BorderStyle.solid
                    : bottomRound
                        ? BorderStyle.none
                        : BorderStyle.none,
          ),
          left: BorderSide(
            color: isFocused.value
                ? AppColors.darkSilver
                : borderLeft
                    ? AppColors.lightGray
                    : AppColors.transparent,
            width: 1.w,
          ),
          right: BorderSide(
            color: isFocused.value
                ? AppColors.darkSilver
                : borderRight
                    ? AppColors.lightGray
                    : AppColors.transparent,
            width: 1.w,
          ),
          bottom: BorderSide(
            color: isFocused.value ? AppColors.darkSilver : AppColors.lightGray,
            width: 1.w,
            style: isFocused.value
                ? BorderStyle.solid
                : topRound
                    ? BorderStyle.none
                    : bottomRound
                        ? BorderStyle.solid
                        : BorderStyle.none,
          ),
        ),
        borderRadius: BorderRadius.vertical(
          top: topRound ? Radius.circular(10.r) : Radius.zero,
          bottom: bottomRound ? Radius.circular(10.r) : Radius.zero,
        ),
      ),
      child: TextFormField(
        onTapOutside: (_) => FocusScope.of(context).unfocus(),
        maxLength: maxLength,
        focusNode: focusNode,
        readOnly: onTap != null,
        onTap: onTap,
        inputFormatters: formatter,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        validator: validator,
        decoration: InputDecoration(
          suffixIconConstraints:
              const BoxConstraints(minHeight: 0, minWidth: 0),
          suffixIcon: suffix,
          isDense: true,
          counterText: '',
          hintText: hintText,
          hintStyle:
              theme.textTheme.bodyMedium?.copyWith(color: AppColors.darkSilver),
          focusedBorder: InputBorder.none,
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: theme.colorScheme.error),
          ),
          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
        style: theme.textTheme.bodyMedium,
      ),
    );
  }
}
