import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/category/components/brand_card.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/topTitle_tile.dart';

class BrandGridview extends StatelessWidget {
  final String topTitle;
  final List brandList;
  const BrandGridview({
    required this.topTitle,
    required this.brandList,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 15.h),
          child: TopTitle(
            topTitle: topTitle,
            onTap: () {},
            topMargin: 20,
            bottomMargin: 5,
          ),
        ),
        SizedBox(
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
            itemBuilder: (context, index) => BrandCard(
              brandList: brandList,
              index: index,
            ),
          ),
        ),
      ],
    );
  }
}
