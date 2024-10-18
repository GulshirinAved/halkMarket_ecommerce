import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/blocs/profile/savePaymentCard/save_card_bloc.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_appBar.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_button.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/pay_card.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/payMethodProfile_screen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class PayMethodScreen extends StatelessWidget {
  const PayMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SaveCardBloc()..add(const LoadCard()),
      child: Scaffold(
        appBar: CustomAppBar.leadingTitle(
          title:
              AppLocalization.of(context).getTransatedValues('payMethod') ?? '',
          centerTitle: true,
          needBoxshadow: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              //card
              BlocBuilder<SaveCardBloc, SaveCardState>(
                builder: (context, state) {
                  log(state.toString());
                  if (state is LoadCardState) {
                    return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.cardDataList.length,
                      itemBuilder: (context, index) {
                        final secretCardNumber =
                            state.cardDataList[index]['cardNumber'].substring(
                          state.cardDataList[index]['cardNumber'].length - 4,
                        );
                        return CardData(
                          userName: state.cardDataList[index]['userName'],
                          cardNumber: secretCardNumber,
                          expireDate: state.cardDataList[index]['expireDate'],
                        );
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              //add card button
              CustomButton.withIconText(
                padding: const EdgeInsets.symmetric(vertical: 13),
                borderRadius: AppBorders.borderRadius12,
                width: MediaQuery.of(context).size.width,
                backColor: AppColors.purpleColor,
                textColor: AppColors.whiteColor,
                fontSize: AppFonts.fontSize16,
                title:
                    AppLocalization.of(context).getTransatedValues('addCard') ??
                        '',
                fontweight: FontWeight.w400,
                onTap: () {
                  pushScreenWithoutNavBar(
                    context,
                    const PayMethodProfileScreen(),
                  );
                },
                icon: addCardIcon,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
