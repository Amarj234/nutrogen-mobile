import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/ui/common/input_textfields.dart';
import 'package:nutrogen/utils/helper.dart';
import 'package:photo_manager/photo_manager.dart';

final isshow = StateProvider<bool>((ref) => false);

class CreateNewsFeed extends ConsumerStatefulWidget {
  const CreateNewsFeed({super.key});

  @override
  ConsumerState<CreateNewsFeed> createState() => _CreateNewsFeedState();
}

class _CreateNewsFeedState extends ConsumerState<CreateNewsFeed> {
  List<Widget> mediaList = [];
  int currentPage = 0;
  int? lastPage;

  @override
  void initState() {
    super.initState();
    _fetchNewMedia();
    focus.addListener(() {
      if (focus.hasFocus) {
        ref.read(isshow.notifier).state = true;
      } else {
        ref.read(isshow.notifier).state = false;
      }
    });
    mediaList.add(
      Padding(
        padding: EdgeInsets.only(right: 10.w),
        child: SvgPicture.asset(
          AppAssets.camera,
          width: 78.w,
          height: 78.h,
        ),
      ),
    );
  }

  _handleScrollEvent(ScrollNotification scroll) {
    if (scroll.metrics.pixels / scroll.metrics.maxScrollExtent > 0.33) {
      if (currentPage != lastPage) {
        _fetchNewMedia();
      }
    }
  }

  _fetchNewMedia() async {
    lastPage = currentPage;
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (ps.isAuth) {
      // success
//load the album list
      List<AssetPathEntity> albums =
          await PhotoManager.getAssetPathList(onlyAll: true);
      List<AssetEntity> media = await albums[0]
          .getAssetListPaged(size: 60, page: currentPage); //preloading files
      List<Widget> temp = [];

      for (var asset in media) {
        temp.add(
          FutureBuilder(
            future: asset.thumbnailDataWithSize(
              const ThumbnailSize(200, 200),
            ), //resolution of thumbnail
            builder:
                (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Container(
                  margin: EdgeInsets.only(right: 10.w),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(17.r),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Container(
                          width: 78.w,
                          height: 78.h,
                          margin: EdgeInsets.only(right: 10.w),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: MemoryImage(
                                snapshot.data!,
                              ),
                              fit: BoxFit.cover,
                            ),
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(17.r),
                          ),
                        ),
                      ),
                      if (asset.type == AssetType.video)
                        const Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 5, bottom: 5),
                            child: Icon(
                              Icons.videocam,
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              }
              return Container();
            },
          ),
        );
      }
      setState(() {
        mediaList.addAll(temp);
        currentPage++;
      });
    } else {
      // fail
      /// if result is fail, you can call `PhotoManager.openSetting();`  to open android/ios applicaton's setting to get permission
    }
  }

  final focus = FocusNode();
  @override
  Widget build(BuildContext context) {
    final check = ref.watch(isshow.notifier).state;
    final postText = TextEditingController();
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scroll) {
        _handleScrollEvent(scroll);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: SvgPicture.asset(AppAssets.svgCloseGray),
            onPressed: () {
              context.pop();
            },
          ),
          title: Text(
            loc.post,
            style:
                theme.primaryTextTheme.bodyLarge?.copyWith(color: Colors.black),
          ),
        ),
        // body: SafeArea(
        //   child: _mediaList[1],
        // ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                20.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(AppAssets.roundText),
                    Expanded(
                      child: InputTextfields(
                        focus: focus,
                        maxLines: 6,
                        bordercolor: AppColors.antiFlashWhite,
                        controller: postText,
                        hint: 'What’s happening?',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomSheet: Visibility(
          visible: check,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
            height: 100,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: mediaList.map((e) {
                  return SizedBox(height: 78, width: 78, child: e);
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
