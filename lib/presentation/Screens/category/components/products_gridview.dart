import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halkmarket_ecommerce/data/models/cart_model.dart';
import 'package:halkmarket_ecommerce/data/models/fav_model.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/product_card.dart';

class ProductsGridview extends StatelessWidget {
  final List productList;
  const ProductsGridview({
    required this.productList,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: productList.length,
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.all(10).copyWith(top: 0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 243.h,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) => ProductCard(
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
      ),
    );
  }
}
