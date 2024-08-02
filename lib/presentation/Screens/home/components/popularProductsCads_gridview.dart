import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/popularProduct_card.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/topTitle_tile.dart';

class PopularProductsGridview extends StatelessWidget {
  const PopularProductsGridview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TopTitle(
          topTitle: 'Популярные категории',
          onTap: () {},
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //1 card
                const PopularProductsCard(
                  height: 131,
                  width: 163,
                  topTitle: 'Молочная продукция',
                  image: milkProductsImage,
                  imageHeight: 100,
                ),
                const SizedBox(
                  width: 15,
                ),
                //2 and 3 cards
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const PopularProductsCard(
                      height: 59,
                      width: 163,
                      topTitle: 'Молочная продукция',
                      image: milkProductsImage,
                      imageHeight: 32,
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    const PopularProductsCard(
                      height: 59,
                      width: 163,
                      topTitle: 'Молочная продукция',
                      image: milkProductsImage,
                      imageHeight: 32,
                    ),
                  ],
                ),
              ],
            ),
            //other 4 cards
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                for (int i = 0; i < 4; i++)
                  const Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: PopularProductsCard(
                      height: 58,
                      width: 72,
                      topTitle: 'Напитки',
                      image: milkProductsImage,
                      imageHeight: 30,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
