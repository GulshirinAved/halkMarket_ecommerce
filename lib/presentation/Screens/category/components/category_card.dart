import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';

class CategoryCard extends StatelessWidget {
  final int index;
  final List productList;
  const CategoryCard({
    required this.index,
    required this.productList,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 97.h,
          width: 123.w,
          margin: const EdgeInsets.only(top: 10, right: 10),
          decoration: BoxDecoration(
            color: AppColors.grey2Color,
            borderRadius: AppBorders.borderRadius12,
          ),
        ),
        Positioned(
          top: 0,
          child: Image.asset(productList[index]['image']),
        ),
        Positioned(
          bottom: 18,
          child: Container(
            height: 97.h,
            width: 123.w,
            alignment: Alignment.bottomCenter,
            child: Text(
              maxLines: 3,
              productList[index]['name'],
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
    );
  }
}
