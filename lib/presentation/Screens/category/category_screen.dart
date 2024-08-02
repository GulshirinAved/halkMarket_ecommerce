import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/category/tabBar/tab_bar_cubit.dart';
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
                    children: const [
                      CategoryGridview(
                        topTitle: 'Молочные продукты',
                      ),
                      CategoryGridview(
                        topTitle: 'Свежие поступления',
                      ),
                      CategoryGridview(
                        topTitle: 'Кулинария',
                      ),
                      CategoryGridview(
                        topTitle: 'Молочные продукты, яйца, завтрак',
                      ),
                      CategoryGridview(
                        topTitle: 'Напитки',
                      ),
                      CategoryGridview(
                        topTitle: 'Продукты питания, кулинария',
                      ),
                      CategoryGridview(
                        topTitle: 'Продукты питания, кулинария',
                      ),
                    ],
                  ),
                  // brand tab
                  ListView(
                    children: const [
                      BrandGridview(
                        topTitle: 'Молочные продукты',
                      ),
                      BrandGridview(
                        topTitle: 'Мясная продукция',
                      ),
                      BrandGridview(
                        topTitle: 'Молочные продукты',
                      ),
                      BrandGridview(
                        topTitle: 'Продукты питания',
                      ),
                      BrandGridview(
                        topTitle: 'Напитки',
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
