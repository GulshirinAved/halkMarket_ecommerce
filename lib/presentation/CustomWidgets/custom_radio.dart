import 'package:flutter/material.dart';
import 'package:halkmarket_ecommerce/config/theme/theme.dart';

class CustomRadio extends StatelessWidget {
  final String title;
  final String value;
  final String groupValue;
  final Function(String?)? onChanged;
  final double fontSize;
  final bool? radioLeft;

  const CustomRadio({
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.fontSize,
    this.radioLeft = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      dense: true,
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
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
    );
  }
}
