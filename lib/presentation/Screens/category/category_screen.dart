import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/blocs/brands/getAllBrands/get_all_brands_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/category/getAllCategory/all_category_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/category/tabBar/tab_bar_cubit.dart';
import 'package:halkmarket_ecommerce/blocs/categoryProfile/selectSubCategory/select_sub_category_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/home/getAllProducts/get_all_products_bloc.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/animations.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_appBar.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/category/categorySearch_screen.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/category/components/brand_gridview.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/category/components/category_gridview.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late TextEditingController searchController;
  late AllCategoryBloc allCategoryBloc;
  late GetAllBrandsBloc getAllBrandsBloc;
  late GetAllProductsBloc getAllProductsBloc;

  @override
  void initState() {
    super.initState();
    allCategoryBloc = AllCategoryBloc()..add(GetAllCategoryList());
    getAllBrandsBloc = GetAllBrandsBloc()..add(const GetAllBrandsList());
    getAllProductsBloc = GetAllProductsBloc()..add(const GetProducts());
    searchController = TextEditingController();
  }

  Future<void> _refresh() async {
    allCategoryBloc.add(GetAllCategoryList());
    getAllBrandsBloc.add(const GetAllBrandsList());
    getAllProductsBloc.add(const GetProducts());
  }

  @override
  void dispose() {
    searchController.dispose();
    allCategoryBloc.close();
    getAllBrandsBloc.close();
    getAllProductsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TabCubit(),
        ),
        BlocProvider.value(
          value: allCategoryBloc,
        ),
        BlocProvider.value(
          value: getAllBrandsBloc,
        ),
        BlocProvider.value(
          value: getAllProductsBloc,
        ),
        BlocProvider.value(
          value: context.read<SelectSubCategoryBloc>(),
        ),
      ],
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: CustomAppBar.searchAndTabbar(
            textEditingController: searchController,
            onTap: () {
              pushScreenWithNavBar(context, const CategorySearchScreen());
            },
          ),
          body: RefreshIndicator.adaptive(
            onRefresh: _refresh,
            color: AppColors.purpleColor,
            backgroundColor: AppColors.whiteColor,
            child: BlocBuilder<AllCategoryBloc, AllCategoryState>(
              builder: (context, state) {
                if (state is AllCategoryError) {
                  return ListView(
                    children: [
                      Center(
                        child: Column(
                          children: [
                            Animations.error,
                            Text(
                              AppLocalization.of(context)
                                      .getTransatedValues('error') ??
                                  '',
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else if (state is AllCategoryInitial ||
                    state is AllCategoryLoading) {
                  return ListView(
                    children: [
                      Center(child: Animations.loading),
                    ],
                  );
                } else if (state is AllCategoryLoaded) {
                  return BlocBuilder<TabCubit, int>(
                    builder: (context, tabState) {
                      return IndexedStack(
                        index: tabState,
                        children: [
                          //! categry content
                          ListView.builder(
                            controller:
                                BlocProvider.of<AllCategoryBloc>(context)
                                    .scrollController,
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: state.allCategoryList.length + 1,
                            itemBuilder: (context, index) {
                              if (index >= state.allCategoryList.length) {
                                if (!BlocProvider.of<AllCategoryBloc>(context)
                                    .isLoadingMore) {
                                  BlocProvider.of<AllCategoryBloc>(context)
                                      .add(LoadMoreEvent());
                                }
                                return state.allCategoryList.length != index
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : const SizedBox.shrink();
                              }

                              if (state.allCategoryList[index].subcategories!
                                  .isEmpty) {
                                return const SizedBox.shrink();
                              }

                              return CategoryGridview(
                                index: index,
                                productList: state.allCategoryList,
                                categoryId:
                                    state.allCategoryList[index].id.toString(),
                                subCategoryList:
                                    state.allCategoryList[index].subcategories!,
                              );
                            },
                          ),
                          //! Brand content
                          BlocBuilder<GetAllBrandsBloc, GetAllBrandsState>(
                            builder: (context, brandState) {
                              if (brandState is GetAllBrandsError) {
                                return ListView(
                                  children: [
                                    Column(
                                      children: [
                                        Animations.error,
                                        Text(brandState.error ?? ''),
                                        Text(
                                          AppLocalization.of(context)
                                                  .getTransatedValues(
                                                'error',
                                              ) ??
                                              '',
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              } else if (brandState is GetAllBrandsInitial ||
                                  brandState is GetAllBrandsLoading) {
                                return ListView(
                                  children: [
                                    Center(child: Animations.loading),
                                  ],
                                );
                              } else if (brandState is GetAllBrandsLoaded) {
                                return ListView.builder(
                                  controller:
                                      BlocProvider.of<GetAllBrandsBloc>(context)
                                          .scrollController,
                                  shrinkWrap: true,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemCount:
                                      brandState.allBrandsList.length + 1,
                                  itemBuilder: (context, index) {
                                    if (index >=
                                        brandState.allBrandsList.length) {
                                      if (!BlocProvider.of<GetAllBrandsBloc>(
                                        context,
                                      ).isLoadingMore) {
                                        BlocProvider.of<GetAllBrandsBloc>(
                                          context,
                                        ).add(GetMoreBrand());
                                      }
                                      return brandState.allBrandsList.length !=
                                              index
                                          ? const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : const SizedBox.shrink();
                                    }

                                    return BrandGridview(
                                      index: index,
                                      brandList: brandState.allBrandsList,
                                    );
                                  },
                                );
                              } else {
                                return ListView(
                                  children: [
                                    Center(child: Animations.loading),
                                  ],
                                );
                              }
                            },
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  return ListView(
                    children: [
                      Center(child: Animations.loading),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
