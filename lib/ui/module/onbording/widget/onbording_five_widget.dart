import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/ui/common/state_view.dart';
import 'package:nutrogen/ui/module/onbording/onbording_provider.dart';
import 'package:nutrogen/ui/module/onbording/widget/selector_button_widget.dart';
import 'package:nutrogen/utils/helper.dart';

class OnbordingFiveWidget extends HookConsumerWidget {
  const OnbordingFiveWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedActive =
        useState<String?>(ref.read(registerModelProvider).howActiveYourAre);

    void onActive(String text) {
      ref.read(registerModelProvider.notifier).setActiveLevel(text);
      selectedActive.value = text;
    }

    return Consumer(
      builder: (context, ref, child) {
        final propData = ref.watch(registerPropProvider(type: '2'));
        return onStateView(
          propData,
          child: (data) => Column(
            children: [
              Text(
                data?[0].propName ?? loc.howActiveAreYou,
                style: theme.textTheme.displaySmall,
              ),
              60.verticalSpace,
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) => SelectorButtonWidget(
                    title: '${data?[index].propAlternativeName}',
                    selectedGoal: selectedActive.value,
                    tooltipText: '${data?[index].propAlternativeName}',
                    onTap: () => onActive('${data?[index].propAlternativeName}'),
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
