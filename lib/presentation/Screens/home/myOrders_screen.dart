// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/blocs/cart/orderHistory/order_history_bloc.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_appBar.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/ordered_card.dart';

class MyordersScreen extends StatelessWidget {
  const MyordersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderHistoryBloc()..add(GetOrderHistory()),
      child: Scaffold(
        appBar: CustomAppBar.leadingTitle(
          title:
              AppLocalization.of(context).getTransatedValues('myOrders') ?? '',
          centerTitle: true,
        ),
        body: BlocBuilder<OrderHistoryBloc, OrderHistoryState>(
          builder: (context, state) {
            if (state is OrderHistoryLoaded) {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: state.historyList.length,
                itemBuilder: (context, index) => OrderedCard(
                  orderNumber: state.historyList[index].id!,
                  orderedTime: state.historyList[index].until.toString(),
                  paymentType:
                      state.historyList[index].payment!.name.toString(),
                  status: state.historyList[index].status!,
                  sum: state.historyList[index].price.toString(),
                  untilFrom: state.historyList[index].untilFrom.toString(),
                  untilTo: state.historyList[index].untilTo.toString(),
                  id: state.historyList[index].id!,
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
