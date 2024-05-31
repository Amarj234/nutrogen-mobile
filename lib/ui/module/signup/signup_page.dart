import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/data/model/branch_list_model.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/res/app_routers.dart';
import 'package:nutrogen/ui/common/image_widget.dart';
import 'package:nutrogen/ui/common/state_popup.dart';
import 'package:nutrogen/ui/common/state_view.dart';
import 'package:nutrogen/ui/common/text_field_widget.dart';
import 'package:nutrogen/ui/module/onbording/onbording_provider.dart';
import 'package:nutrogen/utils/helper.dart';
import 'package:nutrogen/utils/validation.dart';

class SignupPage extends HookConsumerWidget {
  const SignupPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final focusNode = useFocusNode();
    final isBranchFocus = useState(false);
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final firstNameController = useTextEditingController();
    final lastNameController = useTextEditingController();
    final mobileController = useTextEditingController();
    final emailController = useTextEditingController();
    final selectedBranch = useState<String?>(null);
    final passwordController = useTextEditingController();

    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          focusNode.addListener(() {
            isBranchFocus.value = focusNode.hasFocus;
          });
        });
        return null;
      },
      [],
    );

    void onBranch(List<BranchR>? branches, String? text) {
      selectedBranch.value = text;
    }

    void onSugnup() {
      if (formKey.currentState?.validate() != true) return;

      if (selectedBranch.value == null) {
        showMessage(message: loc.pleaseSelectVaildBranch);
        return;
      }

      ref
          .read(registerModelProvider.notifier)
          .setFirstName(firstNameController.text);
      ref
          .read(registerModelProvider.notifier)
          .setLastName(lastNameController.text);
      ref.read(registerModelProvider.notifier).setMobile(mobileController.text);
      ref.read(registerModelProvider.notifier).setEmail(emailController.text);
      ref
          .read(registerModelProvider.notifier)
          .setPassword(passwordController.text);
      ref
          .read(registerModelProvider.notifier)
          .setBranchId('${selectedBranch.value}');
      context.pushNamed(
        AppRouters.paywallFirst,
      );
    }

    GestureRecognizer onLogin = useMemoized(
      () => TapGestureRecognizer()
        ..onTap = () {
          context.pop();
        },
    );

    List<DropdownMenuItem<String>> addDividersAfterItems(
      List<BranchR> branches,
    ) {
      final List<DropdownMenuItem<String>> menuItems = [];
      for (final BranchR item in branches) {
        menuItems.addAll(
          [
            DropdownMenuItem<String>(
              value: item.id,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 0),
                child: Text(
                  '${item.businessName} (${item.legalName})',
                  style: theme.textTheme.bodyMedium,
                ),
              ),
            ),
            //If it's last item, we will not add Divider after it.
            if (item != branches.last)
              DropdownMenuItem<String>(
                enabled: false,
                child: Divider(
                  color: AppColors.lightGray,
                  height: 1.h,
                ),
              ),
          ],
        );
      }
      return menuItems;
    }

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Platform.isIOS ? 42.verticalSpace : 15.verticalSpace,
            const ImageWidget(
              AppAssets.pngLogo,
            ),
            const Spacer(
              flex: 3,
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFieldWidget(
                    controller: firstNameController,
                    hintText: loc.firstName,
                    topRound: true,
                    keyboardType: TextInputType.name,
                    validator: firstNameValidate,
                  ),
                  Divider(
                    color: AppColors.lightGray,
                    height: 1.h,
                  ),
                  TextFieldWidget(
                    controller: lastNameController,
                    hintText: loc.lastName,
                    keyboardType: TextInputType.name,
                    validator: lastNameValidate,
                  ),
                  Divider(
                    color: AppColors.lightGray,
                    height: 1.h,
                  ),
                  TextFieldWidget(
                    controller: mobileController,
                    hintText: loc.mobile,
                    keyboardType: TextInputType.phone,
                    validator: mobileValidate,
                    maxLength: 10,
                  ),
                  Divider(
                    color: AppColors.lightGray,
                    height: 1.h,
                  ),
                  TextFieldWidget(
                    controller: emailController,
                    hintText: loc.email,
                    keyboardType: TextInputType.emailAddress,
                    validator: emailValidate,
                  ),
                  Divider(
                    color: AppColors.lightGray,
                    height: 1.h,
                  ),
                  TextFieldWidget(
                    controller: passwordController,
                    hintText: loc.password,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    validator: passwordValidate,
                  ),
                  Divider(
                    color: AppColors.lightGray,
                    height: 1.h,
                  ),
                  Consumer(
                    builder: (context, ref, child) {
                      final branchData = ref.watch(branchesProvider);
                      return onStateView(
                        branchData,
                        child: (data) => DropdownButton2<String>(
                          focusNode: focusNode,
                          underline: 0.verticalSpace,
                          hint: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: Text(
                              loc.selectBranch,
                              style: theme.textTheme.bodyMedium
                                  ?.copyWith(color: AppColors.darkSilver),
                            ),
                          ),
                          isExpanded: true,
                          items: addDividersAfterItems(data ?? []),
                          value: selectedBranch.value,
                          onChanged: (text) => onBranch(data, text),
                          dropdownStyleData: DropdownStyleData(
                            offset: const Offset(0, 0),
                            elevation: 0,
                            maxHeight: 200.h,
                            decoration: BoxDecoration(
                              color: AppColors.antiFlashWhite,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.lightGray.withOpacity(0.60),
                                  blurRadius: 20,
                                  spreadRadius: -5,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                              borderRadius: BorderRadius.vertical(
                                top: Radius.zero,
                                bottom: Radius.circular(10.r),
                              ),
                            ),
                          ),
                          iconStyleData: IconStyleData(
                            icon: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                          buttonStyleData: ButtonStyleData(
                            elevation: 0,
                            decoration: BoxDecoration(
                              boxShadow: focusNode.hasFocus
                                  ? [
                                      BoxShadow(
                                        color:
                                            AppColors.black.withOpacity(0.15),
                                        blurRadius: 80,
                                        offset: const Offset(0, -30),
                                      ),
                                    ]
                                  : null,
                              color:
                                  focusNode.hasFocus ? AppColors.white : null,
                              border: focusNode.hasFocus
                                  ? null
                                  : const Border(
                                      left: BorderSide(
                                        color: AppColors.lightGray,
                                      ),
                                      right: BorderSide(
                                        color: AppColors.lightGray,
                                      ),
                                      bottom: BorderSide(
                                        color: AppColors.lightGray,
                                      ),
                                    ),
                              borderRadius: focusNode.hasFocus
                                  ? BorderRadius.zero
                                  : BorderRadius.vertical(
                                      top: Radius.zero,
                                      bottom: Radius.circular(10.r),
                                    ),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 5.w,
                            ),
                            height: 50.h,
                            width: 1.sw,
                          ),
                          menuItemStyleData: MenuItemStyleData(
                            height: 28.h,
                            padding: EdgeInsets.zero,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const Spacer(
              flex: 6,
            ),
            ElevatedButton(
              onPressed: onSugnup,
              style: ElevatedButton.styleFrom(
                fixedSize: Size(0.906.sw, 54.h),
              ),
              child: Text(
                loc.signUp,
                style: theme.primaryTextTheme.headlineSmall,
              ),
            ),
            const Spacer(
              flex: 12,
            ),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: loc.dontHaveAnAccoutn,
                    style: theme.textTheme.bodyMedium,
                  ),
                  WidgetSpan(child: 4.horizontalSpace),
                  TextSpan(
                    recognizer: onLogin,
                    text: loc.login_,
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
