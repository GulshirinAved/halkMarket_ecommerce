import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/category/components/brand_card.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/topTitle_tile.dart';

class BrandGridview extends StatelessWidget {
  final String topTitle;
  const BrandGridview({
    required this.topTitle,
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
            itemCount: 8,
            shrinkWrap: true,
            itemBuilder: (context, index) => const BrandCard(),
          ),
        ),
      ],
    );
  }
}
