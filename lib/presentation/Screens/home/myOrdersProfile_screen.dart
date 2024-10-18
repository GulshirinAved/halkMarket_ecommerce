// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/blocs/cart/cancelOrder/cancel_order_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/cart/oneOrderHistory/one_order_his_bloc.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_appBar.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_button.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/orderDesc_card.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/orderedProducts_cards.dart';

class MyOrdersProfileScreen extends StatelessWidget {
  final String id;
  final String topTitle;

  const MyOrdersProfileScreen({
    required this.id,
    required this.topTitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OneOrderHisBloc()..add(GetOneHistory(id: id)),
        ),
        BlocProvider(
          create: (context) => CancelOrderBloc(),
        ),
      ],
      child: Scaffold(
        appBar: CustomAppBar.leadingTitle(
          title:
              '${AppLocalization.of(context).getTransatedValues('orderN')}: $id ',
          centerTitle: true,
        ),
        body: BlocBuilder<OneOrderHisBloc, OneOrderHisState>(
          builder: (context, state) {
            if (state is OneOrderHisLoaded) {
              return Container(
                margin: const EdgeInsets.all(20),
                height: MediaQuery.of(context).size.height,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    CustomButton.withIconText(
                      padding: const EdgeInsets.only(
                        top: 13,
                        bottom: 16,
                        left: 18,
                        right: 18,
                      ),
                      width: double.infinity,
                      backColor: AppColors.grey2Color,
                      textColor: AppColors.grey1Color,
                      fontSize: AppFonts.fontSize16,
                      title: AppLocalization.of(context)
                              .getTransatedValues('cancelOrder') ??
                          '',
                      fontweight: FontWeight.w600,
                      onTap: () {
                        context
                            .read<CancelOrderBloc>()
                            .add(ButtonPressed(id: id));
                      },
                      icon: closeIcon,
                      borderRadius: AppBorders.borderRadius8,
                    ),
                    //full data about order
                    OrderDescCard(
                      orderData: state.orderData,
                    ),
                    //orderedProducds cards
                    OrderedProductsCards(
                      productList: state.orderData.orderProducts!,
                    ),
                  ],
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
