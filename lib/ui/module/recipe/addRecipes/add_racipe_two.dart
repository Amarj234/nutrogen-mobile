import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/utils/helper.dart';

class AddRecipeTwo extends HookConsumerWidget {
  const AddRecipeTwo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController searchController = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: AppColors.white,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    child: Text(
                      loc.ingredients,
                      style: theme.textTheme.displaySmall,
                    ),
                  ),
                ],
              ),
              20.verticalSpace,
              Container(
                height: 50.h,
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                  color: AppColors.antiFlashWhite,
                  borderRadius: BorderRadius.circular(35.r),
                ),
                child: Row(
                  children: [
                    20.horizontalSpace,
                    SvgPicture.asset(
                      //    width:17.w,
                      AppAssets.greySearch,
                      colorFilter: const ColorFilter.mode(
                        AppColors.quickSilver,
                        BlendMode.srcIn,
                      ),
                    ),
                    6.horizontalSpace,
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: AppColors.smokyBlack,
                        ),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                            top: 0,
                            // bottom: 10,
                          ),
                          hintText: loc.search,
                          hintStyle: theme.textTheme.titleSmall?.copyWith(
                            color: AppColors.darkSilver,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              20.verticalSpace,
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    20.horizontalSpace,
                    myWidget('Garlic'),
                    myWidget('Cup chopped cherries'),
                    myWidget('Garlic'),
                    myWidget('Garlic'),
                    myWidget('Cup chopped cherries'),
                    myWidget('Garlic'),
                    20.horizontalSpace,
                  ],
                ),
              ),
              20.verticalSpace,
            ],
          ),
        ),
        Expanded(
          child: Container(
            color: AppColors.antiFlashWhite,
            child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.all(20.w),
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  //  foodConfirmation();
                },
                child: AddFoodWidget(
                  isAdded: index == 3,
                ),
              ),
              separatorBuilder: (context, index) => 10.verticalSpace,
              itemCount: 20,
            ),
          ),
        ),
      ],
    );
  }

  Container myWidget(String name) {
    return Container(
      margin: EdgeInsets.only(right: 8.w),
      decoration: BoxDecoration(
        color: AppColors.antiFlashWhite,
        borderRadius: BorderRadius.circular(30.r),
      ),
      padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 12.w),
      child: Text('$name x'),
    );
  }
}

class AddFoodWidget extends StatelessWidget {
  const AddFoodWidget({required this.isAdded, super.key});

  final bool isAdded;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: Image.asset(
            AppAssets.jpgBreakfast,
            width: 73.w,
            height: 73.w,
          ),
        ),
        6.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Cup chopped cherries',
                style: theme.textTheme.titleMedium,
              ),
              1.verticalSpace,
              Text(
                '1 Cup , 254 Kcal',
                style: theme.textTheme.titleSmall
                    ?.copyWith(color: AppColors.darkSilver),
              ),
            ],
          ),
        ),
        6.horizontalSpace,
        IconButton(
          onPressed: () {},
          style: IconButton.styleFrom(padding: EdgeInsets.all(3.w)),
          icon: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isAdded ? AppColors.goldenlight : AppColors.white,
            ),
            child: SvgPicture.asset(
              colorFilter: ColorFilter.mode(
                isAdded ? AppColors.white : AppColors.eerieBlack,
                BlendMode.srcIn,
              ),
              isAdded ? AppAssets.svgRight : AppAssets.svgRight,
              height: 25.w,
            ),
          ),
        ),
      ],
    );
  }
}
