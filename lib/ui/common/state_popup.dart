import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/res/app_routers.dart';
import 'package:nutrogen/utils/helper.dart';

void onStatePopup<T>(
  AsyncValue<T> response, {
  Function(T data)? onSuccess,
  bool isShowMessage = true,
}) =>
    response.when(
      data: (data) => _showData(data, onSuccess, isShowMessage),
      error: _showError,
      loading: _showLoading,
    );

bool _isStateDialogShow = false;

void _showData<T>(T data, Function(T data)? onSuccess, bool isShowMessage) {
  if (_isStateDialogShow) {
    AppRouters.rootKey.currentContext?.pop();
    _isStateDialogShow = false;
  }

  if (isShowMessage) {
    showMessage(message: '${(data as dynamic)?.message}');
  }

  if ((data as dynamic).status == true) {
    onSuccess?.call(data);
  }
}

void _showLoading({
  String? message,
}) {
  if (_isStateDialogShow) {
    AppRouters.rootKey.currentContext?.pop();
    _isStateDialogShow = false;
  }

  _isStateDialogShow = true;
  showDialog(
    context: AppRouters.rootKey.currentContext!,
    barrierDismissible: false,
    builder: (context) => PopScope(
      onPopInvoked: (didPop) {
        _isStateDialogShow = false;
      },
      child: const Center(
        child: CircularProgressIndicator(
          color: AppColors.darkMidnightBlue,
        ),
      ),
    ),
  );
}

void _showError(
  Object message,
  StackTrace stacktrace,
) async {
  if (_isStateDialogShow) {
    AppRouters.rootKey.currentContext?.pop();
    _isStateDialogShow = false;
  }

  if ('$message'.isEmpty) return;

  _isStateDialogShow = true;
  showDialog(
    context: AppRouters.rootKey.currentContext!,
    barrierDismissible: false,
    builder: (context) => PopScope(
      onPopInvoked: (didPop) {
        _isStateDialogShow = false;
      },
      child: AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            5.verticalSpace,
            Text(
              '$message',
              style: theme.textTheme.headlineSmall,
            ),
            30.verticalSpace,
            SizedBox(
              height: 44.h,
              child: ElevatedButton(
                onPressed: () {
                  _isStateDialogShow = false;
                  AppRouters.rootKey.currentContext?.pop();
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                ),
                child: Text(
                  loc.back,
                  style: theme.textTheme.headlineSmall
                      ?.copyWith(color: AppColors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

void showCommonDialog(
  String message, {
  String? buttonText,
  Function(BuildContext)? onOk,
}) =>
    showDialog(
      context: AppRouters.rootKey.currentContext!,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            5.verticalSpace,
            Text(
              message,
              style: theme.textTheme.headlineSmall,
            ),
            30.verticalSpace,
            SizedBox(
              height: 44.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      _isStateDialogShow = false;
                      AppRouters.rootKey.currentContext?.pop();
                    },
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.r),
                        side:
                            const BorderSide(color: AppColors.darkMidnightBlue),
                      ),
                    ),
                    child: Text(
                      loc.back,
                      style: theme.textTheme.headlineSmall
                          ?.copyWith(color: AppColors.darkMidnightBlue),
                    ),
                  ),
                  15.horizontalSpace,
                  Visibility(
                    visible: onOk != null,
                    child: ElevatedButton(
                      onPressed: () {
                        _isStateDialogShow = false;
                        onOk?.call(context) ??
                            AppRouters.rootKey.currentContext?.pop();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                      ),
                      child: Text(
                        buttonText ?? loc.ok,
                        style: theme.textTheme.headlineSmall
                            ?.copyWith(color: AppColors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

void showMessage({required String message}) {
  FocusScope.of(AppRouters.rootKey.currentContext!).requestFocus(FocusNode());
  if (message.isEmpty) return;

  ScaffoldMessenger.of(AppRouters.rootKey.currentContext!).clearSnackBars();
  ScaffoldMessenger.of(AppRouters.rootKey.currentContext!).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 1),
      margin: EdgeInsets.only(
        bottom: .75.sh,
        right: 20,
        left: 20,
      ),
      showCloseIcon: true,
      closeIconColor: AppColors.eerieBlack,
      behavior: SnackBarBehavior.floating,
      content: Text(
        message,
        style: theme.textTheme.bodyMedium,
      ),
      backgroundColor: AppColors.mikadoYellow,
    ),
  );
}

void showBanner({
  required String message,
  Color? color,
  String? buttonText,
  Function()? onButtonClick,
  bool? isAutoClose,
}) {
  if (message.isEmpty) return;

  ScaffoldMessenger.of(AppRouters.rootKey.currentContext!)
      .clearMaterialBanners();
  ScaffoldMessenger.of(AppRouters.rootKey.currentContext!).showMaterialBanner(
    MaterialBanner(
      backgroundColor: color,
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            onButtonClick?.call() ??
                ScaffoldMessenger.of(
                  AppRouters.rootKey.currentContext!,
                ).clearMaterialBanners();
          },
          child: Text(
            buttonText ?? loc.close,
            style: theme.textTheme.bodyMedium,
          ),
        ),
      ],
    ),
  );
  if (isAutoClose != false) {
    Future.delayed(const Duration(seconds: 2), () {
      ScaffoldMessenger.of(AppRouters.rootKey.currentContext!)
          .clearMaterialBanners();
    });
  }
}
