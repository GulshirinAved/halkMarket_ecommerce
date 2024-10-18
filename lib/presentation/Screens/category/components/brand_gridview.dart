import 'package:flutter/material.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/category/components/brand_card.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/topTitle_tile.dart';

class BrandGridview extends StatelessWidget {
  final int index;
  final List brandList;
  const BrandGridview({
    required this.index,
    required this.brandList,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TopTitle(
          needArrow: false,
          topTitle: brandList[index].name,
          onTap: () {},
          topMargin: 20,
          bottomMargin: 5,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          width: MediaQuery.of(context).size.width,
          child: GridView.builder(
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            itemCount: brandList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) => GestureDetector(
              child: BrandCard(
                brandList: brandList,
                index: index,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
