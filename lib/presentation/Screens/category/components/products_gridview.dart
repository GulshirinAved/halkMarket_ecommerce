import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/product_card.dart';

class ProductsGridview extends StatelessWidget {
  const ProductsGridview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: newProducts.length,
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.all(10).copyWith(top: 0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 243.h,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) => ProductCard(index: index),
    );
  }
}
