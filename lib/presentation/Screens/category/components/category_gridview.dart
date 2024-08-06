import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/category/categoryProfile_screen.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/category/components/category_card.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/topTitle_tile.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class CategoryGridview extends StatelessWidget {
  final String topTitle;
  final List productList;
  const CategoryGridview({
    required this.topTitle,
    required this.productList,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TopTitle(
          topTitle: topTitle,
          onTap: () => pushScreenWithNavBar(
            context,
            CategoryProfileScreen(
              topTitle: topTitle,
            ),
          ),
          topMargin: 20,
          bottomMargin: 5,
        ),
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
            itemCount: productList.length <= 6 ? productList.length : 6,
            shrinkWrap: true,
            itemBuilder: (context, index) => CategoryCard(
              index: index,
              productList: productList,
            ),
          ),
        ),
      ],
    );
  }
}
