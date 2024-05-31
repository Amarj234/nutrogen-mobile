import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/utils/helper.dart';

class InputTextfield extends StatelessWidget {
  const InputTextfield({
    required this.hint,
    required this.mycon,
    required this.bordercolor,
    super.key,
    this.inputFormatters,
    this.icon,
    this.isicon = false,
    this.readonly = false,
    this.myfun,
    this.textcolor = AppColors.white,
    this.fillcolor,
  });
  final String hint;

  final bool isicon;
  final Color textcolor;
  final Color bordercolor;
  final Color? fillcolor;
  final bool readonly;
  final String? icon;
  final Function()? myfun;
  final TextEditingController mycon;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: myfun,
      readOnly: readonly,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: mycon,
      style: theme.textTheme.bodyMedium,
      inputFormatters: inputFormatters,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $hint';
        }
        return null;
      },
      decoration: InputDecoration(
        fillColor: fillcolor,
        filled: fillcolor == null ? false : true,
        suffixIcon: isicon
            ? InkWell(
                onTap: myfun,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(icon!),
                ),
              )
            : Container(
                width: 1,
              ),
        contentPadding: const EdgeInsets.only(top: 1, bottom: 1, left: 13),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: bordercolor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: bordercolor,
          ),
        ),
        hintStyle:
            theme.textTheme.bodyMedium?.copyWith(color: AppColors.darkSilver),
        hintText: hint,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: bordercolor),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
