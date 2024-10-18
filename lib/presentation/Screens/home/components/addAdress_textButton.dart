import 'package:flutter/material.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';

class AddAdressTextButton extends StatelessWidget {
  final VoidCallback onTap;
  const AddAdressTextButton({required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            Icons.add,
            color: AppColors.purpleColor,
          ),
          Text(
            AppLocalization.of(context).getTransatedValues('addAddress') ?? '',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: AppFonts.fontSize15,
              color: AppColors.darkPurpleColor,
            ),
          ),
        ],
      ),
    );
  }
}
