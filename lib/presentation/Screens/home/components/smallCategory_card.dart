import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';
import 'package:halkmarket_ecommerce/data/endpoints.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/category/categoryProfile_screen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class SmallCategoryCard extends StatelessWidget {
  final int index;
  final List categoryList;
  const SmallCategoryCard({
    required this.index,
    required this.categoryList,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pushScreenWithNavBar(
          context,
          CategoryProfileScreen(
            topTitle: categoryList[index].name,
            categoryId: categoryList[index].id,
            subCategoryId: '',
            brandId: '',
          ),
        );
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 56,
              width: 56,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: AppColors.lightPurpleColor,
                borderRadius: AppBorders.borderRadius12,
              ),
              child: ExtendedImage.network(
                '${Endpoints().url}/${categoryList[index].image.url}',
                height: 48,
                width: 48,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            SizedBox(
              width: 56,
              child: Text(
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                categoryList[index].name,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: AppFonts.fontSize10,
                  color: AppColors.darkPurpleColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
