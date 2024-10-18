// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';

class CardData extends StatelessWidget {
  final String userName;
  final String expireDate;
  final String cardNumber;

  const CardData({
    required this.userName,
    required this.expireDate,
    required this.cardNumber,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.grey2Color,
        borderRadius: AppBorders.borderRadius12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                cardIcon,
                fit: BoxFit.scaleDown,
              ),
              const SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName.toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: AppFonts.fontSize16,
                      color: AppColors.darkPurpleColor,
                    ),
                  ),
                  Text(
                    expireDate,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: AppFonts.fontSize16,
                      color: AppColors.darkPurpleColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'RYSGAL',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: AppFonts.fontSize16,
                  color: AppColors.darkPurpleColor,
                ),
              ),
              Text(
                '**** $cardNumber',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: AppFonts.fontSize16,
                  color: AppColors.darkPurpleColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
