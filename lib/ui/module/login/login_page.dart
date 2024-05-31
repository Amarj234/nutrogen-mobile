import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/providers.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/res/app_constants.dart';
import 'package:nutrogen/res/app_routers.dart';
import 'package:nutrogen/ui/common/image_widget.dart';
import 'package:nutrogen/ui/common/state_popup.dart';
import 'package:nutrogen/ui/common/text_field_widget.dart';
import 'package:nutrogen/ui/module/login/login_provider.dart';
import 'package:nutrogen/ui/module/login/widget/continue_with_button_widget.dart';
import 'package:nutrogen/utils/helper.dart';
import 'package:nutrogen/utils/validation.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    GestureRecognizer onSignup = useMemoized(
      () => TapGestureRecognizer()
        ..onTap = () {
          context.pushNamed(AppRouters.signup);
        },
    );

    void onGoogle() {}
    void onFacebook() {}
    void onApple() {}
    void onForgotPassword() {}

    void onLogin() {
      if (formKey.currentState?.validate() != true) return;
      ref.read(loginProvider.notifier).loginCall(
            email: emailController.text,
            password: passwordController.text,
          );
    }

    ref.listen(
      loginProvider,
      (previous, next) => onStatePopup(
        next,
        onSuccess: (data) async {
          await ref
              .read(dbServiceProvider)
              .put(key: AppConstants.tokenKey, value: data?.r?.token);
          await ref.read(dbServiceProvider).put(
                key: AppConstants.userKey,
                value:
                    data?.r?.user?.copyWith(password: passwordController.text),
              );

          if (context.mounted) {
            context.goNamed(AppRouters.dashboard);
          }
        },
      ),
    );

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            Platform.isIOS ? 42.verticalSpace : 15.verticalSpace,
            const ImageWidget(
              AppAssets.pngLogo,
            ),
            const Spacer(
              flex: 2,
            ),
            ContinueWithButton(
              text: loc.continueWithGoogle,
              svg: AppAssets.svgGoogle,
              color: AppColors.begonia,
              onTap: onGoogle,
            ),
            const Spacer(),
            ContinueWithButton(
              text: loc.continueWithFacebook,
              svg: AppAssets.svgFacebook,
              color: AppColors.crayola,
              onTap: onFacebook,
            ),
            const Spacer(),
            ContinueWithButton(
              text: loc.continueWithAppleId,
              svg: AppAssets.svgApple,
              color: AppColors.smokyBlack,
              onTap: onApple,
            ),
            const Spacer(
              flex: 2,
            ),
            Row(
              children: [
                Expanded(
                  child: Divider(
                    color: AppColors.columbiaBlue,
                    height: 1.h,
                  ),
                ),
                8.horizontalSpace,
                Text(
                  loc.or,
                  style: theme.textTheme.titleSmall
                      ?.copyWith(color: AppColors.columbiaBlue),
                ),
                8.horizontalSpace,
                Expanded(
                  child: Divider(
                    color: AppColors.columbiaBlue,
                    height: 1.h,
                  ),
                ),
              ],
            ),
            const Spacer(
              flex: 2,
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFieldWidget(
                    controller: emailController,
                    hintText: loc.email,
                    topRound: true,
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
                    bottomRound: true,
                    keyboardType: TextInputType.visiblePassword,
                    validator: passwordValidate,
                  ),
                ],
              ),
            ),
            const Spacer(
              flex: 2,
            ),
            ElevatedButton(
              onPressed: onLogin,
              style: ElevatedButton.styleFrom(
                fixedSize: Size(0.906.sw, 60.h),
              ),
              child: Text(
                loc.login,
                style: theme.primaryTextTheme.headlineSmall,
              ),
            ),
            TextButton(
              onPressed: onForgotPassword,
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                minimumSize: Size.zero,
              ),
              child: Text(
                loc.forgotPassword,
                style: theme.textTheme.bodyMedium
                    ?.copyWith(decoration: TextDecoration.underline),
              ),
            ),
            const Spacer(
              flex: 4,
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
                    recognizer: onSignup,
                    text: loc.signUp_,
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
