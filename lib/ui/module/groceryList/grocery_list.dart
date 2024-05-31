import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/utils/helper.dart';

import 'package:nutrogen/res/app_routers.dart';

class GroceryList extends StatelessWidget {
  const GroceryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Container(
            width: 37.w,
            height: 37.w,
            padding: EdgeInsets.all(6.w),
            decoration: const BoxDecoration(
              color: AppColors.cultured,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(AppAssets.svgBackArrow),
          ),
          onPressed: () {
            context.pop();
          },
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Container(
              width: 37.w,
              height: 37.w,
              padding: EdgeInsets.all(6.w),
              decoration: const BoxDecoration(
                color: AppColors.cultured,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(AppAssets.svgPlusBg),
            ),
            onPressed: () {},
          ),
        ],
        title: Text(
          loc.grocerylist,
          style:
              theme.primaryTextTheme.bodyLarge?.copyWith(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.only(left: 5),
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: ListTile(
                onTap: () {
                  context.pushNamed(AppRouters.groceryListDetails);
                },
                trailing: SizedBox(
                  width: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0; i < 4; i++) ...[
                        Align(
                          widthFactor: 0.6,
                          child: CircleAvatar(
                            radius: 14.r,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 14.r,
                              backgroundImage: const AssetImage(
                                AppAssets.jpgBreakfast,
                              ),
                            ),
                          ),
                        ),
                      ],
                      Align(
                        widthFactor: 0.6,
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                            color: AppColors.goldenPoppy,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '23+',
                            style: theme.textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                title: Text(
                  'Power week grocery list',
                  style: theme.textTheme.headlineSmall,
                ),
                subtitle: Text(
                  '23 items in this list',
                  style: theme.textTheme.titleSmall
                      ?.copyWith(color: AppColors.darkSilver),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
