import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrogen/res/app_routers.dart';
import 'package:nutrogen/ui/module/challenges/widget/daily_task_widget.dart';

class TaskTab extends StatelessWidget {
  const TaskTab({
    required this.buttontxt,
    super.key,
    this.isshowpoint = false,
    this.isshowActive = false,
  });

  final bool isshowpoint;
  final bool isshowActive;
  final String buttontxt;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          context.pushNamed(AppRouters.challengeDetails);
        },
        child: DailyTasksWidget(
          buttontxt: buttontxt,
          isshowpoint: isshowpoint,
          isshowActive: isshowActive,
        ),
      ),
      itemCount: 5,
    );
  }
}
