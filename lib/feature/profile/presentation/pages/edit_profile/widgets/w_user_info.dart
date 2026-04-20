import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:top_jobs/core/constants/locale_keys.g.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/helpers/validators.dart';
import 'package:top_jobs/core/theme/app_colors.dart';
import 'package:top_jobs/core/theme/app_svg.dart';
import 'package:top_jobs/feature/common/data/models/category.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_text_form_field.dart';
import 'package:top_jobs/feature/profile/presentation/pages/edit_profile/widgets/w_birthdate_picker.dart';
import 'package:top_jobs/feature/profile/presentation/pages/edit_profile/widgets/w_category_picker.dart';
import 'package:top_jobs/feature/profile/presentation/pages/edit_profile/widgets/w_city_picker.dart';
import 'package:top_jobs/feature/profile/presentation/pages/edit_profile/widgets/w_decorated_item.dart';
import 'package:top_jobs/feature/profile/presentation/pages/edit_profile/widgets/w_gender_picker.dart';

class WUserInfo extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController surnameController;
  final TextEditingController emailController;
  final TextEditingController birthdayController;
  final TextEditingController genderController;
  final TextEditingController categoryController;
  final TextEditingController aboutMeController;
  final TextEditingController cityController;
  final Function(List<CategoryModel> categories) categoriesChanged;
  final List<CategoryModel> categories;

  const WUserInfo({
    super.key,
    required this.nameController,
    required this.surnameController,
    required this.emailController,
    required this.birthdayController,
    required this.genderController,
    required this.categoryController,
    required this.aboutMeController,
    required this.cityController,
    required this.categoriesChanged,
    required this.categories,
  });

  @override
  State<WUserInfo> createState() => _WUserInfoState();
}

class _WUserInfoState extends State<WUserInfo> {
  static const _maxLength = 120;
  int _currentLength = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WDecoratedTitle(title: LocaleKeys.name.tr()),
        AppTextFormField(
          fillColor: AppColors.cFFFFFF,
          hintText: LocaleKeys.enterName.tr(),
          controller: widget.nameController,
          keyBoardType: TextInputType.name,
          validator: (value) {
            return ValidatorHelpers.validateField(value: value!);
          },
        ),
        22.verticalSpace,
        WDecoratedTitle(title: LocaleKeys.surname.tr()),
        AppTextFormField(
          fillColor: AppColors.cFFFFFF,
          hintText: LocaleKeys.enterSurname.tr(),
          controller: widget.surnameController,
          keyBoardType: TextInputType.name,
          validator: (value) {
            return ValidatorHelpers.validateField(value: value!);
          },
        ),
        22.verticalSpace,
        WDecoratedTitle(title: LocaleKeys.email.tr()),
        AppTextFormField(
          fillColor: AppColors.cFFFFFF,
          hintText: LocaleKeys.enterEmail.tr(),
          controller: widget.emailController,
          keyBoardType: TextInputType.emailAddress,
        ),
        22.verticalSpace,
        WDecoratedTitle(title: LocaleKeys.birthDate.tr()),
        AppTextFormField(
          fillColor: AppColors.cFFFFFF,
          hintText: "yyyy/oo/kk",
          controller: widget.birthdayController,
          keyBoardType: TextInputType.none,
          suffixIcon: SvgPicture.asset(
            AppSvg.icCalendar,
          ).paddingOnly(right: 10.w),
          onTap: () {
            showBirthdatePicker(context, widget.birthdayController);
          },
        ),
        22.verticalSpace,
        WDecoratedTitle(title: LocaleKeys.gender.tr()),
        AppTextFormField(
          fillColor: AppColors.cFFFFFF,
          hintText: LocaleKeys.chooseGender.tr(),
          controller: widget.genderController,
          keyBoardType: TextInputType.none,
          suffixIcon: SvgPicture.asset(
            AppSvg.icIosArrowRight,
          ).paddingOnly(right: 13.w),
          onTap: () {
            WGenderPicker(
              genderController: widget.genderController,
            ).show(context);
          },
        ),
        22.verticalSpace,
        WDecoratedTitle(title: LocaleKeys.category.tr()),
        AppTextFormField(
          minLines: 1,
          maxLines: 10,
          fillColor: AppColors.cFFFFFF,
          hintText: LocaleKeys.chooseCategory.tr(),
          controller: widget.categoryController,
          keyBoardType: TextInputType.none,
          suffixIcon: SvgPicture.asset(
            AppSvg.icIosArrowRight,
          ).paddingOnly(right: 13.w),
          onTap: () async {
            final List<CategoryModel>? categories = await WCategoryPicker(
              categories: widget.categories,
            ).show(context);
            if (categories != null && (categories ?? []).isNotEmpty) {
              widget.categoriesChanged(categories);
            }
          },
        ),
        24.verticalSpace,
        WDecoratedTitle(title: LocaleKeys.aboutMe.tr()),
        AppTextFormField(
          minLines: 7,
          maxLines: 10,
          currentLength: _currentLength,
          maxLength: _maxLength,
          fillColor: AppColors.cFFFFFF,
          hintText: LocaleKeys.enterText.tr(),
          controller: widget.aboutMeController,
          keyBoardType: TextInputType.text,
          formatters: [LengthLimitingTextInputFormatter(_maxLength)],
          onChanged: (value) {
            setState(() {
              _currentLength = value.length;
            });
          },
        ),
        24.verticalSpace,
        WDecoratedTitle(title: LocaleKeys.city.tr(), isBold: true),
        AppTextFormField(
          hintText: LocaleKeys.enterCity.tr(),
          controller: widget.cityController,
          keyBoardType: TextInputType.none,
          fillColor: AppColors.cFFFFFF,
          suffixIcon: SvgPicture.asset(
            AppSvg.icIosArrowRight,
          ).paddingOnly(right: 12.w),
          onTap: () {
            WCityPicker(cityController: widget.cityController).show(context);
          },
        ),
      ],
    );
  }
}
