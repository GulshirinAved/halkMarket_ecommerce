import 'package:flutter/material.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/popularProduct_card.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/topTitle_tile.dart';

class PopularProductsGridview extends StatelessWidget {
  final List popularList;
  const PopularProductsGridview({
    required this.popularList,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TopTitle(
          topTitle: AppLocalization.of(context)
                  .getTransatedValues('popularCategory') ??
              '',
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
                      topTitle: popularList[0].name,
                      image: popularList[0].image.url,
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
                          topTitle: popularList[1].name,
                          image: popularList[1].image.url,
                          imageHeight: 32,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        PopularProductsCard(
                          topTitle: popularList[2].name,
                          image: popularList[2].image.url,
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
                  for (int i = 3;
                      i < (popularList.length >= 7 ? 7 : popularList.length);
                      i++)
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 15, left: 2, right: 2),
                        child: PopularProductsCard(
                          topTitle: popularList[i].name,
                          image: popularList[i].image.url,
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
