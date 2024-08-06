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
          bottomMargin: 12,
          topMargin: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //1 card
                  Expanded(
                    child: PopularProductsCard(
                      topTitle: popularProducts[0]['name'],
                      image: popularProducts[0]['image'],
                      imageHeight: 100,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  //2 and 3 cards
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PopularProductsCard(
                          topTitle: popularProducts[1]['name'],
                          image: popularProducts[1]['image'],
                          imageHeight: 32,
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        PopularProductsCard(
                          topTitle: popularProducts[2]['name'],
                          image: popularProducts[2]['image'],
                          imageHeight: 32,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              //other 4 cards
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (int i = 3; i < popularProducts.length; i++)
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 15, left: 2, right: 2),
                        child: PopularProductsCard(
                          topTitle: popularProducts[i]['name'],
                          image: popularProducts[i]['image'],
                          imageHeight: 30,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
