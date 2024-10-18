import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/blocs/cart/cartButton/cart_button_bloc.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';

import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_button.dart';

Future<dynamic> customDialog(
  BuildContext context, {
  required String subTitle,
  required VoidCallback rightOnTap,
}) {
  return showDialog(
    context: context,
    builder: (contextt) => BlocProvider.value(
      value: context.read<CartButtonBloc>(),
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: AppBorders.borderRadius20),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          width: 390,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalization.of(context).getTransatedValues('delete') ?? '',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: AppFonts.fontSize18,
                  color: AppColors.darkPurpleColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 20),
                child: Text(
                  subTitle,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: AppFonts.fontSize16,
                    color: AppColors.darkPurpleColor,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomButton.text(
                      borderRadius: AppBorders.borderRadius12,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      width: double.infinity,
                      backColor: AppColors.redColor,
                      textColor: AppColors.whiteColor,
                      fontSize: AppFonts.fontSize16,
                      title: AppLocalization.of(context)
                              .getTransatedValues('no') ??
                          '',
                      onTap: () {
                        Navigator.pop(contextt);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: CustomButton.text(
                      borderRadius: AppBorders.borderRadius12,
                      width: double.infinity,
                      backColor: AppColors.green1Color,
                      textColor: AppColors.whiteColor,
                      fontSize: AppFonts.fontSize16,
                      title: AppLocalization.of(context)
                              .getTransatedValues('yes') ??
                          '',
                      onTap: () {
                        rightOnTap();
                        Navigator.pop(contextt);
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}
