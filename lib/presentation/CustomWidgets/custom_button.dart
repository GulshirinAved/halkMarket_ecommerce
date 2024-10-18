import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';

enum ButtonStyle { withIconText, text }

class CustomButton extends StatelessWidget {
  final double width;
  final Color backColor;
  final Color textColor;
  final double fontSize;
  final String title;
  final FontWeight? fontweight;
  final VoidCallback? onTap;
  final ButtonStyle? bottonStyle;
  final String? icon;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;

  const CustomButton({
    required this.width,
    required this.backColor,
    required this.textColor,
    required this.fontSize,
    required this.title,
    required this.borderRadius,
    this.padding,
    this.fontweight,
    this.onTap,
    this.bottonStyle,
    this.icon,
    super.key,
  });
  const CustomButton._({
    required this.width,
    required this.backColor,
    required this.textColor,
    required this.fontSize,
    required this.title,
    required this.onTap,
    this.padding,
    this.fontweight,
    this.icon,
    this.bottonStyle,
    this.borderRadius,
  });
  factory CustomButton.text({
    required final double width,
    required final Color backColor,
    required final Color textColor,
    required final double fontSize,
    required final String title,
    required final VoidCallback? onTap,
    required final BorderRadiusGeometry? borderRadius,
    final FontWeight? fontweight,
    final EdgeInsetsGeometry? padding,
  }) {
    return CustomButton._(
      width: width,
      backColor: backColor,
      textColor: textColor,
      fontSize: fontSize,
      title: title,
      onTap: onTap,
      padding: padding,
      bottonStyle: ButtonStyle.text,
      borderRadius: borderRadius,
    );
  }
  factory CustomButton.withIconText({
    required final double width,
    required final Color backColor,
    required final Color textColor,
    required final double fontSize,
    required final String title,
    required final FontWeight? fontweight,
    required final VoidCallback? onTap,
    required final String icon,
    required final BorderRadiusGeometry? borderRadius,
    final EdgeInsetsGeometry? padding,
  }) {
    return CustomButton._(
      width: width,
      backColor: backColor,
      textColor: textColor,
      fontSize: fontSize,
      title: title,
      onTap: onTap,
      bottonStyle: ButtonStyle.withIconText,
      icon: icon,
      padding: padding,
      borderRadius: borderRadius,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: width,
      onPressed: onTap,
      padding: padding,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? AppBorders.borderRadius8,
      ),
      color: backColor,
      elevation: 0,
      child: bottonStyle == ButtonStyle.text
          ? Text(
              title,
              style: TextStyle(
                fontWeight: fontweight ?? FontWeight.w400,
                fontSize: fontSize,
                color: textColor,
              ),
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 5),
                  child: SvgPicture.asset(icon!),
                ),
                Flexible(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: fontweight ?? FontWeight.w400,
                      fontSize: fontSize,
                      color: textColor,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
