import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:top_jobs/feature/ads_form/presentation/pages/vacancy_form_page/widgets/vacancy_form_state.dart';
import 'package:top_jobs/feature/ads_form/presentation/pages/vacancy_form_page/widgets/w_vacancy_photos.dart';

import '../../../../../../core/constants/locale_keys.g.dart';
import '../../../../../../core/helpers/image_picker.dart';
import '../../../../../common/presentation/widget/w_toasttifications.dart';
import '../../../../../profile/presentation/pages/edit_profile/widgets/w_user_avatar.dart';

class VacancyFormPhotos extends StatefulWidget {
  const VacancyFormPhotos({super.key, required this.formCustomState});

  final VacancyFormCustomState formCustomState;

  @override
  State<VacancyFormPhotos> createState() => _VacancyFormPhotosState();
}

class _VacancyFormPhotosState extends State<VacancyFormPhotos> {
  Future<void> _uploadImagesFromGallery() async {
    context.pop();
    final images = await ImagePickerHelper().pickMultiImage();

    if (images.isNotEmpty) {
      if ((widget.formCustomState.images.length + images.length) <= 4) {
        const int maxTotalSizeInBytes = 10 * 1024 * 1024;
        int totalSize = 0;
        for (final image in widget.formCustomState.images) {
          totalSize += image.lengthSync();
        }
        if (totalSize > maxTotalSizeInBytes) {
          showErrorToast("Maximum 10 mb ");
        } else {
          setState(() {
            widget.formCustomState.images.addAll(images);
          });
        }
      } else {
        showErrorToast("Maximum 4 ta rasm yuklash mumin");
      }
    } else {
      showErrorToast("Rasm topilmadi");
    }
  }

  Future<void> _uploadImageFromCamera() async {
    final image = await ImagePickerHelper().pickImage(ImageSource.camera);

    if (image != null) {
      widget.formCustomState.images.add(image);
      setState(() {});
    } else {
      showErrorToast("Rasm topilmadi");
    }
  }

  void _removeImageFromList(int index) {
    setState(() {
      widget.formCustomState.images..removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WVacancyPhotos(
      onTapRemove: _removeImageFromList,
      files: widget.formCustomState.images,
      onPressedAdd: () async {
        WAvatarPicker(
          onTapGallery: _uploadImagesFromGallery,
          onTapCamera: _uploadImageFromCamera,
          title: LocaleKeys.uploadImage.tr(),
        ).show(context);
      },
    );
  }
}
