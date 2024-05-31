import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/utils/helper.dart';

class MediaPickSheet extends HookConsumerWidget {
  const MediaPickSheet({required this.onMediaType, super.key});

  final Function(String media) onMediaType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titles = useMemoized(
      () => [loc.camera, loc.photos, loc.videoCamera, loc.videos, loc.files],
    );
    final icons = useMemoized(
      () => [
        Icons.camera_alt_outlined,
        Icons.photo,
        Icons.videocam_outlined,
        Icons.video_collection_outlined,
        Icons.file_open_rounded,
      ],
    );

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 42.w,
            child: Divider(
              color: AppColors.platinum,
              thickness: 4.h,
            ),
          ),
          16.verticalSpace,
          Text(
            loc.chooseMedia,
            style: theme.textTheme.displaySmall,
          ),
          30.verticalSpace,
          SizedBox(
            height: 250.h,
            child: GridView.builder(
              itemCount: titles.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) => IconButton(
                padding: EdgeInsets.zero,
                onPressed: () => onMediaType(titles[index]),
                icon: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(15.w),
                      decoration: const BoxDecoration(
                        color: AppColors.goldenPoppy,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        icons[index],
                        color: AppColors.white,
                        size: 40.w,
                      ),
                    ),
                    6.verticalSpace,
                    Text(
                      titles[index],
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
