// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:halkmarket_ecommerce/config/theme/constants.dart';

class BrandCard extends StatelessWidget {
  final List brandList;
  final int index;
  const BrandCard({
    required this.brandList,
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 97.h,
      width: 123.w,
      decoration: BoxDecoration(
        color: AppColors.grey2Color,
        borderRadius: AppBorders.borderRadius12,
      ),
      child: Column(
        children: [
          Image.asset(brandList[index]['image']),
          Divider(
            endIndent: 5.w,
            indent: 5.w,
          ),
          Text(
            brandList[index]['name'],
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
    );
  }
}
