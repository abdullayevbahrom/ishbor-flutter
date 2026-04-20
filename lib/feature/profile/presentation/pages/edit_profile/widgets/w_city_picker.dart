import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:top_jobs/core/constants/locale_keys.g.dart';
import 'package:top_jobs/core/theme/app_colors.dart';
import 'package:top_jobs/feature/common/presentation/cubits/cities_cubit/cities_cubit.dart';
import 'package:top_jobs/feature/common/presentation/pages/w_modal_bottom_sheet_container.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_radio_list_tile.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_sheet_title.dart';

class WCityPicker extends StatefulWidget {
  const WCityPicker({super.key, required this.cityController});

  final TextEditingController cityController;

  show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      isDismissible: true,
      backgroundColor: AppColors.cFFFFFF,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.r),
        borderSide: BorderSide.none,
      ),
      builder: (context) => Wrap(children: [this]),
    );
  }

  @override
  State<WCityPicker> createState() => _WCityPickerState();
}

class _WCityPickerState extends State<WCityPicker> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CitiesCubit, CitiesState>(
      builder: (context, state) {
        return DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: AppColors.cFFFFFF,
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                11.verticalSpace,
                WModalSheetDecoratedContainer(),
                22.verticalSpace,
                WSheetTitle(title: LocaleKeys.chooseCity.tr()),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height*.5,
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    physics: const BouncingScrollPhysics(),
                    itemCount: state.listCities?.cities.length,
                    itemBuilder:
                        (context, index) => WRadioListTile(
                          title: state.listCities?.cities[index].name ?? '',
                          value:
                              widget.cityController.text.trim() ==
                              state.listCities?.cities[index].name,
                          onTap: () {
                            setState(() {
                              widget.cityController.text =
                                  state.listCities?.cities[index].name ?? '';
                            });
                            context.pop();
                          },
                        ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
