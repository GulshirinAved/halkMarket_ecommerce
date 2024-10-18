// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import 'package:halkmarket_ecommerce/config/theme/constants.dart';
import 'package:halkmarket_ecommerce/data/endpoints.dart';
import 'package:halkmarket_ecommerce/data/models/getOneOrderHis_model.dart';

class OrderedProductsCards extends StatelessWidget {
  final List<OrderProduct> productList;
  const OrderedProductsCards({
    required this.productList,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            ExtendedImage.network(
              '${Endpoints().url}/${productList[index].product!.images![0].url!}',
              height: 71,
              width: 71,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productList[index].product!.name!,
                    style: TextStyle(
                      color: AppColors.darkPurpleColor,
                      fontWeight: FontWeight.w600,
                      fontSize: AppFonts.fontSize14,
                    ),
                  ),
                  Text(
                    '${productList[index].product!.amount!} ${productList[index].product!.unit!.name!}',
                    style: TextStyle(
                      color: AppColors.grey1Color,
                      fontWeight: FontWeight.w600,
                      fontSize: AppFonts.fontSize12,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Количество: ${productList[index].product!.quantity}',
                          style: TextStyle(
                            color: AppColors.darkPurpleColor,
                            fontWeight: FontWeight.w600,
                            fontSize: AppFonts.fontSize14,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '${productList[index].product!.price}.${productList[index].product!.price} TMT',
                          style: TextStyle(
                            color: AppColors.darkPurpleColor,
                            fontWeight: FontWeight.w800,
                            fontSize: AppFonts.fontSize16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      separatorBuilder: (context, index) => Divider(
        color: AppColors.grey5Color,
      ),
      itemCount: productList.length,
    );
  }
}
