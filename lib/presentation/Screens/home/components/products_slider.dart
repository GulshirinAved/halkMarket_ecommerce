import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/product_card.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/topTitle_tile.dart';

class ProductsSlider extends StatelessWidget {
  final String topTitle;
  const ProductsSlider({
    required this.topTitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          TopTitle(
            topTitle: topTitle,
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
                return ProductCard(index: index);
              },
            ),
          ),
        ],
      ),
    );
  }
}
