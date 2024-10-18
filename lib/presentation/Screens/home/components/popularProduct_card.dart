import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';
import 'package:halkmarket_ecommerce/data/endpoints.dart';

class PopularProductsCard extends StatelessWidget {
  final String topTitle;
  final String image;
  final double imageHeight;

  const PopularProductsCard({
    required this.topTitle,
    required this.image,
    required this.imageHeight,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: AppBorders.borderRadius12,
        color: AppColors.lightPurpleColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                topTitle,
                textAlign: TextAlign.left,
                maxLines: 1,
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
            child: ExtendedImage.network(
              '${Endpoints().url}/$image',
              height: imageHeight,
            ),
          ),
        ],
      ),
    );
  }
}
