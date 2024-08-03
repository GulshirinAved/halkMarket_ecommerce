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
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_button.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_checkBox.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_radio.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_textField.dart';

Future<dynamic> filterBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.whiteColor,
    isScrollControlled: true,
    constraints: BoxConstraints(
      minHeight: 0,
      maxHeight: MediaQuery.of(context).size.height,
    ),
    useSafeArea: true,
    builder: (BuildContext contextt) => MultiBlocProvider(
      providers: [
        BlocProvider.value(value: context.read<SortSelectionBloc>()),
        BlocProvider.value(value: context.read<PriceSelectionBloc>()),
        BlocProvider.value(value: context.read<CategorySelectionBloc>()),
        BlocProvider.value(value: context.read<BrandSelectionBloc>()),
        BlocProvider(create: (context) => ToggleCubit()),
        BlocProvider(create: (context) => BrandExpandCubit()),
      ],
      child: ListView(
        children: [
          //header arrowback,title and clean
          _buildHeader(context, contextt),
          //sort radio
          const SortTile(),
          //price textfield and  radio
          PriceTile(contextt: contextt),
          //category checkbox
          const CategoryTile(),
          //brandCheckBox
          const BrandTile(),
          //apply button
          Container(
            padding: const EdgeInsets.all(16.0),
            child: CustomButton(
              width: MediaQuery.of(context).size.width * 0.8,
              backColor: AppColors.purpleColor,
              textColor: AppColors.whiteColor,
              fontSize: AppFonts.fontSize16,
              title:
                  AppLocalization.of(context).getTransatedValues('apply') ?? '',
              onTap: () {
                context.read<SortSelectionBloc>().add(const ApplySortEvent());
                context.read<PriceSelectionBloc>().add(const ApplyPriceEvent());
                context
                    .read<CategorySelectionBloc>()
                    .add(const ApplyCategoryEvent());
                context.read<BrandSelectionBloc>().add(const ApplyBrandEvent());
              },
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildHeader(BuildContext context, BuildContext contextt) {
  return Row(
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
        onTap: () {
          context.read<SortSelectionBloc>().add(const CleanSortEvent());
          context.read<PriceSelectionBloc>().add(const CleanPriceEvent());
          context.read<CategorySelectionBloc>().add(const CleanCategoryEvent());
          context.read<BrandSelectionBloc>().add(const CleanBrandEvent());
        },
        child: Container(
          margin: const EdgeInsets.only(right: 6),
          child: Text(
            AppLocalization.of(context).getTransatedValues('clean') ?? '',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: AppFonts.fontSize14,
              color: AppColors.redColor,
            ),
          ),
        ),
      ),
    ],
  );
}

class BrandTile extends StatelessWidget {
  const BrandTile({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildTile(
      context: context,
      titleKey: 'brands',
      itemCount: brands.length,
      items: brands,
      itemBuilder: (context, index) {
        return BlocBuilder<BrandSelectionBloc, BrandSelectionState>(
          builder: (context, state) {
            return CustomCheckBox(
              isChecked: state.brandList
                  .any((brand) => brand['name'] == brands[index]),
              title: brands[index],
              onChanged: (value) => context.read<BrandSelectionBloc>().add(
                    ChooseBrandEvent(pressedBrandName: brands[index]),
                  ),
            );
          },
        );
      },
    );
  }
}

class CategoryTile extends StatelessWidget {
  const CategoryTile({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildTile(
      context: context,
      titleKey: 'categories',
      itemCount: categories.length,
      items: categories,
      itemBuilder: (context, index) {
        return BlocBuilder<CategorySelectionBloc, CategorySelectionState>(
          builder: (context, state) {
            return CustomCheckBox(
              isChecked: state.categoryList
                  .any((category) => category['name'] == categories[index]),
              title: categories[index],
              onChanged: (value) => context.read<CategorySelectionBloc>().add(
                    ChooseCategoryEvent(pressedCategoryName: categories[index]),
                  ),
            );
          },
        );
      },
    );
  }
}

Widget _buildTile({
  required BuildContext context,
  required String titleKey,
  required int itemCount,
  required List<String> items,
  required IndexedWidgetBuilder itemBuilder,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        child: Text(
          AppLocalization.of(context).getTransatedValues(titleKey) ?? '',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: AppFonts.fontSize16,
            color: AppColors.darkPurpleColor,
          ),
        ),
      ),
      BlocBuilder<ToggleCubit, bool>(
        builder: (context, showAll) {
          int displayItemCount =
              showAll ? itemCount : (itemCount <= 5 ? itemCount : 5);
          return Column(
            children: List.generate(
              displayItemCount,
              (index) => itemBuilder(context, index),
            ),
          );
        },
      ),
      if (itemCount > 5)
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
      const Divider(endIndent: 10, indent: 10),
    ],
  );
}

class PriceTile extends StatelessWidget {
  final BuildContext contextt;
  const PriceTile({required this.contextt, super.key});

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
                  SizedBox(width: 12.w),
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
                        ChoosePriceEvent(
                          pressedTitle: value ?? getPriceList(contextt).last,
                        ),
                      ),
                );
              },
            ),
          ),
        ),
        const Divider(endIndent: 10, indent: 10),
      ],
    );
  }
}

class SortTile extends StatelessWidget {
  const SortTile({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildTile(
      context: context,
      titleKey: 'sort',
      itemCount: sortTitle.length,
      items: sortTitle,
      itemBuilder: (context, index) {
        return BlocBuilder<SortSelectionBloc, SortSelectionState>(
          builder: (context, state) {
            return CustomRadio(
              title: AppLocalization.of(context)
                      .getTransatedValues(sortTitle[index]) ??
                  '',
              value: sortTitle[index],
              groupValue: state.selectedTitle,
              fontSize: AppFonts.fontSize14,
              onChanged: (value) => context.read<SortSelectionBloc>().add(
                    ChooseSortTitleEvent(pressedTitle: value ?? sortTitle[0]),
                  ),
            );
          },
        );
      },
    );
  }
}
