// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/myOrdersProfile_screen.dart';

class OrderedCard extends StatelessWidget {
  final String orderNumber;
  final String orderedTime;
  final String untilFrom;
  final String untilTo;
  final String paymentType;
  final String status;
  final String sum;
  final String id;

  const OrderedCard({
    required this.orderNumber,
    required this.orderedTime,
    required this.untilFrom,
    required this.untilTo,
    required this.paymentType,
    required this.status,
    required this.sum,
    required this.id,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pushScreen(
          context,
          screen: MyOrdersProfileScreen(
            id: id,
            topTitle: orderNumber,
          ),
        );
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 20),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: AppBorders.borderRadius20,
          border: Border.all(
            color: AppColors.grey5Color,
          ),
        ),
        child: Column(
          children: [
            //pruple tile for order number
            purpleTile(
              context,
              orderNumber: orderNumber,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //orderDate
                      LayoutText(
                        topTitle:
                            '${AppLocalization.of(context).getTransatedValues('orderedData')}:',
                        subTitle: '${formatDateTime(orderedTime)}, $untilFrom',
                      ),
                      //payment method
                      LayoutText(
                        topTitle:
                            '${AppLocalization.of(context).getTransatedValues('payMethod')}:',
                        subTitle: paymentType,
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //status
                      LayoutText(
                        topTitle:
                            '${AppLocalization.of(context).getTransatedValues('status')}:',
                        subTitle: status,
                      ),
                      //deliverytime
                      LayoutText(
                        topTitle:
                            '${AppLocalization.of(context).getTransatedValues('deliveryTime')}:',
                        subTitle:
                            '${formatDateTime(orderedTime)},$untilFrom-$untilTo',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              color: AppColors.grey5Color,
            ),
            //sum
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: Row(
                children: [
                  Text(
                    '${AppLocalization.of(context).getTransatedValues('sum')}:',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: AppFonts.fontSize16,
                      color: AppColors.darkPurpleColor,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    '$sum TMT',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: AppFonts.fontSize16,
                      color: AppColors.purpleColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String formatDateTime(String dateTime) {
  final DateTime parsedDate = DateTime.parse(dateTime);
  final String formattedDate = DateFormat('dd.MM.yyyy').format(parsedDate);
  return formattedDate;
}

class LayoutText extends StatelessWidget {
  final String topTitle;
  final String subTitle;
  const LayoutText({
    required this.topTitle,
    required this.subTitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2.6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            topTitle,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: AppFonts.fontSize14,
              color: AppColors.darkPurpleColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              textAlign: TextAlign.start,
              subTitle,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: AppFonts.fontSize14,
                color: AppColors.grey1Color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Container purpleTile(BuildContext context, {final String? orderNumber}) {
  return Container(
    height: 33,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    decoration: BoxDecoration(
      color: AppColors.purpleColor,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${AppLocalization.of(context).getTransatedValues('orderNumber')}: ',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: AppFonts.fontSize14,
            color: AppColors.whiteColor,
          ),
        ),
        Expanded(
          child: Text(
            orderNumber ?? '',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: AppFonts.fontSize14,
              color: AppColors.whiteColor,
            ),
          ),
        ),
      ],
    ),
  );
}
