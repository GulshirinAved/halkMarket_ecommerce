// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';

import 'package:halkmarket_ecommerce/blocs/home/answerTip/answering_tip_bloc.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/config/theme/theme.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_textField.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/banner_slider.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/deliveryAddress_tile.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/follow_card.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/popularProductsCads_gridview.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/products_slider.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/smallCategory_card.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/toolTip_card.dart';

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
                bottom: AppBar(
                  //search field
                  title: CustomTextField(
                    hintText: AppLocalization.of(context)
                            .getTransatedValues('search') ??
                        '',
                    needPrefix: 1,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    //banner slider
                    const BannerSlider(),
                    //small categories
                    SizedBox(
                      height: 103.h,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: smallCategories.length,
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) =>
                            SmallCategoryCard(index: index),
                      ),
                    ),

                    ///  categories with top names
                    //new products
                    const ProductsSlider(
                      topTitle: 'Свежие поступления',
                    ),
                    //sale products
                    const ProductsSlider(
                      topTitle: 'Cкидки и акции',
                    ),
                    //popular products
                    const PopularProductsGridview(),
                    // new season
                    const ProductsSlider(
                      topTitle: 'Новинки сезона',
                    ),
                    //ready food products
                    const ProductsSlider(
                      topTitle: 'Продукты питания',
                    ),
                    //toolTip Card
                    const ToolTipCard(),
                    //cleaning products
                    const ProductsSlider(
                      topTitle: 'Уборка и гигиена',
                    ),
                    //cosmetics products
                    const ProductsSlider(
                      topTitle: 'Косметика и уход',
                    ),
                    //follow card
                    const FollowCard(),
                    //milk products
                    const ProductsSlider(
                      topTitle: 'Молочные продукты',
                    ),
                    //zoo products
                    const ProductsSlider(
                      topTitle: 'Зоотовары',
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
