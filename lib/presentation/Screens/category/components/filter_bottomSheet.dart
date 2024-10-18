// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/blocs/brands/getAllBrands/get_all_brands_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/category/getOneCataloge/get_one_cateloge_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/categoryProfile/filter/brandExpand/brand_expand_cubit.dart';
import 'package:halkmarket_ecommerce/blocs/categoryProfile/filter/brandSelection/brand_selection_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/categoryProfile/filter/categoryExpand/category_expand_cubit.dart';
import 'package:halkmarket_ecommerce/blocs/categoryProfile/filter/categorySelection/category_selection_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/categoryProfile/filter/sortSelection/sort_selection_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/categoryProfile/selectSubCategory/select_sub_category_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/home/getAllProducts/get_all_products_bloc.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/animations.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_button.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_checkBox.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_radio.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_textField.dart';

Future<dynamic> filterBottomSheet(
  BuildContext context, {
  required TextEditingController fromPriceController,
  required TextEditingController toPriceController,
}) {
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
        BlocProvider.value(value: context.read<CategorySelectionBloc>()),
        BlocProvider.value(value: context.read<BrandSelectionBloc>()),
        BlocProvider.value(value: context.read<GetAllProductsBloc>()),
        BlocProvider.value(value: context.read<GetAllBrandsBloc>()),
        BlocProvider.value(value: context.read<GetOneCatelogeBloc>()),
        BlocProvider.value(
          value: context.read<SelectSubCategoryBloc>(),
        ),
        BlocProvider(create: (context) => ToggleCubit()),
        BlocProvider(create: (context) => BrandExpandCubit()),
      ],
      child: Stack(
        children: [
          Padding(
            padding:
                EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
            child: ListView(
              shrinkWrap: true,
              children: [
                //header arrowback,title and clean
                _buildHeader(context, contextt),
                //sort radio
                const SortTile(),
                //price textfield and  radio
                PriceTile(
                  contextt: contextt,
                  toPriceController: toPriceController,
                  fromPriceController: fromPriceController,
                ),
                //category checkbox
                const CategoryTile(),
                //brandCheckBox
                const BrandTile(),
              ],
            ),
          ),
          //apply button
          BlocBuilder<BrandSelectionBloc, BrandSelectionState>(
            builder: (context, brandState) {
              return BlocBuilder<CategorySelectionBloc, CategorySelectionState>(
                builder: (context, categoryState) {
                  return BlocBuilder<SortSelectionBloc, SortSelectionState>(
                    builder: (context, sortSelection) {
                      return Positioned(
                        bottom: kBottomNavigationBarHeight,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          child: CustomButton.text(
                            borderRadius: AppBorders.borderRadius12,
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            width: MediaQuery.of(context).size.width * 0.8,
                            backColor: AppColors.purpleColor,
                            textColor: AppColors.whiteColor,
                            fontSize: AppFonts.fontSize16,
                            title: AppLocalization.of(context)
                                    .getTransatedValues('apply') ??
                                '',
                            onTap: () {
                              context
                                  .read<SortSelectionBloc>()
                                  .add(const ApplySortEvent());

                              context
                                  .read<CategorySelectionBloc>()
                                  .add(const ApplyCategoryEvent());
                              context
                                  .read<BrandSelectionBloc>()
                                  .add(const ApplyBrandEvent());
                              context.read<SelectSubCategoryBloc>().add(
                                    const SelectSubCategoryEvent(
                                      pressedIndex: -1,
                                    ),
                                  );
                              context.read<GetAllProductsBloc>().add(
                                    GetProducts(
                                      ordering: sortSelection.selectedTitle,
                                      priceTo: int.parse(
                                        toPriceController.text == ''
                                            ? '0'
                                            : toPriceController.text,
                                      ),
                                      priceFrom: int.parse(
                                        fromPriceController.text == ''
                                            ? '0'
                                            : fromPriceController.text,
                                      ),
                                      categories: categoryState.categoryIdList
                                          .map(
                                            (e) => e['id'],
                                          )
                                          .toList(),
                                      brands: brandState.brandIdList
                                          .map(
                                            (e) => e['id'],
                                          )
                                          .toList(),
                                    ),
                                  );

                              Navigator.pop(context);
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
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
    return BlocBuilder<GetAllBrandsBloc, GetAllBrandsState>(
      builder: (context, allBrandState) {
        if (allBrandState is GetAllBrandsLoaded) {
          return _buildTile(
            context: context,
            titleKey: 'brands',
            itemCount: allBrandState.allBrandsList.length,
            items: allBrandState.allBrandsList,
            itemBuilder: (context, index) {
              return BlocBuilder<BrandSelectionBloc, BrandSelectionState>(
                builder: (context, state) {
                  return CustomCheckBox(
                    isChecked: state.brandList.any(
                      (brand) =>
                          brand['name'] ==
                          allBrandState.allBrandsList[index].name,
                    ),
                    title: allBrandState.allBrandsList[index].name,
                    onChanged: (value) =>
                        context.read<BrandSelectionBloc>().add(
                              ChooseBrandEvent(
                                pressedBrandName:
                                    allBrandState.allBrandsList[index].name,
                                pressedBrandId:
                                    allBrandState.allBrandsList[index].id,
                              ),
                            ),
                  );
                },
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class CategoryTile extends StatelessWidget {
  const CategoryTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetOneCatelogeBloc, GetOneCatelogeState>(
      builder: (context, state) {
        if (state is GetOneCatalogeError) {
          return Column(
            children: [
              Animations.error,
              Text(state.error ?? ''),
              Text(
                AppLocalization.of(context).getTransatedValues('error') ?? '',
              ),
            ],
          );
        } else if (state is GetOneCatelogeInitial ||
            state is GetOneCatalogeLoading) {
          return Center(
            child: Animations.loading,
          );
        } else if (state is GetOneCatalogeLoaded) {
          return _buildTile(
            context: context,
            titleKey: 'categories',
            itemCount: state.getOneCatalogeList.subcategories!.length,
            items: state.getOneCatalogeList.subcategories!,
            itemBuilder: (context, index) {
              return BlocBuilder<CategorySelectionBloc, CategorySelectionState>(
                builder: (context, selectState) {
                  return CustomCheckBox(
                    isChecked: selectState.categoryList.any(
                      (category) =>
                          category['name'] ==
                          state.getOneCatalogeList.subcategories![index].name,
                    ),
                    title: state.getOneCatalogeList.subcategories![index].name,
                    onChanged: (value) =>
                        context.read<CategorySelectionBloc>().add(
                              ChooseCategoryEvent(
                                pressedCategoryName: state.getOneCatalogeList
                                        .subcategories![index].name ??
                                    '',
                                pressedCategoryId: state.getOneCatalogeList
                                        .subcategories![index].id ??
                                    '',
                              ),
                            ),
                  );
                },
              );
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

Widget _buildTile({
  required BuildContext context,
  required String titleKey,
  required int itemCount,
  required List<dynamic> items,
  required IndexedWidgetBuilder itemBuilder,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
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
          final int displayItemCount =
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
  final TextEditingController toPriceController;
  final TextEditingController fromPriceController;

  const PriceTile({
    required this.contextt,
    required this.toPriceController,
    required this.fromPriceController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
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
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: CustomTextField.normal(
                          hintText: AppLocalization.of(context)
                                  .getTransatedValues('from') ??
                              '',
                          borderColor: AppColors.grey1Color,
                          backColor: AppColors.whiteColor,
                          nonActiveBorderColor: AppColors.grey1Color,
                          textEditingController: fromPriceController,
                          keyboardType: TextInputType.number,
                          rangeNumber: 6,
                          onFieldSubmitted: (value) {
                            fromPriceController.text = value;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: CustomTextField.normal(
                          hintText: AppLocalization.of(context)
                                  .getTransatedValues('to') ??
                              '',
                          borderColor: AppColors.grey1Color,
                          backColor: AppColors.whiteColor,
                          nonActiveBorderColor: AppColors.grey1Color,
                          textEditingController: toPriceController,
                          keyboardType: TextInputType.number,
                          rangeNumber: 6,
                          onFieldSubmitted: (value) {
                            toPriceController.text = value;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: CustomRadio(
                title: AppLocalization.of(context)
                        .getTransatedValues(sortTitle[index]) ??
                    '',
                value: sortTitle[index],
                groupValue: state.selectedTitle,
                fontSize: AppFonts.fontSize14,
                onChanged: (value) => context.read<SortSelectionBloc>().add(
                      ChooseSortTitleEvent(pressedTitle: value ?? sortTitle[0]),
                    ),
              ),
            );
          },
        );
      },
    );
  }
}
