import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/utils/helper.dart';

Widget onStateView<T>(
  AsyncValue<T> response, {
  required Widget Function(T data) child,
  bool isEmptyShow = true,
  String emptyText = 'Empty Data',
  Function()? onRetry,
  String? emptySvg,
}) =>
    response.when(
      data: (data) => (data is List)
          ? _dataView(
              data: data,
              child: child(data),
              isEmptyShow: isEmptyShow,
              emptyText: emptyText,
              emptySvg: emptySvg,
            )
          : child(data),
      error: (error, stackTrace) =>
          _errorView(error, stackTrace, onRetry: onRetry),
      loading: _loadingView,
    );

Widget _errorView(
  Object error,
  StackTrace stackTrace, {
  Function()? onRetry,
}) {
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.all(50.w),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$error',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium,
        ),
        Visibility(
          visible: onRetry != null,
          child: ElevatedButton(
            onPressed: onRetry,
            child: Text(
              loc.retry,
              style: theme.textTheme.headlineSmall,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _loadingView() {
  return const Center(
    child: CircularProgressIndicator(
      color: AppColors.darkMidnightBlue,
    ),
  );
}

Widget _dataView({
  required List<dynamic> data,
  required Widget child,
  required bool isEmptyShow,
  required String emptyText,
  String? emptySvg,
}) {
  return data.isNotEmpty == true
      ? child
      : isEmptyShow
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(50),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: emptySvg != null,
                      child: SvgPicture.asset('$emptySvg'),
                    ),
                    30.verticalSpace,
                    Text(
                      emptyText,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.displaySmall,
                    ),
                  ],
                ),
              ),
            )
          : 0.verticalSpace;
}
