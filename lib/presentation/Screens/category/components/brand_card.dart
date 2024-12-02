// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import 'package:halkmarket_ecommerce/config/theme/constants.dart';
import 'package:halkmarket_ecommerce/data/endpoints.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/category/categoryProfile_screen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class BrandCard extends StatelessWidget {
  final List brandList;
  final int index;
  const BrandCard({
    required this.brandList,
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        log(brandList[index].categories[0].name);
        log(brandList[index].name);
        pushScreenWithNavBar(
          context,
          CategoryProfileScreen(
            topTitle: brandList[index].name,
            categoryId: '',
            brandId: brandList[index].id,
            subCategoryId: '',
          ),
        );
      },
      child: Container(
        width: 123,
        decoration: BoxDecoration(
          color: AppColors.grey2Color,
          borderRadius: AppBorders.borderRadius12,
        ),
        child: Column(
          children: [
            ExtendedImage.network(
              '${Endpoints().url}/${brandList[index].logo.url}',
              height: 80,
              width: 80,
            ),
            Divider(
              endIndent: size.width * 0.02,
              indent: size.width * 0.02,
            ),
            Text(
              brandList[index].name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: AppFonts.fontSize10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
