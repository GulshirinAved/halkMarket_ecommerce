import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halkmarket_ecommerce/data/models/cart_model.dart';
import 'package:halkmarket_ecommerce/data/models/fav_model.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/product_card.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/topTitle_tile.dart';

class ProductsSlider extends StatelessWidget {
  final String topTitle;
  final List productList;
  const ProductsSlider({
    required this.topTitle,
    required this.productList,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TopTitle(
          topTitle: topTitle,
          onTap: () {},
          bottomMargin: 12,
          topMargin: 20,
        ),
        SizedBox(
          height: 230.h,
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
                  isNew: productList[index].isNew,
                  isSale: productList[index].isSale,
                  image: productList[index].image,
                  price: productList[index].price,
                  prevPrice: productList[index].prevPrice,
                  desc: productList[index].desc,
                  weight: productList[index].weight,
                ),
                cartItem: CartItem(
                  id: productList[index].id,
                  isNew: productList[index].isNew,
                  isSale: productList[index].isSale,
                  image: productList[index].image,
                  price: productList[index].price,
                  prevPrice: productList[index].prevPrice,
                  desc: productList[index].desc,
                  weight: productList[index].weight,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
