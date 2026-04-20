import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:top_jobs/core/constants/locale_keys.g.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/helpers/formatters.dart';
import 'package:top_jobs/core/router/route_names.dart';
import 'package:top_jobs/core/theme/app_colors.dart';
import 'package:top_jobs/core/theme/app_svg.dart';
import 'package:top_jobs/core/theme/app_text_styles.dart';
import 'package:top_jobs/feature/common/presentation/cubits/cities_cubit/cities_cubit.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_divider.dart';
import 'package:top_jobs/feature/vacancies/data/models/vacancy_query_params.dart';
import 'package:top_jobs/feature/vacancies/presentation/pages/filter_form/widget/w_cities_list.dart';
import 'package:top_jobs/feature/vacancies/presentation/pages/filter_form/widget/w_employment_type_list.dart';
import 'package:top_jobs/feature/vacancies/presentation/pages/filter_form/widget/w_filters_row.dart';
import '../../../../common/presentation/widget/app_text_form_field.dart';

List<String> employmentTypes = [
  LocaleKeys.fullEmployment.tr(),
  LocaleKeys.partialEmployment.tr(),
  LocaleKeys.internship.tr(),
  LocaleKeys.otheR.tr(),
];

List<String> employeeValues = [
  'full employment',
  'partial employment',
  'internship',
  'other',
];

class FilterForm extends StatefulWidget {
  final QueryParams queryParams;

  const FilterForm({super.key, required this.queryParams});

  @override
  _FilterFormState createState() => _FilterFormState();
}

class _FilterFormState extends State<FilterForm> {
  List<int> _chosenCategories = [];
  List<String> _chosenEmploymentTypes = [];
  String _chosenCity = '';

  final salaryMinController = TextEditingController();
  late String currency;

  @override
  void initState() {
    _chosenCategories = widget.queryParams.categories ?? [];
    _chosenEmploymentTypes = widget.queryParams.employmentTypes ?? [];
    _chosenCity = widget.queryParams.city ?? '';
    salaryMinController.text =
        widget.queryParams.priceMin != null ? Formatters.moneyFormat(widget.queryParams.priceMin!.toInt().toString()) : '';
    currency = "USD";

    super.initState();
  }

  void updateCurrency() {
    if (currency == 'USD') {
      setState(() {
        currency = "UZS";
      });
    } else {
      setState(() {
        currency = "USD";
      });
    }
  }

  void checkUpdateCurrency() {
    final salaryMin = int.tryParse(
      salaryMinController.text.trim().replaceAll(RegExp(r'[^\d]'), ''),
    );

    if (salaryMin == null) return;
    if (salaryMin > 50000) {
      setState(() {
        currency = "UZS";
      });
    } else {
      setState(() {
        currency = "USD";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.cFFFFFF,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          backgroundColor: AppColors.cFFFFFF,
          appBar: AppBar(
            surfaceTintColor: AppColors.cTransparent,
            backgroundColor: AppColors.cFFFFFF,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                context.pop(
                  QueryParams(
                    categories: _chosenCategories,
                    employmentTypes: _chosenEmploymentTypes,
                    city: _chosenCity,
                    priceMin: double.tryParse(
                      salaryMinController.text.trim().replaceAll(' ', ''),
                    ),
                  ),
                );
              },
              icon: SvgPicture.asset(AppSvg.icBack),
            ).paddingOnly(left: 10.w),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppDivider(width: 10.sw, color: AppColors.cE0E5EB, height: 1.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(LocaleKeys.filter.tr(), style: AppTextStyles.size28Bold),

                  TextButton(
                    onPressed: () {
                      _chosenCategories.clear();
                      _chosenEmploymentTypes.clear();
                      _chosenCity = '';
                      salaryMinController.clear();
                      setState(() {});
                      context.pop(QueryParams.empty());
                    },
                    child: Text(
                      LocaleKeys.clearFilter.tr(),
                      style: AppTextStyles.size16Medium.copyWith(
                        color: AppColors.cRed,
                      ),
                    ),
                  ),
                ],
              ).paddingSymmetric(vertical: 24.h, horizontal: 16.w),
              WCategoryRow(
                isEnable: _chosenCategories.isNotEmpty,
                title: LocaleKeys.category.tr(),
                onTap: () async {
                  final List<int>? response = await context.push(
                    Routes.categoriesPage,
                    extra: _chosenCategories,
                  );
                  if (response != null) {
                    setState(() {
                      _chosenCategories = response;
                    });
                  }
                },
              ),
              WCategoryRow(
                isEnable: _chosenEmploymentTypes.isNotEmpty,
                title: LocaleKeys.employmentType.tr(),
                onTap: () async {
                  final response = await WEmploymentTypeList(
                    employeeTypes: _chosenEmploymentTypes,
                  ).show(context);

                  if (response != null) {
                    setState(() {
                      _chosenEmploymentTypes = List.from(response!);
                    });
                  }
                },
              ),
              WCategoryRow(
                isEnable: _chosenCity.isNotEmpty,
                title: LocaleKeys.city.tr(),
                onTap: () async {
                  if (context.read<CitiesCubit>().state.status.isLoaded()) {
                    final response = await WCitiesList(
                      city: _chosenCity,
                    ).show(context);

                    if (response != null) {
                      setState(() {
                        _chosenCity = response;
                      });
                    }
                  }
                },
              ),
              Text(
                LocaleKeys.salary.tr(),
                style: AppTextStyles.size18Medium.copyWith(
                  color: AppColors.c333333,
                ),
              ).paddingSymmetric(horizontal: 40.w, vertical: 16.h),
              AppTextFormField(
                maxLines: 1,
                minLines: 1,
                hintText: LocaleKeys.from.tr(),
                controller: salaryMinController,
                fillColor: AppColors.cFBFBFD,
                keyBoardType: TextInputType.number,
                formatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (value) {
                  salaryMinController.text = Formatters.moneyFormat(
                    salaryMinController.text,
                  );
                  checkUpdateCurrency();
                },
                suffixIcon: IconButton(
                  onPressed: () {
                    updateCurrency();
                  },
                  padding: EdgeInsets.zero,
                  icon: Text(
                    currency,
                    style: AppTextStyles.size20Bold.copyWith(
                      color: AppColors.cFF9914,
                    ),
                  ),
                ),
              ).paddingSymmetric(horizontal: 40.w),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.pop(
                      QueryParams(
                        categories: _chosenCategories,
                        employmentTypes: _chosenEmploymentTypes,
                        city: _chosenCity,
                        priceMin: double.tryParse(
                          salaryMinController.text.trim().replaceAll(' ', ''),
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.cFF9914,
                    foregroundColor: AppColors.cFFFFFF,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                  ),
                  child: Text(
                    LocaleKeys.applyFilter.tr(),
                    style: AppTextStyles.size18Bold.copyWith(
                      color: AppColors.cFFFFFF,
                    ),
                  ),
                ),
              ).paddingSymmetric(horizontal: 16.w, vertical: 35.h),
            ],
          ),
        ),
      ),
    );
  }
}
