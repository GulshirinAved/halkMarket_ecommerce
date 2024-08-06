// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';

import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';

enum TextFieldStyle { search, normal }

class CustomTextField extends StatelessWidget {
  final String hintText;
  final int needPrefix;
  final Color? backColor;
  final Color? borderColor;
  final Color? nonActiveBorderColor;
  final bool? isObscure;
  final Widget? suffixWidget;
  final VoidCallback? onTap;

  const CustomTextField({
    required this.hintText,
    required this.needPrefix,
    this.backColor,
    this.borderColor,
    this.nonActiveBorderColor,
    this.isObscure,
    this.suffixWidget,
    this.onTap,
    super.key,
  });
  const CustomTextField._({
    required this.hintText,
    required this.needPrefix,
    this.backColor,
    this.borderColor,
    this.nonActiveBorderColor,
    this.isObscure,
    this.suffixWidget,
    this.onTap,
  });
  factory CustomTextField.search(
      {required final BuildContext context, VoidCallback? onTap}) {
    return CustomTextField._(
      hintText: AppLocalization.of(context).getTransatedValues('search')!,
      needPrefix: 1,
      onTap: onTap,
      borderColor: AppColors.darkPurpleColor,
    );
  }
  factory CustomTextField.normal({
    required String hinText,
    Color? backColor,
    Color? borderColor,
    Color? nonActiveBorderColor,
    int? needPrefix,
    bool? isObscure,
    Widget? suffixWidget,
  }) {
    return CustomTextField._(
      hintText: hinText,
      needPrefix: needPrefix ?? 2,
      backColor: backColor,
      borderColor: borderColor,
      nonActiveBorderColor: nonActiveBorderColor ?? Colors.transparent,
      isObscure: isObscure ?? false,
      suffixWidget: suffixWidget,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObscure ?? false,
      onTapOutside: (event) => FocusScope.of(context).requestFocus(FocusNode()),
      onTap: onTap,
      enabled: true,
      cursorColor: AppColors.darkPurpleColor,
      // I do it for +993 prefix
      decoration: needPrefix == 3
          ? const InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            )
          : InputDecoration(
              contentPadding: const EdgeInsets.all(10),
              border: OutlineInputBorder(
                borderRadius: AppBorders.borderRadius12,
                borderSide: nonActiveBorderColor != null
                    ? BorderSide(color: nonActiveBorderColor!)
                    : BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: AppBorders.borderRadius12,
                borderSide: BorderSide(
                    color: nonActiveBorderColor ?? AppColors.greyColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: AppBorders.borderRadius12,
                borderSide: borderColor != null
                    ? BorderSide(color: borderColor!)
                    : BorderSide.none,
              ),
              filled: true,
              fillColor: backColor ?? AppColors.greyColor,
              //if 1 is search,if 2 null
              prefixIcon: needPrefix == 1
                  ? SvgPicture.asset(
                      searchIcon,
                      fit: BoxFit.scaleDown,
                    )
                  : null,

              suffixIcon: suffixWidget,
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
