// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:halkmarket_ecommerce/blocs/home/answerTip/answering_tip_bloc.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_appBar.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/category/categorySearch_screen.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/banner_slider.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/deliveryAddress_tile.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/follow_card.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/popularProductsCads_gridview.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/products_slider.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/smallCategory_card.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/toolTip_card.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AnsweringTipBloc(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.whiteColor,
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                pinned: true,
                snap: false,
                expandedHeight: 97.h,
                //add delivery address tile
                flexibleSpace: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                  child: const DeliveryAddressTile(),
                ),
                bottom: CustomAppBar.onlySearch(
                  onTap: () {
                    pushScreenWithNavBar(
                      context,
                      const CategorySearchScreen(
                        searchWithLeading: false,
                      ),
                    );
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    //banner slider
                    const BannerSlider(),
                    //small categories
                    SizedBox(
                      height: 100.h,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: smallCategories.length,
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(vertical: 10)
                            .copyWith(bottom: 0),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) =>
                            SmallCategoryCard(index: index),
                      ),
                    ),

                    ///  categories with top names
                    //fresh products
                    ProductsSlider(
                      topTitle: 'Свежие поступления',
                      productList: freshProducts,
                    ),
                    //sale products
                    ProductsSlider(
                      topTitle: 'Cкидки и акции',
                      productList: saleProducts,
                    ),
                    //popular products
                    const PopularProductsGridview(),
                    // new season
                    ProductsSlider(
                      topTitle: 'Новинки сезона',
                      productList: newProducts,
                    ),
                    //ready food products
                    ProductsSlider(
                      topTitle: 'Продукты питания',
                      productList: foodProducts,
                    ),
                    //toolTip Card
                    const ToolTipCard(),
                    //cleaning products
                    ProductsSlider(
                      topTitle: 'Уборка и гигиена',
                      productList: cleaningProducts,
                    ),
                    //cosmetics products
                    ProductsSlider(
                      topTitle: 'Косметика и уход',
                      productList: cosmeticsProducts,
                    ),
                    //follow card
                    const FollowCard(),
                    //milk products
                    ProductsSlider(
                      topTitle: 'Молочные продукты',
                      productList: milkProduct,
                    ),
                    //zoo products
                    ProductsSlider(
                      topTitle: 'Зоотовары',
                      productList: zooProducts,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
