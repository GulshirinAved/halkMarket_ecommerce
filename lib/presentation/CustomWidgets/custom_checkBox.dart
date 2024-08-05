// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:halkmarket_ecommerce/config/theme/constants.dart';

class CustomCheckBox extends StatelessWidget {
  final bool? isChecked;
  final String? title;
  final Function(bool?)? onChanged;
  const CustomCheckBox({Key? key, this.isChecked, this.title, this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      checkColor: AppColors.whiteColor,
      fillColor: isChecked == true
          ? WidgetStatePropertyAll(AppColors.purpleColor)
          : WidgetStatePropertyAll(AppColors.whiteColor),
      overlayColor: isChecked == true
          ? WidgetStatePropertyAll(AppColors.purpleColor)
          : WidgetStatePropertyAll(AppColors.whiteColor),
      side: isChecked == true
          ? BorderSide.none
          : BorderSide(color: AppColors.grey5Color),
      value: isChecked,
      title: Text(title!),
      onChanged: onChanged,
    );
  }
}
