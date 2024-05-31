import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/res/app_routers.dart';
import 'package:nutrogen/utils/helper.dart';

class ConnectedAppWidget extends StatelessWidget {
  const ConnectedAppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<Color> listcolor = [
      const Color(0xff1E293B),
      const Color(0xff171717),
      const Color(0xff991B1B),
      const Color(0xff365314),
      const Color(0xff854D0E),
      const Color(0xff22C55E),
      const Color(0xff0369A1),
    ];
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: ListView.builder(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: listcolor.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              context.pushNamed(AppRouters.mobileAppDetails);
            },
            contentPadding: EdgeInsets.zero,
            title: Text(
              '5k Runmeter',
              style: theme.textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              'We will send a login link and you both 15% off the ...',
              style: theme.textTheme.titleSmall
                  ?.copyWith(color: AppColors.darkSilver),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            leading: Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: listcolor[index],
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        },
      ),
    );
  }
}
