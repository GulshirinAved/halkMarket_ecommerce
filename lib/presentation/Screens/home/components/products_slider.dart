import 'package:flutter/material.dart';
import 'package:halkmarket_ecommerce/data/models/cart_model.dart';
import 'package:halkmarket_ecommerce/data/models/fav_model.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/product_card.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/category/categoryProfile_screen.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/topTitle_tile.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class ProductsSlider extends StatelessWidget {
  final String topTitle;
  final List productList;
  final int index;
  final String? categoryId;

  const ProductsSlider({
    required this.topTitle,
    required this.productList,
    required this.index,
    required this.categoryId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TopTitle(
          topTitle: topTitle,
          onTap: () {
            pushScreenWithNavBar(
              context,
              CategoryProfileScreen(
                topTitle: topTitle,
                subCategoryId: '',
                categoryId: categoryId!,
                brandId: '',
              ),
            );
          },
          bottomMargin: 12,
          topMargin: 20,
        ),
        SizedBox(
          height: 243,
          width: double.infinity,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: productList.length,
            itemBuilder: (BuildContext context, int index) {
              return ProductCard(
                index: index,
                favItem: FavItem(
                  id: productList[index].id,
                  name: productList[index].name,
                  image: productList[index].images,
                  price: productList[index].price,
                  desc: productList[index].description,
                  shopId: productList[index].shopId,
                  discount: productList[index].discount,
                  amount: productList[index].amount,
                  unit: productList[index].unit,
                ),
                cartItem: CartItem(
                  id: productList[index].id,
                  name: productList[index].name,
                  image: productList[index].images,
                  price: productList[index].price,
                  desc: productList[index].description,
                  shopId: productList[index].shopId,
                  discount: productList[index].discount,
                  amount: productList[index].amount,
                  unit: productList[index].unit,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
