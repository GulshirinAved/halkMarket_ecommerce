import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/category/tabBar/tab_bar_cubit.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_appBar.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/category/components/brand_gridview.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/category/components/category_gridview.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TabCubit(),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          //appbar
          appBar: CustomAppBar.searchAndTabbar(),
          // tabbarview
          body: BlocBuilder<TabCubit, int>(
            builder: (context, state) {
              return IndexedStack(
                index: state,
                children: [
                  //category tab
                  ListView(
                    children: [
                      CategoryGridview(
                        topTitle: 'Молочные продукты',
                        productList: milkCategoryProducts,
                      ),
                      CategoryGridview(
                        topTitle: 'Продукты питания',
                        productList: foodCategoryProducts,
                      ),
                      CategoryGridview(
                        topTitle: 'Кулинария',
                        productList: cookingCategoryProducts,
                      ),
                      CategoryGridview(
                        topTitle: 'Молочные продукты, яйца, завтрак',
                        productList: breakfastCategoryProducts,
                      ),
                      CategoryGridview(
                        topTitle: 'Напитки',
                        productList: breakfastCategoryProducts,
                      ),
                      CategoryGridview(
                        topTitle: 'Продукты питания, кулинария',
                        productList: breakfastCategoryProducts,
                      ),
                      CategoryGridview(
                        topTitle: 'Продукты питания, кулинария',
                        productList: breakfastCategoryProducts,
                      ),
                    ],
                  ),
                  // brand tab
                  ListView(
                    children: [
                      BrandGridview(
                        topTitle: 'Молочные продукты',
                        brandList: milkBrands,
                      ),
                      BrandGridview(
                        topTitle: 'Мясная продукция',
                        brandList: meatBrands,
                      ),
                      BrandGridview(
                        topTitle: 'Молочные продукты',
                        brandList: milk2Brands,
                      ),
                      BrandGridview(
                        topTitle: 'Продукты питания',
                        brandList: milkBrands,
                      ),
                      BrandGridview(
                        topTitle: 'Напитки',
                        brandList: meatBrands,
                      ),
                    ],
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
