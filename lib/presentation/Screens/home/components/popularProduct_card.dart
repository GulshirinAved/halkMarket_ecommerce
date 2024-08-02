import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halkmarket_ecommerce/config/theme/theme.dart';

class PopularProductsCard extends StatelessWidget {
  final double height;
  final double width;
  final String topTitle;
  final String image;
  final double imageHeight;

  const PopularProductsCard({
    required this.height,
    required this.width,
    required this.topTitle,
    required this.image,
    required this.imageHeight,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.h,
      width: width.w,
      decoration: BoxDecoration(
        borderRadius: AppBorders.borderRadius12,
        color: AppColors.lightPurpleColor,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                topTitle,
                textAlign: TextAlign.left,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.darkPurpleColor,
                  fontWeight: FontWeight.w600,
                  fontSize: AppFonts.fontSize10,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Image.asset(
              image,
              height: imageHeight.h,
            ),
          ),
        ],
      ),
    );
  }
}
