import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nutrogen/data/model/request/update_profile_request.dart';
import 'package:nutrogen/data/model/user_model.dart';
import 'package:nutrogen/providers.dart';
import 'package:nutrogen/res/app_assets.dart';
import 'package:nutrogen/res/app_colors.dart';
import 'package:nutrogen/res/app_constants.dart';
import 'package:nutrogen/ui/common/input_textfields.dart';
import 'package:nutrogen/ui/common/liner_dropdowm_widget.dart';
import 'package:nutrogen/ui/common/state_popup.dart';
import 'package:nutrogen/ui/common/state_view.dart';
import 'package:nutrogen/ui/module/genratedAiPlan/widget/selecte_item.dart';
import 'package:nutrogen/ui/module/onbording/onbording_provider.dart';
import 'package:nutrogen/ui/module/settings/profile/profile_provider.dart';
import 'package:nutrogen/utils/date_utils.dart';
import 'package:nutrogen/utils/helper.dart';
import 'package:nutrogen/utils/validation.dart';

class ProfileSettingsPage extends HookConsumerWidget {
  const ProfileSettingsPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final UserModel? user =
        ref.read(dbServiceProvider).get(key: AppConstants.userKey);

    final firstNameController = useTextEditingController(text: user?.firstName);
    final lastNameController = useTextEditingController(text: user?.lastName);
    final emailController = useTextEditingController(text: user?.email);
    final selectedGender = useState<String?>(user?.gender);
    final ageController = useTextEditingController(text: user?.age.toString());
    final tabController = useListenable(
      useTabController(
        initialLength: 2,
        initialIndex: user?.unitMeasurements == loc.metric ? 1 : 0,
      ),
    );
    final weightController =
        useTextEditingController(text: user?.weight.toString());
    final heightController =
        useTextEditingController(text: user?.height.toString());

    final selectedGoal = useState<String?>(user?.achievement);

    final selectedActive = useState<String?>(user?.howActiveYourAre);

    void onGender(String text) {
      ref.read(registerModelProvider.notifier).setGender(text);
      selectedGender.value = text;
    }

    void onActive(String text) {
      if (selectedActive.value == text) {
        selectedActive.value = null;
        return;
      }

      selectedActive.value = text;
    }

    ref.listen(
      userProfileCallProvider,
      (previous, next) => onStatePopup(
        next,
        isShowMessage: false,
        onSuccess: (data) {
          final userData = data?.r?.user;
          ref
              .read(dbServiceProvider)
              .put(key: AppConstants.userKey, value: data?.r?.user);

          firstNameController.text = userData?.firstName ?? '';
          lastNameController.text = userData?.lastName ?? '';
          emailController.text = userData?.email ?? '';
          selectedGender.value = userData?.gender;
          ageController.text = userData?.age.toString() ?? '';
          tabController
              .animateTo(userData?.unitMeasurements == loc.metric ? 1 : 0);
          weightController.text = userData?.weight.toString() ?? '';
          heightController.text = userData?.height.toString() ?? '';
          selectedGoal.value = userData?.achievement;
        },
      ),
    );

    void onSubmit() {
      if (formKey.currentState?.validate() != true) return;
      if (selectedGender.value == null || selectedGender.value == '') {
        showMessage(message: loc.pleaseSelectGender);
        return;
      }
      if (selectedGoal.value == null || selectedGoal.value == '') {
        showMessage(message: loc.pleaseSelectAchievement);
        return;
      }
      if (selectedActive.value == null || selectedActive.value == '') {
        showMessage(message: loc.pleaseSelectActiveLevel);
        return;
      }

      final ProfileUpdateRequest request = ProfileUpdateRequest(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        gender: selectedGender.value,
        age: ageController.text,
        unitMeasurements: tabController.index == 1 ? loc.metric : loc.imperial,
        weight: weightController.text,
        height: heightController.text,
        achievement: selectedGoal.value,
        howActiveYourAre: selectedActive.value,
        branchID: user?.branchId,
        clientAdminID: user?.clientAdminId,
        dateOfJoined: user?.dateOfJoined.yyyyMMDDtoDatetime.dateTimeToyyyyMMDD,
        dob: user?.dob.yyyyMMDDtoDatetime.dateTimeToyyyyMMDD,
        fcmToken: 'FCM Token',
        mealPerDay: '${user?.mealPerDay}',
        mealPlanPreference: user?.mealPlanPreference,
        phone: user?.phone,
        phoneNoCountryCode: user?.phoneNoCountryCode,
        profilePicture: user?.profilePicture,
      );

      ref.read(userUpdateProvider.notifier).userUpdateCall(request: request);
    }

    ref.listen(
      userUpdateProvider,
      (previous, next) => onStatePopup(
        next,
        onSuccess: (data) async {
          ref.invalidate(userProfileCallProvider);
        },
      ),
    );

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
        title: Text(
          loc.profilesettings,
          style:
              theme.primaryTextTheme.bodyLarge?.copyWith(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  loc.firstName,
                  style: theme.textTheme.headlineSmall,
                ),
              ),
              10.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: InputTextfields(
                  hint: loc.firstName,
                  controller: firstNameController,
                  bordercolor: AppColors.lightGray,
                  fillcolor: AppColors.white,
                  validator: firstNameValidate,
                  keyboardType: TextInputType.name,
                ),
              ),
              20.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  loc.lastName,
                  style: theme.textTheme.headlineSmall,
                ),
              ),
              10.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: InputTextfields(
                  hint: loc.lastName,
                  controller: lastNameController,
                  bordercolor: AppColors.lightGray,
                  fillcolor: AppColors.white,
                  validator: lastNameValidate,
                  keyboardType: TextInputType.name,
                ),
              ),
              20.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  loc.email,
                  style: theme.textTheme.headlineSmall,
                ),
              ),
              10.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: InputTextfields(
                  hint: loc.email,
                  controller: emailController,
                  bordercolor: AppColors.lightGray,
                  fillcolor: AppColors.white,
                  validator: emailValidate,
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              20.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  loc.gender,
                  style: theme.textTheme.headlineSmall,
                ),
              ),
              10.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  20.horizontalSpace,
                  InkWell(
                    onTap: () => onGender(loc.female),
                    borderRadius: BorderRadius.circular(10.r),
                    child: Row(
                      children: [
                        Container(
                          width: 40.w,
                          height: 40.w,
                          padding: EdgeInsets.all(10.w),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: selectedGender.value == loc.female
                                ? AppColors.blueberry
                                : AppColors.white,
                          ),
                          child: SvgPicture.asset(
                            AppAssets.svgFemale,
                            colorFilter: ColorFilter.mode(
                              selectedGender.value == loc.female
                                  ? AppColors.white
                                  : AppColors.smokyBlack,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        10.horizontalSpace,
                        Text(
                          loc.female,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: selectedGender.value == loc.female
                                ? AppColors.eerieBlack
                                : AppColors.quickSilver,
                          ),
                        ),
                      ],
                    ),
                  ),
                  30.horizontalSpace,
                  InkWell(
                    onTap: () => onGender(loc.male),
                    borderRadius: BorderRadius.circular(10.r),
                    child: Row(
                      children: [
                        Container(
                          width: 40.w,
                          height: 40.w,
                          padding: EdgeInsets.all(10.w),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: selectedGender.value == loc.male
                                ? AppColors.blueberry
                                : AppColors.white,
                          ),
                          child: SvgPicture.asset(
                            AppAssets.svgMale,
                            colorFilter: ColorFilter.mode(
                              selectedGender.value == loc.male
                                  ? AppColors.white
                                  : AppColors.smokyBlack,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        10.horizontalSpace,
                        Text(
                          loc.male,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: selectedGender.value == loc.male
                                ? AppColors.eerieBlack
                                : AppColors.quickSilver,
                          ),
                        ),
                      ],
                    ),
                  ),
                  20.horizontalSpace,
                ],
              ),
              20.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  loc.age,
                  style: theme.textTheme.headlineSmall,
                ),
              ),
              10.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: InputTextfields(
                  hint: loc.age,
                  controller: ageController,
                  bordercolor: AppColors.lightGray,
                  fillcolor: AppColors.white,
                  validator: ageValidate,
                  maxLength: 3,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                ),
              ),
              20.verticalSpace,
              Row(
                children: [
                  20.horizontalSpace,
                  Text(
                    loc.measurementUnit,
                    style: theme.textTheme.headlineSmall,
                  ),
                  40.horizontalSpace,
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(5.w),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(50.r),
                      ),
                      child: TabBar(
                        controller: tabController,
                        dividerHeight: 0,
                        labelStyle: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                          fontFamily: AppAssets.fontPlusJakartaSans,
                        ),
                        unselectedLabelStyle:
                            theme.textTheme.bodyMedium?.copyWith(
                          color: AppColors.black,
                          fontFamily: AppAssets.fontPlusJakartaSans,
                        ),
                        unselectedLabelColor: AppColors.black,
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelPadding: EdgeInsets.symmetric(vertical: 12.h),
                        indicator: BoxDecoration(
                          color: AppColors.blueberry,
                          borderRadius: BorderRadius.circular(50.r),
                        ), //Change background color from here
                        tabs: [
                          Text(loc.imperial),
                          Text(loc.metric),
                        ],
                      ),
                    ),
                  ),
                  20.horizontalSpace,
                ],
              ),
              20.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  20.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${loc.weight} (${tabController.index == 0 ? loc.lbs : loc.kg})',
                          style: theme.textTheme.headlineSmall,
                        ),
                        10.verticalSpace,
                        InputTextfields(
                          hint: '25',
                          controller: weightController,
                          bordercolor: AppColors.lightGray,
                          fillcolor: AppColors.white,
                          validator: weightValidate,
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                  ),
                  15.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${loc.height} (${tabController.index == 0 ? loc.inch : loc.cm})',
                          style: theme.textTheme.headlineSmall,
                        ),
                        10.verticalSpace,
                        InputTextfields(
                          hint: '25',
                          controller: heightController,
                          bordercolor: AppColors.lightGray,
                          fillcolor: AppColors.white,
                          validator: heightValidate,
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                  ),
                  20.horizontalSpace,
                ],
              ),
              20.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  loc.whatDoYouWantToAchieve,
                  style: theme.textTheme.headlineSmall,
                ),
              ),
              10.verticalSpace,
              Consumer(
                builder: (context, ref, child) {
                  final propData = ref.watch(registerPropProvider(type: '1'));
                  return onStateView(
                    propData,
                    child: (data) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: LinerDropdownWidget(
                        textcolor: AppColors.black,
                        list: data
                                ?.map((e) => '${e.propAlternativeName}')
                                .toList() ??
                            [],
                        hint: loc.yourGoal,
                        bordercolor: AppColors.lightGray,
                        onItem: (String? val) {
                          selectedGoal.value = val;
                        },
                        selectedValue: data
                                    ?.map((e) => '${e.propAlternativeName}')
                                    .contains(selectedGoal.value) ==
                                true
                            ? selectedGoal.value
                            : null,
                        fillcolor: AppColors.white,
                        iswhite: true,
                      ),
                    ),
                  );
                },
              ),
              20.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  loc.howActiveAreYou,
                  style: theme.textTheme.headlineSmall,
                ),
              ),
              15.verticalSpace,
              Consumer(
                builder: (context, ref, child) {
                  final propData = ref.watch(registerPropProvider(type: '2'));
                  return onStateView(
                    propData,
                    child: (data) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: SelectedItem(
                        planList: data
                                ?.map((e) => '${e.propAlternativeName}')
                                .toList() ??
                            [],
                        selectedList: ['${selectedActive.value}'],
                        onSelect: onActive,
                      ),
                    ),
                  );
                },
              ),
              50.verticalSpace,
              Center(
                child: ElevatedButton(
                  onPressed: onSubmit,
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size.fromHeight(55.h),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 68.w),
                    child: Text(
                      loc.submit,
                      style: theme.primaryTextTheme.titleMedium,
                    ),
                  ),
                ),
              ),
              50.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
