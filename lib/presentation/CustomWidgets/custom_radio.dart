import 'package:flutter/material.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';

class CustomRadio extends StatelessWidget {
  final String title;
  final String? subTitle;

  final dynamic value;
  final dynamic groupValue;
  final Function(dynamic)? onChanged;
  final double fontSize;
  final bool? radioLeft;

  const CustomRadio({
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.fontSize,
    this.subTitle,
    this.radioLeft = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      controlAffinity: radioLeft == true
          ? ListTileControlAffinity.leading
          : ListTileControlAffinity.trailing,
      visualDensity: VisualDensity.compact,
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: fontSize,
          color: AppColors.darkPurpleColor,
        ),
      ),
      subtitle: subTitle != null
          ? Text(
              subTitle ?? '',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: AppFonts.fontSize14,
                color: AppColors.grey1Color,
              ),
            )
          : null,
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
    );
  }
}
