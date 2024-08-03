import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halkmarket_ecommerce/config/theme/theme.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final Color backColor;
  final Color textColor;
  final double fontSize;
  final String title;
  final FontWeight? fontweight;
  final VoidCallback? onTap;
  const CustomButton({
    required this.width,
    required this.backColor,
    required this.textColor,
    required this.fontSize,
    required this.title,
    this.fontweight,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: width.w,
      onPressed: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: AppBorders.borderRadius8,
      ),
      color: backColor,
      elevation: 0,
      child: Text(
        title,
        style: TextStyle(
          fontWeight: fontweight ?? FontWeight.w400,
          fontSize: fontSize,
          color: textColor,
        ),
      ),
    );
  }
}
