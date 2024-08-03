import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/config/theme/theme.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/cart/components/cartCount_button.dart';

class CartProductCard extends StatelessWidget {
  final int index;
  const CartProductCard({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(newProducts[index]['image']),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Картофельное пюре "Rollton" с куриным вкусом',
                      maxLines: 2,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: AppFonts.fontSize14,
                        color: AppColors.darkPurpleColor,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      trashIcon,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '1546.00 ман',
                    maxLines: 2,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: AppFonts.fontSize16,
                      color: AppColors.darkPurpleColor,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: Row(
                      children: [
                        const CartCountButton(
                          icon: CupertinoIcons.minus,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            '10 шт',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: AppFonts.fontSize16,
                              color: AppColors.darkPurpleColor,
                            ),
                          ),
                        ),
                        const CartCountButton(
                          icon: CupertinoIcons.plus,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
