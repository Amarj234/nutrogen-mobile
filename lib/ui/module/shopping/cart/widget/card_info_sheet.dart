import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/ui/common/image_widget.dart';
import 'package:nutrogen/ui/common/text_field_widget.dart';
import 'package:nutrogen/utils/card_number_formatter.dart';
import 'package:nutrogen/utils/helper.dart';
import 'package:nutrogen/utils/validation.dart';

class CardInfoSheet extends HookConsumerWidget {
  const CardInfoSheet({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final cardNumberController = useTextEditingController();
    final expiryDateController = useTextEditingController();
    final cvcController = useTextEditingController();
    final nameOnCardController = useTextEditingController();

    void onCancel() {
      context.pop();
    }

    void onAddCard() {
      if (formKey.currentState?.validate() != true) return;
    }

    void onExpiryPick() async {
      final dateTime = DateTime.now();
      DateTime? date = await showMonthPicker(
        context: context,
        initialDate: expiryDateController.text.isNotEmpty
            ? DateFormat('MM/yy').parse(expiryDateController.text)
            : dateTime,
        firstDate: dateTime,
        lastDate: dateTime.add(const Duration(days: 365 * 30)),
      );
      if (date != null) {
        expiryDateController.text = DateFormat('MM/yy').format(date);
      }
    }

    return Padding(
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            15.verticalSpace,
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: 42.w,
                child: Divider(
                  color: AppColors.platinum,
                  thickness: 4.h,
                ),
              ),
            ),
            16.verticalSpace,
            Text(
              loc.changePaymentMethod,
              style: theme.textTheme.bodyLarge
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            20.verticalSpace,
            TextFieldWidget(
              controller: cardNumberController,
              hintText: loc.cardNumber,
              topRound: true,
              maxLength: 19,
              formatter: [
                FilteringTextInputFormatter.digitsOnly,
                CardNumberFormatter(),
              ],
              keyboardType: TextInputType.number,
              validator: cardNumberValidate,
              suffix: ImageWidget(
                AppAssets.masterCard,
                width: 40.w,
                height: 22.h,
                fit: BoxFit.contain,
              ),
            ),
            Divider(
              color: AppColors.lightGray,
              height: 1.h,
            ),
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: TextFieldWidget(
                      controller: expiryDateController,
                      hintText: loc.mmyy,
                      borderRight: true,
                      maxLength: 5,
                      onTap: onExpiryPick,
                      validator: cardExpiryDateValidate,
                    ),
                  ),
                  SizedBox(
                    height: 50.h,
                    child: VerticalDivider(
                      color: AppColors.lightGray,
                      thickness: 1.w,
                      width: 1.w,
                    ),
                  ),
                  Expanded(
                    child: TextFieldWidget(
                      controller: cvcController,
                      hintText: loc.cvc,
                      borderLeft: false,
                      maxLength: 3,
                      keyboardType: TextInputType.number,
                      validator: cardCVCValidate,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: AppColors.lightGray,
              height: 1.h,
            ),
            TextFieldWidget(
              controller: nameOnCardController,
              hintText: loc.nameOnCard,
              bottomRound: true,
              validator: cardNameValidate,
            ),
            24.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: onAddCard,
                  style: ElevatedButton.styleFrom(fixedSize: Size(172.w, 55.h)),
                  child: Text(
                    loc.addCard,
                    style: theme.primaryTextTheme.headlineSmall,
                  ),
                ),
                10.horizontalSpace,
                OutlinedButton(
                  onPressed: onCancel,
                  style: OutlinedButton.styleFrom(
                    fixedSize: Size(172.w, 55.h),
                    side: BorderSide(color: AppColors.eerieBlack, width: 1.w),
                  ),
                  child: Text(
                    loc.cancel,
                    style: theme.textTheme.headlineSmall,
                  ),
                ),
              ],
            ),
            30.verticalSpace,
          ],
        ),
      ),
    );
  }
}
