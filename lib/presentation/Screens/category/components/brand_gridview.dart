import 'package:flutter/material.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/category/components/brand_card.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/topTitle_tile.dart';

class BrandGridview extends StatelessWidget {
  final int index;
  final List brandList;
  final List categoryList;
  const BrandGridview({
    required this.index,
    required this.brandList,
    required this.categoryList,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final List filteredBrands = brandList.where((brand) {
      return brand.categories
          .any((category) => category.name == categoryList[index].name);
    }).toList();
    return Column(
      children: [
        TopTitle(
          needArrow: false,
          topTitle: categoryList[index].name,
          onTap: () {},
          topMargin: screenSize.height * 0.025,
          bottomMargin: screenSize.height * 0.006,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: screenSize.width * 0.04),
          padding: EdgeInsets.symmetric(
            vertical: screenSize.height * 0.006,
            horizontal: screenSize.width * 0.03,
          ),
          width: screenSize.width,
          child: GridView.builder(
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: screenSize.width * 0.02,
              mainAxisSpacing: screenSize.width * 0.02,
              childAspectRatio: 0.85,
            ),
            itemCount: filteredBrands.length,
            shrinkWrap: true,
            itemBuilder: (context, index) => BrandCard(
              brandList: filteredBrands,
              index: index,
            ),
          ),
        ),
      ],
    );
  }
}
