import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/utils/helper.dart';

class TextChatWidget extends StatelessWidget {
  const TextChatWidget({
    required this.isSender,
    required this.isPreviousDiffrent,
    super.key,
  });

  final bool isSender;
  final bool isPreviousDiffrent;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: isSender ? 90.w : 0.w,
        right: isSender ? 0.w : 90.w,
      ),
      child: Column(
        crossAxisAlignment:
            isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(isSender ? 10.r : 0),
                topRight: Radius.circular(10.r),
                bottomLeft: Radius.circular(10.r),
                bottomRight: Radius.circular(isSender ? 0 : 10.r),
              ),
            ),
            child: Text(
              'Hey👋, Graphic Designer is better than UI UX Designer😎',
              style: theme.textTheme.bodyMedium,
            ),
          ),
          8.verticalSpace,
          Visibility(
            visible: isPreviousDiffrent,
            child: Column(
              children: [
                Text(
                  isSender ? '1:00 PM • You' : '1:00 PM • Amanda',
                  style: theme.textTheme.bodySmall,
                ),
                30.verticalSpace,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
