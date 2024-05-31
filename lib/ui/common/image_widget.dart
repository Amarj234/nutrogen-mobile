import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/res/app_constants.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget(
    this.image, {
    this.width,
    this.height,
    this.radius = 0,
    this.fit = BoxFit.cover,
    super.key,
  });

  final double? height;
  final double? width;
  final double radius;
  final String? image;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: image?.contains('com.app.nutrogen') == true ||
                image?.contains('Data/Application') == true
            ? Image.file(
                File('$image'),
                fit: fit,
              )
            : image?.contains('asset') == true
                ? Image.asset(
                    '$image',
                    fit: fit,
                  )
                : CachedNetworkImage(
                    imageUrl: '${AppConstants.baseImageUrl}$image',
                    fit: fit,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Container(
                      padding: EdgeInsets.all(5.w),
                      color: AppColors.brightGray,
                      child: SvgPicture.asset(AppAssets.svgPlaceholder),
                    ),
                  ),
      ),
    );
  }
}
