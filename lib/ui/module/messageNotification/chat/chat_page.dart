import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nutrogen/providers.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/res/app_routers.dart';
import 'package:nutrogen/ui/common/image_widget.dart';
import 'package:nutrogen/ui/module/messageNotification/chat/widget/media_pick_sheet.dart';
import 'package:nutrogen/ui/module/messageNotification/chat/widget/text_chat_widget.dart';
import 'package:nutrogen/ui/module/messageNotification/chat/widget/video_chat_widget.dart';
import 'package:nutrogen/utils/app_log.dart';
import 'package:nutrogen/utils/helper.dart';
import 'package:nutrogen/utils/url_type.dart';
import 'package:path_provider/path_provider.dart';

class ChatPage extends HookConsumerWidget {
  const ChatPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController();
    final selectedMedia = useState<List<String>>([]);
    final textFocus = useFocusNode();
    final isEmoji = useState(false);
    final animationController =
        useAnimationController(duration: const Duration(milliseconds: 200));

    useEffect(() {
      textFocus.addListener(() {
        isEmoji.value = textFocus.hasFocus == false;
      });
      return null;
    });

    void onPickerCancel() async {
      await animationController.forward();
      selectedMedia.value = [];
    }

    void onCameraPick() async {
      final image = await ref
          .read(imagePickerProvider)
          .pickImage(source: ImageSource.camera);
      if (image != null) {
        selectedMedia.value = [image.path];
        animationController.reverse();
      }
      if (context.mounted) {
        context.pop();
      }
    }

    void onPhotosPick() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: true,
        allowedExtensions: UrlType.imageTypes,
      );

      if (result?.files.isNotEmpty == true) {
        selectedMedia.value =
            result?.files.map((e) => '${e.path}').toList() ?? [];
        animationController.reverse();
      }
      if (context.mounted) {
        context.pop();
      }
    }

    void onVideoCameraPick() async {
      final video = await ref
          .read(imagePickerProvider)
          .pickVideo(source: ImageSource.camera);

      if (video != null) {
        selectedMedia.value = [video.path];
        animationController.reverse();
      }
      if (context.mounted) {
        context.pop();
      }
    }

    void onVideosPick() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        allowedExtensions: UrlType.videoTypes,
      );

      if (result?.files.isNotEmpty == true) {
        selectedMedia.value =
            result?.files.map((e) => '${e.path}').toList() ?? [];
        animationController.reverse();
      }
      if (context.mounted) {
        context.pop();
      }
    }

    void onFilePick() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: true,
        allowedExtensions: UrlType.docTypes,
      );

      if (result?.files.isNotEmpty == true) {
        selectedMedia.value =
            result?.files.map((e) => '${e.path}').toList() ?? [];
        animationController.reverse();
      }
      if (context.mounted) {
        context.pop();
      }
    }

    void onMediaPick() async {
      await showModalBottomSheet(
        backgroundColor: AppColors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.4,
          maxChildSize: 0.4,
          builder: (context, scrollController) => Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Stack(
              alignment: Alignment.center,
              children: [
                SingleChildScrollView(
                  controller: scrollController,
                  child: MediaPickSheet(
                    onMediaType: (media) {
                      if (media == loc.camera) {
                        onCameraPick();
                      } else if (media == loc.photos) {
                        onPhotosPick();
                      } else if (media == loc.videoCamera) {
                        onVideoCameraPick();
                      } else if (media == loc.videos) {
                        onVideosPick();
                      } else if (media == loc.files) {
                        onFilePick();
                      }
                      AppLog.e('MESS >> $media');
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    void onSticker() {
      if (isEmoji.value) {
        isEmoji.value = false;
        textFocus.requestFocus();
      } else {
        isEmoji.value = true;
        textFocus.unfocus();
      }
    }

    return PopScope(
      canPop: !isEmoji.value,
      onPopInvoked: (didPop) => didPop ? context.pop() : isEmoji.value = false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 70.h,
          backgroundColor: AppColors.white,
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  4.horizontalSpace,
                  IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: SvgPicture.asset(AppAssets.svgArrowBack),
                  ),
                  ImageWidget(
                    AppAssets.avatar,
                    width: 48.w,
                    height: 48.w,
                    radius: 50.r,
                  ),
                  10.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Desirae Schleifer',
                          style: theme.textTheme.titleMedium,
                        ),
                        Text(
                          'Online',
                          style: theme.textTheme.titleSmall
                              ?.copyWith(color: AppColors.goldenPoppy),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              10.verticalSpace,
            ],
          ),
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(20.w),
                    itemBuilder: (context, index) => index == 4
                        ? const VideoChatWidget(
                            isSender: true,
                            videoUrl:
                                '/data/user/0/com.app.nutrogen/cache/file_picker/1713185279703/VID_20240415_160800.mp4',
                            isPreviousDiffrent: true,
                          )
                        : TextChatWidget(
                            isSender: index == 1,
                            isPreviousDiffrent: index - 1 != 1,
                          ),
                    itemCount: 5,
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (selectedMedia.value.isNotEmpty)
                      SlideTransition(
                        position: Tween<Offset>(
                          begin: Offset.zero,
                          end: const Offset(0.0, 1.0),
                        ).animate(animationController),
                        child: Container(
                          width: 1.sw,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(3, 3),
                                color: AppColors.goldenPoppy.withOpacity(0.1),
                                blurRadius: 50,
                              ),
                            ],
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(30.r),
                            ),
                          ),
                          child: UrlType.getType(selectedMedia.value[0]) ==
                                  UrlTypes.image
                              ? ImagePickedPopupWidget(
                                  selectedMedia: selectedMedia.value,
                                  onPickerCancel: onPickerCancel,
                                )
                              : UrlType.getType(selectedMedia.value[0]) ==
                                      UrlTypes.video
                                  ? VideoPickedPopupWidget(
                                      selectedMedia: selectedMedia.value,
                                      onPickerCancel: onPickerCancel,
                                    )
                                  : FilePickedPopupWidget(
                                      selectedMedia: selectedMedia.value,
                                      onPickerCancel: onPickerCancel,
                                    ),
                        ),
                      ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15.w,
                        vertical: 10.h,
                      ),
                      color: AppColors.white,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              focusNode: textFocus,
                              contentInsertionConfiguration:
                                  ContentInsertionConfiguration(
                                onContentInserted: (value) async {
                                  if (value.data != null) {
                                    final tempDir =
                                        await getTemporaryDirectory();
                                    File file = await File(
                                      '${tempDir.path}/image_${DateTime.now().millisecondsSinceEpoch}.png',
                                    ).create();
                                    await file.writeAsBytes(value.data!);

                                    selectedMedia.value = [file.path];
                                  }
                                },
                              ),
                              controller: textController,
                              style: theme.textTheme.titleSmall?.copyWith(
                                color: AppColors.charcoal,
                                fontFamily: AppAssets.fontPlusJakartaSans,
                              ),
                              maxLines: 5,
                              minLines: 1,
                              decoration: InputDecoration(
                                filled: true,
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20.w,
                                  vertical: 15.h,
                                ),
                                hintText: loc.typeSomething,
                                hintStyle: theme.textTheme.titleSmall?.copyWith(
                                  color: AppColors.darkSilver,
                                  fontFamily: AppAssets.fontPlusJakartaSans,
                                ),
                                fillColor: AppColors.antiFlashWhite,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.r),
                                  borderSide: BorderSide.none,
                                ),
                                suffixIconConstraints: BoxConstraints(
                                  minWidth: 20.w,
                                  maxWidth: 80.w,
                                ),
                                suffixIcon: Row(
                                  children: [
                                    IconButton(
                                      padding: EdgeInsets.all(6.w),
                                      constraints: const BoxConstraints(),
                                      iconSize: 20,
                                      style: const ButtonStyle(
                                        tapTargetSize: MaterialTapTargetSize
                                            .shrinkWrap, // the '2023' part
                                      ),
                                      onPressed: onMediaPick,
                                      icon: SvgPicture.asset(
                                        AppAssets.svgAttachment,
                                      ),
                                    ),
                                    IconButton(
                                      constraints: const BoxConstraints(),
                                      iconSize: 20,
                                      padding: EdgeInsets.all(6.w),
                                      style: const ButtonStyle(
                                        tapTargetSize: MaterialTapTargetSize
                                            .shrinkWrap, // the '2023' part
                                      ),
                                      onPressed: onSticker,
                                      icon: isEmoji.value
                                          ? const Icon(Icons.keyboard)
                                          : SvgPicture.asset(
                                              AppAssets.svgSticker,
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          10.horizontalSpace,
                          IconButton(
                            onPressed: () {},
                            padding: EdgeInsets.all(4.w),
                            icon: SvgPicture.asset(
                              AppAssets.svgMic,
                              width: 50.w,
                              height: 50.w,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (isEmoji.value)
                  EmojiPicker(
                    onEmojiSelected: (Category? category, Emoji emoji) {
                      AppLog.e('message');
                    },
                    onBackspacePressed: () => isEmoji.value = false,
                    textEditingController: textController,
                    config: Config(
                      height: 300.h,
                      checkPlatformCompatibility: true,
                      emojiViewConfig: EmojiViewConfig(
                        emojiSizeMax: 28 *
                            (theme.platform == TargetPlatform.iOS ? 1.20 : 1.0),
                      ),
                      swapCategoryAndBottomBar: true,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ImagePickedPopupWidget extends StatelessWidget {
  const ImagePickedPopupWidget({
    required this.selectedMedia,
    required this.onPickerCancel,
    super.key,
  });

  final List<String> selectedMedia;
  final VoidCallback onPickerCancel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            onPressed: onPickerCancel,
            style: IconButton.styleFrom(
              padding: EdgeInsets.all(2.w),
              minimumSize: Size.zero,
              fixedSize: Size(40.w, 40.w),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            icon: SvgPicture.asset(AppAssets.svgClose),
          ),
        ),
        SizedBox(
          height: 200.h,
          child: ListView.separated(
            padding: EdgeInsets.only(
              left: 15.w,
              right: 15.w,
            ),
            shrinkWrap: true,
            itemCount: selectedMedia.length,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => 10.horizontalSpace,
            itemBuilder: (context, index) => ImageWidget(
              selectedMedia[index],
              radius: 15.r,
            ),
          ),
        ),
      ],
    );
  }
}

class VideoPickedPopupWidget extends StatelessWidget {
  const VideoPickedPopupWidget({
    required this.selectedMedia,
    required this.onPickerCancel,
    super.key,
  });

  final List<String> selectedMedia;
  final VoidCallback onPickerCancel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            onPressed: onPickerCancel,
            style: IconButton.styleFrom(
              padding: EdgeInsets.all(2.w),
              minimumSize: Size.zero,
              fixedSize: Size(40.w, 40.w),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            icon: SvgPicture.asset(AppAssets.svgClose),
          ),
        ),
        SizedBox(
          height: 200.h,
          child: ListView.separated(
            padding: EdgeInsets.only(
              left: 15.w,
              right: 15.w,
            ),
            shrinkWrap: true,
            itemCount: selectedMedia.length,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => 10.horizontalSpace,
            itemBuilder: (context, index) =>
                VideoWidget(selectedMedia: selectedMedia[index]),
          ),
        ),
      ],
    );
  }
}

class VideoWidget extends HookConsumerWidget {
  const VideoWidget({
    required this.selectedMedia,
    super.key,
  });

  final String selectedMedia;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onMediaTap() {
      context.pushNamed(
        AppRouters.fullScreenMedia,
        extra: [selectedMedia],
        queryParameters: {'index': '0'},
      );
    }

    return InkWell(
      onTap: onMediaTap,
      child: Hero(
        tag: selectedMedia,
        child: SizedBox(
          width: 200.w,
          height: 200.w,
          child: Stack(
            alignment: Alignment.center,
            children: [
              ImageWidget(
                AppAssets.jpgShopItem,
                fit: BoxFit.cover,
                height: double.maxFinite,
                width: double.maxFinite,
                radius: 8.r,
              ),
              Container(
                alignment: Alignment.center,
                height: double.maxFinite,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: AppColors.black.withOpacity(
                    0.4,
                  ),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.play_circle_outline_rounded,
                  size: 50.w,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FilePickedPopupWidget extends StatelessWidget {
  const FilePickedPopupWidget({
    required this.selectedMedia,
    required this.onPickerCancel,
    super.key,
  });

  final List<String> selectedMedia;
  final VoidCallback onPickerCancel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            onPressed: onPickerCancel,
            style: IconButton.styleFrom(
              padding: EdgeInsets.all(2.w),
              minimumSize: Size.zero,
              fixedSize: Size(40.w, 40.w),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            icon: SvgPicture.asset(AppAssets.svgClose),
          ),
        ),
        GridView.builder(
          padding: EdgeInsets.only(
            left: 15.w,
            right: 15.w,
          ),
          shrinkWrap: true,
          itemCount: selectedMedia.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10.w,
            crossAxisSpacing: 10.w,
            mainAxisExtent: 50.h,
          ),
          itemBuilder: (context, index) => Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 6.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.r),
              color: AppColors.floralWhite,
            ),
            child: Row(
              children: [
                const Icon(Icons.file_open_outlined),
                10.horizontalSpace,
                Expanded(
                  child: Text(
                    selectedMedia[index].split('/').last,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
