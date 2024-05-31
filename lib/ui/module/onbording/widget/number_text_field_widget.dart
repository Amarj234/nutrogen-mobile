import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/utils/helper.dart';

class NumberTextFieldWidget extends HookConsumerWidget {
  const NumberTextFieldWidget({
    required this.title,
    required this.number,
    required this.hintText,
    required this.validator,
    required this.onConfirm,
    super.key,
  });

  final String title;
  final String hintText;
  final double number;
  final Function(double number) onConfirm;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final textController =
        useTextEditingController(text: number.toStringAsFixed(1));

    void onConfirms() {
      if (formKey.currentState?.validate() != true) return;
      onConfirm(double.tryParse(textController.text) ?? 0);
      context.pop();
    }

    return Padding(
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          16.verticalSpace,
          SizedBox(
            width: 42.w,
            child: Divider(
              color: AppColors.platinum,
              thickness: 4.h,
            ),
          ),
          16.verticalSpace,
          Text(
            title,
            style: theme.textTheme.displaySmall,
          ),
          30.verticalSpace,
          Form(
            key: formKey,
            child: TextFormField(
              controller: textController,
              validator: validator,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,1}')),
              ],
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: hintText,
                contentPadding:
                    const EdgeInsets.only(top: 1, bottom: 1, left: 13),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    color: AppColors.darkSilver,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    color: AppColors.red,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    color: AppColors.red,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.lightGray),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
          50.verticalSpace,
          ElevatedButton(
            onPressed: onConfirms,
            style: ElevatedButton.styleFrom(minimumSize: Size(200.w, 48.h)),
            child: Text(
              loc.confirm,
              style: theme.primaryTextTheme.titleMedium,
            ),
          ),
          30.verticalSpace,
        ],
      ),
    );
  }
}
