import 'dart:developer';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/categoryProfile/selectSubCategory/select_sub_category_bloc.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';
import 'package:halkmarket_ecommerce/data/endpoints.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/category/categoryProfile_screen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class CategoryCard extends StatelessWidget {
  final int index;
  final String topTitle;
  final String subCategoryId;

  final List productList;
  const CategoryCard({
    required this.index,
    required this.topTitle,
    required this.subCategoryId,
    required this.productList,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<SelectSubCategoryBloc>().add(
              SelectSubCategoryEvent(pressedIndex: index),
            );

        pushScreenWithNavBar(
          context,
          CategoryProfileScreen(
            topTitle: productList[index].name,
            categoryId: '',
            subCategoryId: subCategoryId,
            brandId: '',
          ),
        );
        log(topTitle);
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10, right: 10),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: AppColors.grey2Color,
          borderRadius: AppBorders.borderRadius12,
        ),
        child: Column(
          children: [
            ExtendedImage.network(
              '${Endpoints().url}/${productList[index].image.url}',
              width: 74,
              height: 78,
              fit: BoxFit.cover,
            ),
            Flexible(
              child: Container(
                margin: const EdgeInsets.only(top: 2),
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: AppColors.grey5Color)),
                ),
                alignment: Alignment.bottomCenter,
                child: Text(
                  productList[index].name,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: AppFonts.fontSize10,
                    color: AppColors.darkPurpleColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
