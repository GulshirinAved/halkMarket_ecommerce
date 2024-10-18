import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/blocs/brands/getAllBrands/get_all_brands_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/category/getOneCataloge/get_one_cateloge_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/categoryProfile/selectSubCategory/select_sub_category_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/home/expansionPanelExpand/expansion_panel_expand_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/home/getAllProducts/get_all_products_bloc.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/animations.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_appBar.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/category/categorySearch_screen.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/category/components/categoryFull_content.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/category/components/filter_bottomSheet.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/category/components/subCategory_content.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class CategoryProfileScreen extends StatefulWidget {
  final String topTitle;
  final String categoryId;
  final String brandId;

  const CategoryProfileScreen({
    required this.topTitle,
    required this.categoryId,
    required this.brandId,
    super.key,
  });

  @override
  State<CategoryProfileScreen> createState() => _CategoryProfileScreenState();
}

class _CategoryProfileScreenState extends State<CategoryProfileScreen> {
  late TextEditingController _toPriceController;
  late TextEditingController _fromPriceController;
  late PageController _pageController;
  @override
  void initState() {
    super.initState();
    _toPriceController = TextEditingController();
    _fromPriceController = TextEditingController();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _toPriceController.dispose();
    _fromPriceController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SelectSubCategoryBloc(),
        ),
        BlocProvider(
          create: (context) =>
              GetOneCatelogeBloc()..add(GetOneCataloge(id: widget.categoryId)),
        ),
        BlocProvider(
          create: (context) => GetAllProductsBloc()
            ..add(
              GetProducts(
                ordering: 'popular',
                categories: widget.categoryId == '' ? [] : [widget.categoryId],
                brands: widget.brandId == '' ? [] : [widget.brandId],
              ),
            ),
        ),
        BlocProvider(
          create: (context) =>
              GetAllBrandsBloc()..add(const GetAllBrandsList()),
        ),
        BlocProvider(
          create: (context) => ExpansionPanelExpandBloc(),
        ),
      ],
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: CustomAppBar.categoryProfile(
              title: widget.topTitle,
              actions: [
                IconButton(
                  onPressed: () {
                    filterBottomSheet(
                      context,
                      fromPriceController: _fromPriceController,
                      toPriceController: _toPriceController,
                    );
                  },
                  icon: SvgPicture.asset(
                    filterIcon,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    pushScreenWithNavBar(context, const CategorySearchScreen());
                  },
                  icon: SvgPicture.asset(
                    searchIcon,
                    colorFilter: ColorFilter.mode(
                      AppColors.purpleColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ),
            body: BlocBuilder<GetOneCatelogeBloc, GetOneCatelogeState>(
              builder: (context, oneProductState) {
                return BlocBuilder<GetAllProductsBloc, GetAllProductsState>(
                  builder: (context, allProductState) {
                    if (allProductState is GetAllProductsError) {
                      Column(
                        children: [
                          Animations.error,
                          Text(
                            AppLocalization.of(context)
                                    .getTransatedValues('error') ??
                                '',
                          ),
                        ],
                      );
                    }
                    if (oneProductState is GetOneCatalogeError) {
                      return Column(
                        children: [
                          Animations.error,
                          Text(oneProductState.error ?? ''),
                          Text(
                            AppLocalization.of(context)
                                    .getTransatedValues('error') ??
                                '',
                          ),
                        ],
                      );
                    } else if (oneProductState is GetOneCatelogeInitial ||
                        oneProductState is GetOneCatalogeLoading ||
                        allProductState is GetAllProductsInitial ||
                        allProductState is GetAllProductsloading) {
                      return Center(
                        child: Animations.loading,
                      );
                    } else if (oneProductState is GetOneCatalogeLoaded &&
                        allProductState is GetAllProductsLoaded) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: kBottomNavigationBarHeight,
                        ),
                        child: PageView(
                          controller: _pageController,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            CategoryFullContent(
                              fromPriceController: _fromPriceController,
                              toPriceController: _toPriceController,
                              allProductState: allProductState,
                              oneProductState: oneProductState,
                              pageController: _pageController,
                            ),
                            SubCategoryContent(
                              pageController: _pageController,
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
