import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/utils/app_log.dart';
import 'package:nutrogen/utils/url_type.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:video_player/video_player.dart';

class FullScreenMediaPage extends HookConsumerWidget {
  const FullScreenMediaPage({
    required this.index,
    required this.media,
    super.key,
  });

  final List<String> media;
  final String? index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chewieController = useState<ChewieController?>(null);

    Widget containerWidget({
      required List<String> media,
      required int parentIndex,
      required Color color,
      required bool isPreview,
    }) {
      return Material(
        color: color,
        child: Container(
          width: 1.sw,
          height: 1.sh,
          color: color,
          alignment: Alignment.center,
          child: UrlType.getType(media[0]) == UrlTypes.video
              ? Hero(
                  tag: media[int.tryParse('$index') ?? 0],
                  child: chewieController.value?.videoPlayerController.value
                              .isInitialized ==
                          true
                      ? Chewie(controller: chewieController.value!)
                      : Container(
                          height: 1.sw,
                          width: 1.sw,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.floralWhite,
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          child: const CircularProgressIndicator(),
                        ),
                )
              : PhotoViewGallery.builder(
                  scrollPhysics: const BouncingScrollPhysics(),
                  builder: (BuildContext context, int index) {
                    return PhotoViewGalleryPageOptions(
                      onTapDown: (context, details, controllerValue) {},
                      imageProvider: AssetImage(media[index]),
                      initialScale: PhotoViewComputedScale.contained * 0.8,
                      heroAttributes: PhotoViewHeroAttributes(
                        tag: '${media[index]}$index',
                      ),
                    );
                  },
                  wantKeepAlive: true,
                  enableRotation: true,
                  itemCount: media.length,
                  loadingBuilder: (context, event) => Center(
                    child: SizedBox(
                      width: 20.0,
                      height: 20.0,
                      child: CircularProgressIndicator(
                        value: event == null
                            ? 0
                            : event.cumulativeBytesLoaded /
                                (event.expectedTotalBytes ?? 0),
                      ),
                    ),
                  ),
                  backgroundDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.r),
                  ),
                  //  pageController: widget.pageController,
                  //  onPageChanged: onPageChanged,
                ),
        ),
      );
    }

    useEffect(
      () {
        if (UrlType.getType(media[0]) == UrlTypes.video) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
            final videoController = VideoPlayerController.file(
              File(media[0]),
            );
            await videoController.initialize();
            chewieController.value = ChewieController(
              autoPlay: true,
              autoInitialize: true,
              showControls: true,
              showControlsOnInitialize: true,
              zoomAndPan: true,
              showOptions: true,
              aspectRatio: videoController.value.aspectRatio,
              videoPlayerController: videoController,
              allowFullScreen: true,
            )..autoPlay;
          });
        }

        return () => chewieController.dispose();
      },
      [],
    );

    return Scaffold(
      backgroundColor: AppColors.transparent,
      body: Center(
        child: Stack(
          children: [
            Draggable(
              onDragEnd: (details) {
                if (details.offset.distance.abs() > 100) {
                  context.pop();
                }
                AppLog.e('${details.offset.distance}');
              },
              axis: Axis.vertical,
              childWhenDragging: Container(),
              feedback: containerWidget(
                media: media,
                isPreview: true,
                color: AppColors.black.withOpacity(0.02),
                parentIndex: int.tryParse('$index') ?? 0,
              ),
              child: containerWidget(
                media: media,
                isPreview: false,
                color: AppColors.black,
                parentIndex: int.tryParse('$index') ?? 0,
              ),
            ),
            Positioned(
              top: 40.h,
              child: IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: SvgPicture.asset(
                  AppAssets.svgArrowBack,
                  colorFilter: const ColorFilter.mode(
                    AppColors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
