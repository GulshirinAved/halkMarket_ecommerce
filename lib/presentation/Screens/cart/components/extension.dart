import 'package:flutter/cupertino.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';

extension ColumnExtensions on Column {
  Column withText(
    BuildContext context, {
    required String topTitle,
    Color? textColor,
    FontWeight? fontweight,
    double? fontSize,
  }) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            AppLocalization.of(context).getTransatedValues(topTitle) ?? '',
            style: TextStyle(
              fontFamily: fontExo2,
              fontWeight: fontweight ?? FontWeight.w700,
              fontSize: fontSize ?? AppFonts.fontSize16,
              color: textColor ?? AppColors.purpleColor,
            ),
          ),
        ),
        ...children,
      ],
    );
  }
}
