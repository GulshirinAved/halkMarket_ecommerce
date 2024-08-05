import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/data/models/cart_model.dart';
import 'package:halkmarket_ecommerce/data/models/fav_model.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/product_card.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/topTitle_tile.dart';

class ProductsSlider extends StatelessWidget {
  final String topTitle;
  const ProductsSlider({
    required this.topTitle,
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
            itemCount: newProducts.length,
            itemBuilder: (BuildContext context, int index) {
              return ProductCard(
                index: index,
                favItem: FavItem(
                  id: newProducts[index].id,
                  isNew: newProducts[index].isNew,
                  isSale: newProducts[index].isSale,
                  image: newProducts[index].image,
                  price: newProducts[index].price,
                  prevPrice: newProducts[index].prevPrice,
                  desc: newProducts[index].desc,
                  weight: newProducts[index].weight,
                ),
                cartItem: CartItem(
                  id: newProducts[index].id,
                  isNew: newProducts[index].isNew,
                  isSale: newProducts[index].isSale,
                  image: newProducts[index].image,
                  price: newProducts[index].price,
                  prevPrice: newProducts[index].prevPrice,
                  desc: newProducts[index].desc,
                  weight: newProducts[index].weight,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
