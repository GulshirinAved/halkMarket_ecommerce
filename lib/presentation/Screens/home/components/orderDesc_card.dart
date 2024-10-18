// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';
import 'package:halkmarket_ecommerce/data/models/getOneOrderHis_model.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/ordered_card.dart';

class OrderDescCard extends StatelessWidget {
  final Datum orderData;
  const OrderDescCard({
    required this.orderData,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: AppBorders.borderRadius8,
        border: Border.all(color: AppColors.grey5Color),
      ),
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          OrderDataTile(
            leftTitle:
                '${AppLocalization.of(context).getTransatedValues('orderNumber')}:',
            rightTitle: orderData.id.toString(),
          ),
          OrderDataTile(
            leftTitle:
                '${AppLocalization.of(context).getTransatedValues('orderedData')}:',
            rightTitle:
                '${formatDateTime(orderData.until.toString())}, ${orderData.untilTo}',
          ),
          OrderDataTile(
            leftTitle:
                '${AppLocalization.of(context).getTransatedValues('deliveryTime')}:',
            rightTitle: '${orderData.untilTo} - ${orderData.untilFrom}',
          ),
          OrderDataTile(
            leftTitle:
                '${AppLocalization.of(context).getTransatedValues('payMethod')}:',
            rightTitle: orderData.payment!.name.toString(),
          ),
          OrderDataTile(
            leftTitle:
                '${AppLocalization.of(context).getTransatedValues('status')}:',
            rightTitle: orderData.status!,
          ),
          OrderDataTile(
            leftTitle:
                '${AppLocalization.of(context).getTransatedValues('sum')}:',
            rightTitle: '${orderData.price} TMT',
            needDivider: false,
          ),
        ],
      ),
    );
  }
}

class OrderDataTile extends StatelessWidget {
  final String leftTitle;
  final String rightTitle;
  final bool? needDivider;
  const OrderDataTile({
    required this.leftTitle,
    required this.rightTitle,
    this.needDivider = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              leftTitle,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: AppFonts.fontSize14,
                color: AppColors.grey1Color,
              ),
            ),
            Expanded(
              child: Text(
                rightTitle,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontWeight:
                      needDivider == false ? FontWeight.w800 : FontWeight.w600,
                  fontSize: AppFonts.fontSize14,
                  color: needDivider == false
                      ? AppColors.purpleColor
                      : AppColors.darkPurpleColor,
                ),
              ),
            ),
          ],
        ),
        needDivider == true
            ? Divider(
                color: AppColors.grey5Color,
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
