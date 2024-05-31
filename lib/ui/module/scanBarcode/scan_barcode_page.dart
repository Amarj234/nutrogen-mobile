import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/utils/helper.dart';

class ScanBarcodePage extends HookConsumerWidget {
  const ScanBarcodePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final manualController = useTextEditingController();
    final isCameraVisible = useState(true);
    final manualFocus = useFocusNode();

    useEffect(
      () {
        manualFocus.addListener(() {
          if (manualFocus.hasFocus) {
            isCameraVisible.value = false;
          } else {
            isCameraVisible.value = true;
          }

          // controller.start();
        });
        return null;
      },
      [],
    );
    void onClose() {
      context.pop();
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 88.h,
        backgroundColor: AppColors.white,
        flexibleSpace: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              bottom: 20.h,
              child: Text(
                loc.scanABarcode,
                style: theme.textTheme.bodyLarge
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            Positioned(
              left: 10.w,
              bottom: 10.h,
              child: IconButton(
                onPressed: onClose,
                padding: EdgeInsets.zero,
                icon: SvgPicture.asset(AppAssets.svgCloseGray),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                AiBarcodeScanner(
                  showOverlay: true,
                  onScan: (String value) {
                    debugPrint(value);
                  },
                  onDetect: (BarcodeCapture barcodeCapture) {
                    debugPrint('$barcodeCapture');
                  },
                ),
                Visibility(
                  visible: !isCameraVisible.value,
                  child: Container(
                    width: 1.sw,
                    alignment: Alignment.center,
                    color: AppColors.black,
                    child: Text(
                      'Camera paused',
                      style: theme.textTheme.displayMedium
                          ?.copyWith(color: AppColors.lightGray),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: AppColors.white,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: Container(
              height: 50.h,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(
                color: AppColors.antiFlashWhite,
                borderRadius: BorderRadius.circular(35.r),
              ),
              child: TextField(
                focusNode: manualFocus,
                controller: manualController,
                style: theme.textTheme.titleSmall
                    ?.copyWith(color: AppColors.smokyBlack),
                decoration: InputDecoration(
                  hintText: loc.addCodeManually,
                  hintStyle: theme.textTheme.titleSmall
                      ?.copyWith(color: AppColors.darkSilver),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
