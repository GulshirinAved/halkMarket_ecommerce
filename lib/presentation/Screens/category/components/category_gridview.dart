import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/categoryProfile/selectSubCategory/select_sub_category_bloc.dart';

import 'package:halkmarket_ecommerce/presentation/Screens/category/categoryProfile_screen.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/category/components/category_card.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/topTitle_tile.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class CategoryGridview extends StatelessWidget {
  final int index;
  final List productList;
  final List subCategoryList;
  final String categoryId;
  const CategoryGridview({
    required this.index,
    required this.productList,
    required this.subCategoryList,
    required this.categoryId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TopTitle(
          topTitle: productList[index].name,
          onTap: () {
            context
                .read<SelectSubCategoryBloc>()
                .add(const SelectSubCategoryEvent(pressedIndex: -1));

            pushScreenWithNavBar(
              context,
              CategoryProfileScreen(
                topTitle: productList[index].name,
                categoryId: productList[index].id,
                subCategoryId: '',
                brandId: '',
              ),
            );
          },
          topMargin: 20,
          bottomMargin: 5,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: GridView.builder(
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 5,
            ),
            itemCount: subCategoryList.length <= 6 ? subCategoryList.length : 6,
            shrinkWrap: true,
            itemBuilder: (context, index) => CategoryCard(
              index: index,
              productList: subCategoryList,
              topTitle: productList[index].name,
              subCategoryId: subCategoryList[index].id,
            ),
          ),
        ),
      ],
    );
  }
}
