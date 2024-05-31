import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/res/app_routers.dart';
import 'package:nutrogen/utils/helper.dart';

class PaymentPlanPage extends StatelessWidget {
  const PaymentPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(AppAssets.svgCloseGray),
          onPressed: () {
            context.pop();
          },
        ),
        centerTitle: true,
        title: Text(
          loc.paymentPlan,
          style:
              theme.primaryTextTheme.bodyLarge?.copyWith(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.verticalSpace,
              10.verticalSpace,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                height: 266.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  image: const DecorationImage(
                    image: AssetImage(
                      AppAssets.jpgPaymentbackground,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    50.verticalSpace,
                    Text(
                      loc.standard,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.white,
                      ),
                    ),
                    5.verticalSpace,
                    Text(
                      'Yearly plan, Renewal: 23 May.2025',
                      style: theme.textTheme.bodySmall
                          ?.copyWith(color: AppColors.white),
                    ),
                    15.verticalSpace,
                    rightText('uch as n strained y'),
                    8.verticalSpace,
                    rightText('uch as Greek-stylenonfat plain sed y'),
                    8.verticalSpace,
                    rightText('uch as Greek-stylenin strained y'),
                  ],
                ),
              ),
              30.verticalSpace,
              Text(
                loc.paymenthistory,
                style: theme.textTheme.headlineSmall,
              ),
              15.verticalSpace,
              ListView.builder(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 8,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      context.pushNamed(AppRouters.mobileAppDetails);
                    },
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      '\$45,235',
                      style: theme.textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      '10 July, 2023',
                      style: theme.textTheme.titleSmall
                          ?.copyWith(color: AppColors.darkSilver),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    leading: SvgPicture.asset(AppAssets.historyUpload),
                    trailing: Container(
                      width: 110.w,
                      height: 45.h,
                      padding: EdgeInsets.symmetric(
                        vertical: 5.h,
                        horizontal: 20.w,
                      ),
                      alignment: Alignment.topRight,
                      decoration: BoxDecoration(
                        color: AppColors.goldenlight,
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: AppColors.lightGray),
                      ),
                      child: Center(
                        child: Text(
                          loc.completed,
                          style: theme.primaryTextTheme.labelLarge
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row rightText(String txt) {
    return Row(
      children: [
        SvgPicture.asset(AppAssets.rightround),
        10.horizontalSpace,
        Text(
          txt,
          style: theme.textTheme.bodySmall?.copyWith(color: AppColors.white),
        ),
      ],
    );
  }
}
