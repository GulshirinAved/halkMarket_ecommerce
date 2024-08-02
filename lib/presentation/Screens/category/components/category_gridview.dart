import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/category/components/category_card.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/topTitle_tile.dart';

class CategoryGridview extends StatelessWidget {
  final String topTitle;
  const CategoryGridview({
    super.key,
    required this.topTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TopTitle(topTitle: topTitle),
        SizedBox(
          height: 230.h,
          width: MediaQuery.of(context).size.width,
          child: GridView.builder(
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 5,
            ),
            itemCount: milkProducts.length <= 6 ? milkProducts.length : 6,
            shrinkWrap: true,
            itemBuilder: (context, index) => CategoryCard(
              index: index,
            ),
          ),
        ),
      ],
    );
  }
}
