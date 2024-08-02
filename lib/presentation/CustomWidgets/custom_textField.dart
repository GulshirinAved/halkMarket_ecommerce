// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';

import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/config/theme/theme.dart';

enum TextFieldStyle { search, normal }

class CustomTextField extends StatelessWidget {
  final String hintText;
  final int needPrefix;

  const CustomTextField({
    required this.hintText,
    required this.needPrefix,
    super.key,
  });
  const CustomTextField._({
    required this.hintText,
    required this.needPrefix,
  });
  factory CustomTextField.search({
    required final BuildContext context,
  }) {
    return CustomTextField._(
        hintText: AppLocalization.of(context).getTransatedValues('search')!,
        needPrefix: 1);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (event) => FocusScope.of(context).requestFocus(FocusNode()),
      cursorColor: AppColors.darkPurpleColor,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        border: OutlineInputBorder(
          borderRadius: AppBorders.borderRadius12,
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: AppColors.greyColor,
        //if 1 is search,if 2 is null
        prefixIcon: needPrefix == 1
            ? SvgPicture.asset(
                searchIcon,
                fit: BoxFit.scaleDown,
              )
            : null,
        hintText: hintText,

        hintStyle: TextStyle(
          fontSize: AppFonts.fontSize14,
          fontWeight: FontWeight.w400,
          color: AppColors.grey1Color,
        ),
      ),
    );
  }
}
