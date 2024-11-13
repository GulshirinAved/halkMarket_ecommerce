import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/blocs/auth/userProfile/user_profile_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/auth/validateTextField/validate_text_field_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/cart/cartButton/cart_button_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/cart/expandCartPrice/expand_cart_price_cubit.dart';
import 'package:halkmarket_ecommerce/blocs/cart/getDelivery/get_delivery_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/cart/getPayment/get_payment_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/cart/toOrder/to_order_bloc.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/animations.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_appBar.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_dialog.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/cart/components/cartPrice_bottomSheet.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/cart/components/cartProduct_card.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/cart/components/toOrder_bottomsheet.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController addressController;
  late TextEditingController commentController;
  late GetPaymentBloc _getPaymentBloc;
  late GetDeliveryBloc _getDeliveryBloc;
  late UserProfileBloc _userProfileBloc;

  @override
  void initState() {
    nameController = TextEditingController();
    phoneController = TextEditingController(text: '+993 | ');

    addressController = TextEditingController();
    commentController = TextEditingController();
    _getPaymentBloc = GetPaymentBloc()..add(GetPaymentList());
    _getDeliveryBloc = GetDeliveryBloc()..add(const GetDeliveryList());
    _userProfileBloc = UserProfileBloc()..add(GetUserData());

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    commentController.dispose();
    _getPaymentBloc.close();
    _getDeliveryBloc.close();
    _userProfileBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ExpandCartPriceCubit(),
        ),
        BlocProvider(
          create: (context) => ToOrderBloc(),
        ),
        BlocProvider(
          create: (context) => ValidateTextFieldBloc(),
        ),
        BlocProvider.value(
          value: _getPaymentBloc,
        ),
        BlocProvider.value(
          value: _getDeliveryBloc,
        ),
        BlocProvider.value(
          value: _userProfileBloc,
        ),
      ],
      child: Scaffold(
        appBar: CustomAppBar.categoryProfile(
          title: AppLocalization.of(context).getTransatedValues('cart') ?? '',
          needLeading: false,
          actions: [
            BlocBuilder<CartButtonBloc, CartButtonState>(
              builder: (context, state) {
                return IconButton(
                  onPressed: () {
                    customDialog(
                      context,
                      subTitle: AppLocalization.of(context)
                              .getTransatedValues('sureToDelete') ??
                          '',
                      rightOnTap: () {
                        context
                            .read<CartButtonBloc>()
                            .add(const RemoveCartAllEvent());
                      },
                    );
                  },
                  icon: Text(
                    AppLocalization.of(context).getTransatedValues('clean') ??
                        '',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: AppFonts.fontSize14,
                      color: state.cartList.isEmpty
                          ? AppColors.grey5Color
                          : AppColors.redColor,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<CartButtonBloc, CartButtonState>(
          builder: (context, state) {
            if (state is CartButtonInitial) {
              return Animations.loading;
            } else if (state.cartList.isEmpty) {
              return Column(
                children: [
                  Animations.empty,
                  Text(
                    AppLocalization.of(context)
                            .getTransatedValues('cartEmpty') ??
                        '',
                  ),
                ],
              );
            }
            return Stack(
              children: [
                //list of products
                Column(
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                        ),
                        margin: const EdgeInsets.all(10),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) =>
                              state.cartList[index] != null
                                  ? CartProductCard(
                                      index: index,
                                      cartItem: state.cartList[index]!,
                                    )
                                  : const SizedBox.shrink(),
                          itemCount: state.cartList.length,
                        ),
                      ),
                    ),
                  ],
                ),
                //initial bottomsheet with data about order
                BlocBuilder<ToOrderBloc, ToOrderState>(
                  builder: (context, deliveryState) {
                    return CartPriceBottomSheet(
                      state: state,
                      deliveryPrice: deliveryState.deliveryPrice ?? 0,
                      onTap: () {
                        toOrderBottomSheet(
                          context,
                          phoneController: phoneController,
                          nameController: nameController,
                          commentController: commentController,
                          adressController: addressController,
                        );
                      },
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class ReadyOrderButton extends StatelessWidget {
  final String sumPrice;
  final VoidCallback onTap;
  const ReadyOrderButton({
    required this.sumPrice,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 5,
        ),
        margin: const EdgeInsets.only(
          bottom: 15,
        ),
        decoration: BoxDecoration(
          color: AppColors.purpleColor,
          borderRadius: AppBorders.borderRadius12,
          boxShadow: [
            BoxShadow(
              offset: const Offset(4, 4),
              blurRadius: 15,
              color: AppColors.grey3Color.withOpacity(0.35),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                AppLocalization.of(context).getTransatedValues(
                      'orderReady',
                    ) ??
                    '',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: AppFonts.fontSize16,
                  color: AppColors.whiteColor,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Text(
              ' $sumPrice ${AppLocalization.of(context).getTransatedValues('manat')}',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: AppFonts.fontSize16,
                color: AppColors.whiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
