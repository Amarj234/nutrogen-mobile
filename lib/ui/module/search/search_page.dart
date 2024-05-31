import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/ui/module/logFood/log_food_page.dart';
import 'package:nutrogen/ui/module/mealPlans/widget/mean_plan_widget.dart';
import 'package:nutrogen/utils/helper.dart';

class SearchPage extends HookConsumerWidget {
  const SearchPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    final searchText = useState('');
    final searchNode = useFocusNode();
    final isRecentVisible = useListenable(searchNode);
    final selectedTab = useState(loc.mealPlans);

    final labelList = useMemoized(
      () => [
        loc.mealPlans,
        loc.recipes,
        loc.newsFeed,
        loc.challenges,
      ],
    );

    final searchList = useMemoized(
      () => [
        'Celery Free',
        'Dairy Free',
        'Eggs Free',
        'Pork-Free',
        'Keto Friendly',
        'Gluten Free',
      ],
    );

    void onRecentSearch(String text) {
      searchController.text = text;
      searchText.value = text;
      searchNode.unfocus();
    }

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: ScreenUtil().statusBarHeight + 10.h,
            color: AppColors.white,
          ),
          Expanded(
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  floating: false,
                  pinned: false,
                  automaticallyImplyLeading: false,
                  toolbarHeight: 25.h,
                  backgroundColor: AppColors.white,
                  flexibleSpace: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                width: 38.w,
                                height: 38.w,
                                padding: EdgeInsets.all(6.w),
                                decoration: const BoxDecoration(
                                  color: AppColors.cultured,
                                  shape: BoxShape.circle,
                                ),
                                child: SvgPicture.asset(AppAssets.svgBackArrow),
                              ),
                            ),
                            10.horizontalSpace,
                            Expanded(
                              flex: 3,
                              child: TextField(
                                controller: searchController,
                                focusNode: searchNode,
                                style: theme.textTheme.titleSmall?.copyWith(
                                  color: AppColors.smokyBlack,
                                ),
                                onChanged: (value) => searchText.value = value,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  fillColor: AppColors.antiFlashWhite,
                                  filled: true,
                                  prefixIcon: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      15.horizontalSpace,
                                      SvgPicture.asset(
                                        height: 22.w,
                                        width: 22.w,
                                        AppAssets.svgSearchYellow,
                                        colorFilter: const ColorFilter.mode(
                                          AppColors.quickSilver,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                    ],
                                  ),
                                  hintText: loc.search,
                                  hintStyle:
                                      theme.textTheme.titleSmall?.copyWith(
                                    color: AppColors.darkSilver,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(35.r),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(35.r),
                                    borderSide: BorderSide(
                                      color: AppColors.darkMidnightBlue,
                                      width: 1.w,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: SliverAppBarDelegate(
                    minHeight: 60.h,
                    maxHeight: 60.h,
                    child: Stack(
                      children: [
                        Container(
                          height: 60.h,
                          color: AppColors.white,
                        ),
                        ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          scrollDirection: Axis.horizontal,
                          primary: false,
                          shrinkWrap: true,
                          itemCount: labelList.length,
                          itemBuilder: (context, index) => IntrinsicWidth(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                TextButton(
                                  onPressed: () =>
                                      selectedTab.value = labelList[index],
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 15.w,
                                    ),
                                  ),
                                  child: Text(
                                    labelList[index],
                                    style: selectedTab.value == labelList[index]
                                        ? theme.textTheme.headlineSmall
                                        : theme.textTheme.bodyMedium?.copyWith(
                                            color: AppColors.darkSilver,
                                          ),
                                  ),
                                ),
                                Visibility(
                                  visible:
                                      selectedTab.value == labelList[index],
                                  child: Container(
                                    height: 7.h,
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 12.w,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        50.r,
                                      ),
                                      color: AppColors.darkMidnightBlue,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              body: Stack(
                children: [
                  Visibility(
                    visible: isRecentVisible.hasFocus,
                    replacement: ListView.separated(
                      padding: EdgeInsets.all(20.h),
                      itemBuilder: (context, index) => MeanPlanWidget(
                        onTap: () {},
                        rating: '',
                        kcal: '',
                        alligned: '',
                        title: '',
                        image: '',
                        cholesterol: '',
                        protein: '',
                        fat: '',
                      ),
                      separatorBuilder: (context, index) => 15.verticalSpace,
                      itemCount: 5,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            loc.recentSearches,
                            style: theme.textTheme.bodyLarge
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          15.verticalSpace,
                          Wrap(
                            direction: Axis.horizontal,
                            runSpacing: 10.w,
                            spacing: 10.w,
                            children: List.generate(
                              searchList.length,
                              (index) => InkWell(
                                onTap: () => onRecentSearch(searchList[index]),
                                borderRadius: BorderRadius.circular(30.r),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20.w,
                                    vertical: 12.h,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.r),
                                    border:
                                        searchText.value == searchList[index]
                                            ? null
                                            : Border.all(
                                                color: AppColors.azureishWhite,
                                                width: 1.w,
                                              ),
                                    color: searchText.value == searchList[index]
                                        ? AppColors.mikadoYellow
                                        : AppColors.white,
                                  ),
                                  child: Text(
                                    searchList[index],
                                    style:
                                        theme.textTheme.headlineSmall?.copyWith(
                                      color:
                                          searchText.value == searchList[index]
                                              ? AppColors.white
                                              : null,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
