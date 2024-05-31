import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/res/app_routers.dart';
import 'package:nutrogen/ui/module/recipe/widget/recipe_filters_widget.dart';
import 'package:nutrogen/ui/module/recipe/widget/recipe_list.dart';
import 'package:nutrogen/utils/helper.dart';

class OnlineRecipesList extends StatelessWidget {
  const OnlineRecipesList({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    void onFilter() async {
      await showModalBottomSheet(
        backgroundColor: AppColors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.6,
          maxChildSize: 0.9,
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
                  child: const RecipeFiltersWidget(),
                ),
                Positioned(
                  bottom: 30.h,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(172.w, 55.h),
                    ),
                    child: Text(
                      loc.apply,
                      style: theme.primaryTextTheme.headlineSmall,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          10.horizontalSpace,
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 20.w,
            ),
            decoration: const BoxDecoration(
              color: AppColors.white,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    height: 42.h,
                    decoration: BoxDecoration(
                      color: AppColors.antiFlashWhite,
                      borderRadius: BorderRadius.circular(35.r),
                    ),
                    child: Row(
                      children: [
                        20.horizontalSpace,
                        SvgPicture.asset(
                          AppAssets.svgSearchYellow,
                          colorFilter: const ColorFilter.mode(
                            Color(0xffA8A29E),
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
                                bottom: 10,
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
                ),
                10.horizontalSpace,
                InkWell(
                  onTap: () {
                    onFilter();
                  },
                  child: Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: const BoxDecoration(
                      color: AppColors.cultured,
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(AppAssets.settingsOption),
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            scrollDirection: Axis.vertical,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(top: 20.h),
                child: InkWell(
                  onTap: () {
                    context.pushNamed(AppRouters.recipeDetails);
                  },
                  child: RecipeList(favorate: (1 == index)),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
