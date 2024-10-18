// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';

import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';

enum TextFieldStyle { search, normal }

class CustomTextField extends StatelessWidget {
  final String hintText;
  final Widget? needPrefix;
  final Color? backColor;
  final Color? borderColor;
  final Color? nonActiveBorderColor;
  final bool? isObscure;
  final Widget? suffixWidget;
  final VoidCallback? onTap;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final int? rangeNumber;
  final String? errorText;
  final TextAlign? textAlign;
  final FocusNode? focusNode;
  final TextFieldStyle? textFieldStyle;
  final int? maxLine;
  final bool? readOnly;
  final String? labelText;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextField({
    required this.hintText,
    required this.needPrefix,
    this.backColor,
    this.borderColor,
    this.nonActiveBorderColor,
    this.isObscure,
    this.suffixWidget,
    this.onTap,
    this.onFieldSubmitted,
    this.controller,
    this.keyboardType,
    this.rangeNumber,
    this.errorText,
    this.textAlign,
    this.onChanged,
    this.focusNode,
    this.textFieldStyle,
    this.maxLine,
    this.readOnly,
    this.labelText,
    this.inputFormatters,
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
    this.onFieldSubmitted,
    this.controller,
    this.keyboardType,
    this.rangeNumber,
    this.errorText,
    this.textAlign,
    this.onChanged,
    this.focusNode,
    this.textFieldStyle,
    this.maxLine,
    this.labelText,
    this.readOnly,
    this.inputFormatters,
  });

  factory CustomTextField.search({
    required BuildContext context,
    VoidCallback? onTap,
    Function(String)? onFieldSubmitted,
    TextEditingController? controller,
  }) {
    return CustomTextField._(
      hintText: AppLocalization.of(context).getTransatedValues('search')!,
      needPrefix: SvgPicture.asset(
        searchIcon,
        fit: BoxFit.scaleDown,
      ),
      onTap: onTap,
      borderColor: AppColors.darkPurpleColor,
      onFieldSubmitted: onFieldSubmitted,
      controller: controller,
      textFieldStyle: TextFieldStyle.search,
    );
  }

  factory CustomTextField.normal({
    String? hintText,
    Color? backColor,
    Color? borderColor,
    Color? nonActiveBorderColor,
    Widget? needPrefix,
    bool? isObscure,
    Widget? suffixWidget,
    Function(String)? onFieldSubmitted,
    Function(String)? onChanged,
    TextEditingController? textEditingController,
    TextInputType? keyboardType,
    int? rangeNumber,
    String? errorText,
    TextAlign? textAlign,
    FocusNode? focusNode,
    int? maxLine,
    bool? readOnly,
    String? labelText,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return CustomTextField._(
      hintText: hintText ?? '',
      needPrefix: needPrefix,
      backColor: backColor,
      borderColor: borderColor,
      nonActiveBorderColor: nonActiveBorderColor ?? Colors.transparent,
      isObscure: isObscure ?? false,
      suffixWidget: suffixWidget,
      onFieldSubmitted: onFieldSubmitted,
      controller: textEditingController,
      keyboardType: keyboardType,
      rangeNumber: rangeNumber,
      errorText: errorText,
      textAlign: textAlign ?? TextAlign.start,
      onChanged: onChanged,
      focusNode: focusNode,
      textFieldStyle: TextFieldStyle.normal,
      maxLine: maxLine ?? 1,
      readOnly: readOnly ?? false,
      labelText: labelText,
      inputFormatters: inputFormatters ?? [],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (labelText != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              labelText!,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: AppFonts.fontSize16,
                color: AppColors.grey1Color,
              ),
            ),
          ),
        TextFormField(
          readOnly: readOnly ?? false,
          textAlign: textAlign ?? TextAlign.start,
          keyboardType: keyboardType ?? TextInputType.text,
          maxLines: maxLine ?? 1,
          inputFormatters: inputFormatters ??
              [LengthLimitingTextInputFormatter(rangeNumber)],
          obscureText: isObscure ?? false,
          onTapOutside: (event) =>
              FocusScope.of(context).requestFocus(FocusNode()),
          onTap: onTap,
          onFieldSubmitted: onFieldSubmitted,
          onChanged: onChanged,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller,
          enabled: true,
          focusNode: focusNode,
          cursorColor: AppColors.darkPurpleColor,
          decoration: _buildInputDecoration(),
        ),
        if (errorText != null && errorText!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 10),
            child: Text(
              errorText!,
              style: getErrorTextStyle(),
            ),
          ),
      ],
    );
  }

  InputDecoration _buildInputDecoration() {
    return InputDecoration(
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
          color: nonActiveBorderColor ?? AppColors.greyColor,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: AppBorders.borderRadius12,
        borderSide: borderColor != null
            ? BorderSide(color: borderColor!)
            : BorderSide.none,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: AppBorders.borderRadius12,
        borderSide: BorderSide(color: AppColors.redColor),
      ),
      filled: true,
      fillColor: backColor ?? AppColors.greyColor,
      prefixIcon: needPrefix,
      suffixIcon: suffixWidget,
      errorText: null,
      hintText: hintText,
      hintStyle: TextStyle(
        fontSize: AppFonts.fontSize14,
        fontWeight: FontWeight.w400,
        color: AppColors.grey1Color,
      ),
    );
  }

  TextStyle getErrorTextStyle() {
    return TextStyle(
      color: AppColors.redColor,
      fontWeight: FontWeight.w300,
      fontSize: AppFonts.fontSize12,
    );
  }
}

class PrefixTextInputFormatter extends TextInputFormatter {
  final String prefix;
  final int maxLength;

  PrefixTextInputFormatter(this.prefix, {this.maxLength = 8});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (!newValue.text.startsWith(prefix)) {
      return oldValue;
    }

    final allowedLength = maxLength + prefix.length;

    if (newValue.text.length > allowedLength) {
      return oldValue;
    }

    return newValue;
  }
}

class BirthdayFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String newText = newValue.text;

    int selectionIndex = newValue.selection.end;

    newText = newText.replaceAll(RegExp(r'[^0-9-]'), '');

    if (newText.length >= 5 && newText[4] != '-') {
      newText = newText.replaceRange(4, 4, '-');
    }
    if (newText.length >= 8 && newText[7] != '-') {
      newText = newText.replaceRange(7, 7, '-');
    }

    if (newText.length > oldValue.text.length) {
      selectionIndex++;
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}

class SpaceInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(' ', '');
    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      if ((i + 1) % 4 == 0 && i + 1 != text.length) {
        buffer.write(' ');
      }
    }

    final string = buffer.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(offset: string.length),
    );
  }
}

class SlashInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(' / ', '');
    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      if ((i + 1) % 2 == 0 && i + 1 != text.length) {
        buffer.write(' / ');
      }
    }

    final string = buffer.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(offset: string.length),
    );
  }
}
