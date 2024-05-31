import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/utils/helper.dart';

class LinerDropdownWidget extends HookConsumerWidget {
  const LinerDropdownWidget({
    required this.list,
    required this.hint,
    required this.bordercolor,
    required this.onItem,
    super.key,
    this.textcolor = AppColors.black,
    this.fillcolor,
    this.iswhite = false,
    this.selectedValue,
  });
  final List<String> list;
  final String hint;
  final Color textcolor;
  final Color bordercolor;
  final Color? fillcolor;
  final bool iswhite;
  final String? selectedValue;

  final Function(String? val) onItem;

  List<DropdownMenuItem<String>> addDividersAfterItems(List<String> items) {
    final List<DropdownMenuItem<String>> menuItems = [];
    for (final String item in list) {
      menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: item,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 0),
              child: Text(
                item,
                style: theme.textTheme.bodyMedium,
              ),
            ),
          ),
          if (item != list.last)
            DropdownMenuItem<String>(
              enabled: false,
              child: Divider(
                color: AppColors.lightGray,
                height: 1.h,
              ),
            ),
        ],
      );
    }
    return menuItems;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final focusNode = useFocusNode();
    final isFocus = useState(false);

    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          focusNode.addListener(() {
            isFocus.value = focusNode.hasFocus;
          });
        });
        return null;
      },
      [],
    );
    return DropdownButton2<String>(
      focusNode: focusNode,
      isExpanded: true,
      underline: 0.verticalSpace,
      hint: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Text(
          hint,
          style:
              theme.textTheme.bodyMedium?.copyWith(color: AppColors.darkSilver),
        ),
      ),
      items: addDividersAfterItems(list),
      value: selectedValue,
      onChanged: onItem,
      buttonStyleData: ButtonStyleData(
        elevation: 0,
        decoration: BoxDecoration(
          boxShadow: focusNode.hasFocus
              ? [
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.15),
                    blurRadius: 80,
                    offset: const Offset(0, -30),
                  ),
                ]
              : null,
          color: focusNode.hasFocus ? AppColors.white : null,
          border: focusNode.hasFocus
              ? null
              : Border.all(
                  color: AppColors.lightGray,
                ),
          borderRadius: focusNode.hasFocus
              ? BorderRadius.zero
              : BorderRadius.circular(
                  10.r,
                ),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 5.w,
        ),
        height: 50.h,
        width: 1.sw,
      ),
      dropdownStyleData: DropdownStyleData(
        offset: const Offset(0, 0),
        elevation: 0,
        maxHeight: 200.h,
        decoration: BoxDecoration(
          color: AppColors.antiFlashWhite,
          boxShadow: [
            BoxShadow(
              color: AppColors.lightGray.withOpacity(0.60),
              blurRadius: 20,
              spreadRadius: -5,
              offset: const Offset(0, 10),
            ),
          ],
          borderRadius: BorderRadius.vertical(
            top: Radius.zero,
            bottom: Radius.circular(10.r),
          ),
        ),
      ),
      menuItemStyleData: MenuItemStyleData(
        height: 30.h,
        padding: EdgeInsets.zero,
      ),
      iconStyleData: IconStyleData(
        icon: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.black,
          ),
        ),
      ),
    );
  }
}
