import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:top_jobs/core/constants/locale_keys.g.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/helpers/image_picker.dart';
import 'package:top_jobs/core/theme/app_colors.dart';
import 'package:top_jobs/core/theme/app_svg.dart';
import 'package:top_jobs/core/theme/app_text_styles.dart';
import 'package:top_jobs/feature/common/data/models/category.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_button.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_header.dart';
import 'package:top_jobs/feature/common/presentation/widget/footer.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_layout.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_toasttifications.dart';
import 'package:top_jobs/feature/profile/presentation/pages/edit_profile/widgets/w_decorated_item.dart';
import 'package:top_jobs/feature/profile/presentation/pages/edit_profile/widgets/w_user_avatar.dart';
import 'package:top_jobs/feature/profile/presentation/pages/edit_profile/widgets/w_user_info.dart';
import 'package:path/path.dart' as p;

import '../../../../../core/router/app_routes.dart';
import '../../../../common/data/models/user_update_request.dart';
import '../../../../common/presentation/cubits/user_cubit/user_cubit.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  static const _maxLength = 120;

  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _surnameController;
  late TextEditingController _emailController;
  late TextEditingController _birthdayController;
  late TextEditingController _genderController;
  late TextEditingController _categoryController;
  late TextEditingController _aboutMeController;
  late TextEditingController _cityController;
  List<File> _portfolios = [];
  List<CategoryModel> _categories = [];
  File? _verifyDoc;
  File? _userAvatar;

  @override
  void initState() {
    _nameController = TextEditingController();
    _surnameController = TextEditingController();
    _emailController = TextEditingController();
    _birthdayController = TextEditingController();
    _genderController = TextEditingController();
    _categoryController = TextEditingController();
    _aboutMeController = TextEditingController();
    _cityController = TextEditingController();
    _aboutMeController.addListener(_verifyDescription);
    initUser();

    super.initState();
  }

  void initUser() {
    final user = context.read<UserCubit>().state.user;
    _nameController.text = user?.firstName ?? '';
    _surnameController.text = user?.lastName ?? '';
    _emailController.text = user?.email ?? "";

    _birthdayController.text =
        user?.birthDay != null
            ? DateFormat('yyyy/MM/dd').format(user!.birthDay!)
            : '';

    _genderController.text =
        user?.gender == 'male'
            ? LocaleKeys.Male.tr()
            : user?.gender == 'female'
            ? LocaleKeys.Female.tr()
            : '';
    _aboutMeController.text = user?.aboutMe ?? '';
    _cityController.text = user?.city ?? "";
    _categories = user?.categories ?? [];
    _categoryController.text =
        user?.categories
            ?.map(
              (e) =>
                  e
                      .translations[navigatorKey.currentContext?.locale == 'ru'
                          ? 0
                          : 1]
                      .name,
            )
            .join(',') ??
        '';
  }

  void _verifyDescription() {
    final text = _aboutMeController.text;
    if (text.length > _maxLength) {
      final newText = text.substring(0, _maxLength);
      _aboutMeController.value = _aboutMeController.value.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    }
  }

  @override
  void dispose() {
    _aboutMeController.removeListener(_verifyDescription);
    _nameController.dispose();
    _surnameController.dispose();
    _emailController.dispose();
    _birthdayController.dispose();
    _genderController.dispose();
    _categoryController.dispose();
    _aboutMeController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state.profileAvatarSt.isLoaded() &&
            state.editSt.isLoaded() &&
            state.verificationDocSt.isLoaded() &&
            state.portfolioSt.isLoaded()) {
          showSuccessToast(LocaleKeys.profileUpdatedSuccessfully.tr());
          context.pop();
        }
      },
      builder: (context, state) {
        bool isLoading =
            state.portfolioSt.isLoading() ||
            state.profileAvatarSt.isLoading() ||
            state.verificationDocSt.isLoading() ||
            state.editSt.isLoading();
        final user = state.user;
        return Form(
          key: _formKey,
          child: WLayout(
            child: Scaffold(
              backgroundColor: AppColors.cFFFFFF,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppHeader(isPopAvailable: true),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              40.verticalSpace,
                              Text(
                                LocaleKeys.editProfile.tr(),
                                style: AppTextStyles.size28Bold.copyWith(
                                  color: AppColors.c2E3A59,
                                ),
                              ),
                              20.verticalSpace,

                              WUserAvatar(
                                user: user,
                                userAvatar: _userAvatar,
                                onTapCamera: () async {
                                  context.pop();
                                  final image = await ImagePickerHelper()
                                      .pickImage(ImageSource.camera);

                                  if (image != null) {
                                    setState(() {
                                      _userAvatar = image;
                                    });
                                  }
                                },
                                onTapGallery: () async {
                                  context.pop();
                                  final image = await ImagePickerHelper()
                                      .pickImage(ImageSource.gallery);

                                  if (image != null) {
                                    setState(() {
                                      _userAvatar = image;
                                    });
                                  }
                                },
                              ),
                              20.verticalSpace,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  WUserInfo(
                                    categories: _categories,
                                    categoriesChanged: (categories) {
                                      setState(() {
                                        _categories = categories;
                                        _categoryController.text = categories
                                            .map((e) {
                                              return e
                                                  .translations[context
                                                              .locale ==
                                                          'ru'
                                                      ? 0
                                                      : 1]
                                                  .name;
                                            })
                                            .join(',');
                                      });
                                    },
                                    nameController: _nameController,
                                    surnameController: _surnameController,
                                    emailController: _emailController,
                                    birthdayController: _birthdayController,
                                    genderController: _genderController,
                                    categoryController: _categoryController,
                                    aboutMeController: _aboutMeController,
                                    cityController: _cityController,
                                  ),
                                  22.verticalSpace,
                                  WDecoratedTitle(
                                    isBold: true,
                                    title: LocaleKeys.portfolio.tr(),
                                  ),
                                  Wrap(
                                    spacing: 8.w,
                                    runSpacing: 8.h,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.start,
                                    children: [
                                      if (_portfolios.isNotEmpty)
                                        WImagesPreView(
                                          files: _portfolios,
                                          removeImage: (index) {
                                            setState(() {
                                              _portfolios.removeAt(index);
                                            });
                                          },
                                        ),
                                      if (((user?.portfolios ?? []).length +
                                              _portfolios.length) <
                                          4)
                                        WPortfolioItem(
                                          onTapGallery: () async {
                                            context.pop();
                                            final images =
                                                await ImagePickerHelper()
                                                    .pickMultiImage();

                                            if (images.isNotEmpty) {
                                              setState(() {
                                                _portfolios.addAll(images);
                                              });
                                            }
                                          },
                                          onTapCamera: () {},
                                        ),
                                    ],
                                  ),
                                  22.verticalSpace,
                                  WDecoratedTitle(
                                    isBold: true,
                                    title: LocaleKeys.documentVerification.tr(),
                                  ),
                                  if (_verifyDoc == null)
                                    SizedBox(
                                      height: 50.h,
                                      child: AppButton(
                                        width: 100.sw,
                                        onPressed: () async {
                                          final doc =
                                              await ImagePickerHelper()
                                                  .pickDoc();

                                          if (doc != null) {
                                            setState(() {
                                              _verifyDoc = doc;
                                            });
                                          }
                                        },
                                        text: LocaleKeys.addDoc.tr(),
                                        color: AppColors.c15CF74,
                                      ),
                                    ),

                                  if (_verifyDoc != null)
                                    Stack(
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            await OpenFile.open(
                                              _verifyDoc!.path,
                                              type: p.extension(
                                                _verifyDoc!.path,
                                              ),
                                            );
                                          },
                                          borderRadius: BorderRadius.circular(
                                            12.r,
                                          ),
                                          child: Ink(
                                            decoration: BoxDecoration(
                                              color: AppColors.cF7F9FC,
                                              borderRadius:
                                                  BorderRadius.circular(12.r),
                                            ),
                                            child: Row(
                                              spacing: 15.w,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SvgPicture.asset(
                                                  AppSvg.icFile,
                                                  height: 50.h,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      (_verifyDoc?.path
                                                                      .split(
                                                                        "/",
                                                                      )
                                                                      .last
                                                                      .length ??
                                                                  0) <
                                                              19
                                                          ? "${_verifyDoc?.path.split("/").last}"
                                                          : "${_verifyDoc?.path.split("/").last}"
                                                                  .substring(
                                                                    0,
                                                                    18,
                                                                  ) +
                                                              "..."
                                                                  ".${_verifyDoc?.path.split(".").last}",
                                                      style:
                                                          AppTextStyles
                                                              .size17Medium,
                                                    ),
                                                    Text(
                                                      "${((_verifyDoc?.lengthSync() ?? 0) / 1024).toStringAsFixed(2)} KB",
                                                      style:
                                                          AppTextStyles
                                                              .size17Medium,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ).paddingAll(12.r),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                _verifyDoc = null;
                                              });
                                            },
                                            child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20.r),
                                                color: AppColors.cFFFFFF,
                                              ),
                                              child: SvgPicture.asset(
                                                AppSvg.icCancel,
                                                height: 10,
                                              ).paddingAll(10.r),
                                            ),
                                          ),
                                        ).paddingAll(5.r),
                                      ],
                                    ),

                                  10.verticalSpace,
                                  Text(
                                    LocaleKeys.verifyNote.tr(),
                                    style: AppTextStyles.size14Medium.copyWith(
                                      color: AppColors.c888888,
                                    ),
                                  ),
                                  28.verticalSpace,
                                  WActionButtons(
                                    isLoading: isLoading,
                                    onPressed: () {
                                      if (_formKey.currentState?.validate() ??
                                          false) {
                                        context
                                            .read<UserCubit>()
                                            .updateProfileParallel(
                                              user: UserProfileUpdateRequest(
                                                categories:
                                                    _categories
                                                        .map((e) => e.id)
                                                        .toList(),
                                                city:
                                                    _cityController.text.trim(),
                                                aboutMe:
                                                    _aboutMeController.text
                                                        .trim(),
                                                birthDay:
                                                    _birthdayController.text
                                                        .trim(),
                                                email:
                                                    _emailController.text
                                                        .trim(),
                                                firstName:
                                                    _nameController.text.trim(),
                                                gender:
                                                    _genderController.text
                                                                .trim() ==
                                                            LocaleKeys.Male.tr()
                                                        ? 'male'
                                                        : _genderController.text
                                                                .trim() ==
                                                            LocaleKeys
                                                                .Female.tr()
                                                        ? 'female'
                                                        : '',
                                                lastName:
                                                    _surnameController.text
                                                        .trim(),
                                              ),
                                              avatar: _userAvatar,
                                              portfolios: _portfolios,
                                              verifyDoc: _verifyDoc,
                                            );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ).paddingSymmetric(horizontal: 16.w),
                          Footer(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class WImagesPreView extends StatelessWidget {
  const WImagesPreView({
    super.key,
    required this.files,
    required this.removeImage,
  });

  final List<File> files;
  final Function(int index) removeImage;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 8.h,
      spacing: 8.w,
      children: List.generate(
        files.length,
        (index) => SizedBox(
          height: 80.h,
          width: 80.h,
          child: Stack(
            children: [
              Container(
                height: 80.h,
                width: 80.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: FileImage(files[index]),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    removeImage(index);
                  },
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: AppColors.cFFFFFF,
                    ),
                    child: SvgPicture.asset(
                      AppSvg.icCancel,
                      height: 10,
                    ).paddingAll(8.r),
                  ),
                ),
              ).paddingAll(5.r),
            ],
          ),
        ),
      ),
    );
  }
}

class WPortfolioItem extends StatelessWidget {
  const WPortfolioItem({
    super.key,
    required this.onTapGallery,
    required this.onTapCamera,
  });

  final VoidCallback onTapGallery;
  final VoidCallback onTapCamera;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        WAvatarPicker(
          onTapGallery: onTapGallery,
          onTapCamera: onTapCamera,
          title: LocaleKeys.addPortfolio.tr(),
        ).show(context);
      },
      borderRadius: BorderRadius.circular(12.r),
      child: Ink(
        height: 80.h,
        width: 80.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: AppColors.cF7F9FC,
        ),
        child: Icon(CupertinoIcons.add),
      ),
    );
  }
}

class WActionButtons extends StatelessWidget {
  const WActionButtons({
    super.key,
    required this.onPressed,
    required this.isLoading,
  });

  final VoidCallback onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 20.w,
      children: [
        Expanded(
          child: SizedBox(
            height: 50.h,
            child: AppButton(
              onPressed: () {
                context.pop();
              },
              text: LocaleKeys.cancel.tr(),
              textStyle: AppTextStyles.size17Medium.copyWith(
                color: AppColors.cBDC0C6,
              ),
              color: AppColors.cF7F9FC,
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 50.h,
            child: AppButton(
              onPressed: onPressed,
              isLoading: isLoading,
              text: LocaleKeys.save.tr(),
              textStyle: AppTextStyles.size17Medium.copyWith(
                color: AppColors.cFFFFFF,
              ),
              color: AppColors.cFF9914,
            ),
          ),
        ),
      ],
    );
  }
}
