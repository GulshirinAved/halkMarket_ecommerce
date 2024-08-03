import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/blocs/categoryProfile/filter/brandExpand/brand_expand_cubit.dart';
import 'package:halkmarket_ecommerce/blocs/categoryProfile/filter/brandSelection/brand_selection_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/categoryProfile/filter/categoryExpand/category_expand_cubit.dart';
import 'package:halkmarket_ecommerce/blocs/categoryProfile/filter/categorySelection/category_selection_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/categoryProfile/filter/priceSelection/price_selection_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/categoryProfile/filter/sortSelection/sort_selection_bloc.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/config/theme/theme.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_checkBox.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_radio.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_textField.dart';

Future<dynamic> filterBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.whiteColor,
    constraints: BoxConstraints(
      minHeight: MediaQuery.of(context).size.height * .9,
      maxHeight: MediaQuery.of(context).size.height * .9,
    ),
    useSafeArea: true,
    builder: (BuildContext contextt) => MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: context.read<SortSelectionBloc>(),
        ),
        BlocProvider.value(
          value: context.read<PriceSelectionBloc>(),
        ),
        BlocProvider.value(
          value: context.read<CategorySelectionBloc>(),
        ),
        BlocProvider.value(
          value: context.read<BrandSelectionBloc>(),
        ),
        BlocProvider(
          create: (context) => ToggleCubit(),
        ),
        BlocProvider(
          create: (context) => BrandExpandCubit(),
        ),
      ],
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(contextt);
                },
                icon: Icon(
                  CupertinoIcons.clear_thick,
                  color: AppColors.grey1Color,
                  size: 20,
                ),
              ),
              Text(
                AppLocalization.of(context).getTransatedValues('filters') ?? '',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: AppFonts.fontSize18,
                  color: AppColors.darkPurpleColor,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.only(right: 6),
                  child: Text(
                    AppLocalization.of(context).getTransatedValues('clean') ??
                        '',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: AppFonts.fontSize14,
                      color: AppColors.redColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
          //sort
          const SortTile(),
          //price
          PriceTile(
            contextt: contextt,
          ),
          //category checkbox tile
          const CategoryTile(),
          // brand checkbox tile
          const BrandTile(),
        ],
      ),
    ),
  );
}

class BrandTile extends StatelessWidget {
  const BrandTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: Text(
            AppLocalization.of(context).getTransatedValues('brands') ?? '',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: AppFonts.fontSize16,
              color: AppColors.darkPurpleColor,
            ),
          ),
        ),
        BlocBuilder<BrandExpandCubit, bool>(
          builder: (context, showAll) {
            int itemCount = showAll
                ? brands.length
                : brands.length <= 5
                    ? brands.length
                    : 5;
            return Column(
              children: List.generate(
                itemCount,
                (index) => BlocBuilder<BrandSelectionBloc, BrandSelectionState>(
                  builder: (context, state) {
                    return CustomCheckBox(
                      isChecked: state.brandList.any(
                        (brand) => brand['name'] == brands[index],
                      ),
                      title: brands[index],
                      onChanged: (value) =>
                          context.read<BrandSelectionBloc>().add(
                                ChooseBrandEvent(
                                  pressedBrandName: brands[index],
                                ),
                              ),
                    );
                  },
                ),
              ),
            );
          },
        ),
        if (brands.length > 5)
          BlocBuilder<ToggleCubit, bool>(builder: (context, showAll) {
            return TextButton(
              onPressed: () => context.read<BrandExpandCubit>().toggle(),
              child: Text(
                showAll
                    ? AppLocalization.of(context)
                            .getTransatedValues('showLess') ??
                        ''
                    : AppLocalization.of(context)
                            .getTransatedValues('showMore') ??
                        '',
                style: TextStyle(
                  color: AppColors.grey1Color,
                  fontWeight: FontWeight.w400,
                  fontSize: AppFonts.fontSize12,
                ),
              ),
            );
          }),
        const Divider(
          endIndent: 10,
          indent: 10,
        ),
      ],
    );
  }
}

class CategoryTile extends StatelessWidget {
  const CategoryTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: Text(
            AppLocalization.of(context).getTransatedValues('categories') ?? '',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: AppFonts.fontSize16,
              color: AppColors.darkPurpleColor,
            ),
          ),
        ),
        BlocBuilder<ToggleCubit, bool>(
          builder: (context, showAll) {
            int itemCount = showAll
                ? categories.length
                : categories.length <= 5
                    ? categories.length
                    : 5;
            return Column(
              children: List.generate(
                itemCount,
                (index) =>
                    BlocBuilder<CategorySelectionBloc, CategorySelectionState>(
                  builder: (context, state) {
                    return CustomCheckBox(
                      isChecked: state.categoryList.any(
                        (category) => category['name'] == categories[index],
                      ),
                      title: categories[index],
                      onChanged: (value) =>
                          context.read<CategorySelectionBloc>().add(
                                ChooseCategoryEvent(
                                  pressedCategoryName: categories[index],
                                ),
                              ),
                    );
                  },
                ),
              ),
            );
          },
        ),
        if (categories.length > 5)
          BlocBuilder<ToggleCubit, bool>(
            builder: (context, showAll) {
              return TextButton(
                onPressed: () => context.read<ToggleCubit>().toggle(),
                child: Text(
                  showAll
                      ? AppLocalization.of(context)
                              .getTransatedValues('showLess') ??
                          ''
                      : AppLocalization.of(context)
                              .getTransatedValues('showMore') ??
                          '',
                  style: TextStyle(
                    color: AppColors.grey1Color,
                    fontWeight: FontWeight.w400,
                    fontSize: AppFonts.fontSize12,
                  ),
                ),
              );
            },
          ),
        const Divider(
          endIndent: 10,
          indent: 10,
        ),
      ],
    );
  }
}

class PriceTile extends StatelessWidget {
  final BuildContext contextt;
  const PriceTile({
    required this.contextt,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalization.of(context).getTransatedValues('price') ?? '',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: AppFonts.fontSize16,
                  color: AppColors.darkPurpleColor,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 33.h,
                      child: CustomTextField.normal(
                        hinText: AppLocalization.of(context)
                                .getTransatedValues('to') ??
                            '',
                        borderColor: AppColors.grey1Color,
                        backColor: AppColors.whiteColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 33.h,
                      child: CustomTextField.normal(
                        hinText: AppLocalization.of(context)
                                .getTransatedValues('from') ??
                            '',
                        borderColor: AppColors.grey1Color,
                        backColor: AppColors.whiteColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Column(
          children: List.generate(
            getPriceList(contextt).length,
            (index) => BlocBuilder<PriceSelectionBloc, PriceSelectionState>(
              builder: (context, state) {
                return CustomRadio(
                  title: getPriceList(contextt)[index],
                  value: getPriceList(contextt)[index],
                  groupValue: state.selectedPrice,
                  fontSize: AppFonts.fontSize14,
                  onChanged: (value) => context.read<PriceSelectionBloc>().add(
                        PriceSelectionEvent(
                          pressedTitle: value ??
                              getPriceList(contextt)[
                                  getPriceList(contextt)[index].length - 1],
                        ),
                      ),
                );
              },
            ),
          ),
        ),
        const Divider(
          endIndent: 10,
          indent: 10,
        ),
      ],
    );
  }
}

class SortTile extends StatelessWidget {
  const SortTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 14.w),
          child: Text(
            AppLocalization.of(context).getTransatedValues('sort') ?? '',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: AppFonts.fontSize16,
              color: AppColors.darkPurpleColor,
            ),
          ),
        ),
        Column(
          children: List.generate(
            sortTitle.length,
            (index) => BlocBuilder<SortSelectionBloc, SortSelectionState>(
              builder: (context, state) {
                return CustomRadio(
                  title: sortTitle[index],
                  value: sortTitle[index],
                  groupValue: state.selectedTitle,
                  fontSize: AppFonts.fontSize14,
                  onChanged: (value) => context.read<SortSelectionBloc>().add(
                        SortSelectionEvent(
                          pressedTitle: value ?? sortTitle[0],
                        ),
                      ),
                );
              },
            ),
          ),
        ),
        const Divider(
          endIndent: 10,
          indent: 10,
        ),
      ],
    );
  }
}
