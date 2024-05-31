import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/utils/helper.dart';

class DropDownWidget extends HookConsumerWidget {
  const DropDownWidget({
    required this.branchList,
    required this.onTapItem,
    required this.selectedBranch,
    this.validator,
    this.bottomRound = false,
    this.topRound = false,
    super.key,
  });

  final String? selectedBranch;
  final List? branchList;
  final bool bottomRound;
  final bool topRound;
  final String? Function(String?)? validator;
  final Function(String? text) onTapItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isVisibleBranch = useState(false);

    void onTapInside(PointerDownEvent event) async {
      FocusScope.of(context).unfocus();
      await Future.delayed(const Duration(milliseconds: 100));
      isVisibleBranch.value = true;
    }

    void onTapOutside(PointerDownEvent event) {
      isVisibleBranch.value = false;
    }

    return TapRegion(
      onTapInside: onTapInside,
      onTapOutside: onTapOutside,
      child: Container(
        padding: EdgeInsets.only(bottom: 6.h),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: isVisibleBranch.value
                  ? AppColors.darkSilver
                  : AppColors.lightGray,
              width: 1.w,
              style: isVisibleBranch.value
                  ? BorderStyle.solid
                  : topRound
                      ? BorderStyle.solid
                      : bottomRound
                          ? BorderStyle.none
                          : BorderStyle.none,
            ),
            left: BorderSide(
              color: isVisibleBranch.value
                  ? AppColors.darkSilver
                  : AppColors.lightGray,
              width: 1.w,
            ),
            right: BorderSide(
              color: isVisibleBranch.value
                  ? AppColors.darkSilver
                  : AppColors.lightGray,
              width: 1.w,
            ),
            bottom: BorderSide(
              color: isVisibleBranch.value
                  ? AppColors.darkSilver
                  : AppColors.lightGray,
              width: 1.w,
              style: isVisibleBranch.value
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
        child: FormField<String>(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validator,
          builder: (state) => Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: isVisibleBranch.value
                      ? AppColors.white
                      : AppColors.transparent,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: Text(
                              selectedBranch ?? loc.selectBranch,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: selectedBranch == null
                                    ? AppColors.darkSilver
                                    : AppColors.eerieBlack,
                              ),
                            ),
                          ),
                          if (state.hasError && !isVisibleBranch.value)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Divider(
                                  height: 1.h,
                                  color: theme.colorScheme.error,
                                ),
                                8.verticalSpace,
                                Text(
                                  state.errorText ?? '',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.error,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                    10.horizontalSpace,
                    Icon(
                      isVisibleBranch.value
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.keyboard_arrow_down_rounded,
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: isVisibleBranch.value,
                child: SizedBox(
                  height: (branchList?.length ?? 1) > 3
                      ? 180
                      : (branchList?.length ?? 1) * 60.h,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: branchList?.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () async {
                        onTapItem(branchList?[index]);
                        await Future.delayed(const Duration(milliseconds: 100));
                        isVisibleBranch.value = false;
                        state.didChange(branchList?[index]);
                        state.validate();
                        if (context.mounted) {
                          FocusScope.of(context).unfocus();
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.antiFlashWhite,
                          borderRadius: index == ((branchList?.length ?? 0) - 1)
                              ? BorderRadius.circular(10.r)
                              : BorderRadius.zero,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Visibility(
                              visible: true,
                              child: Divider(
                                color: AppColors.lightGray,
                                height: 1.h,
                              ),
                            ),
                            16.verticalSpace,
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30.w),
                              child: Text(
                                branchList?[index],
                                style: theme.textTheme.bodyMedium
                                    ?.copyWith(color: AppColors.eerieBlack),
                              ),
                            ),
                            16.verticalSpace,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
