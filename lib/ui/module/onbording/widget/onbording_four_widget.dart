import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/ui/common/state_view.dart';
import 'package:nutrogen/ui/module/onbording/onbording_provider.dart';
import 'package:nutrogen/ui/module/onbording/widget/selector_button_widget.dart';
import 'package:nutrogen/utils/helper.dart';

class OnbordingFourWidget extends HookConsumerWidget {
  const OnbordingFourWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedGoal =
        useState<String?>(ref.read(registerModelProvider).achievement);

    void onAchieve(String text) {
      ref.read(registerModelProvider.notifier).setAchievement(text);
      selectedGoal.value = text;
    }

    return Consumer(
      builder: (context, ref, child) {
        final propData = ref.watch(registerPropProvider(type: '1'));
        return onStateView(
          propData,
          child: (data) => Column(
            children: [
              Text(
                data?[0].propName ?? loc.whatDoYouWantToAchieve,
                style: theme.textTheme.displaySmall,
              ),
              60.verticalSpace,
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) => SelectorButtonWidget(
                    title: '${data?[index].propAlternativeName}',
                    selectedGoal: selectedGoal.value,
                    onTap: () => onAchieve('${data?[index].propAlternativeName}'),
                  ),
                  separatorBuilder: (context, index) => 12.verticalSpace,
                  itemCount: data?.length ?? 0,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
