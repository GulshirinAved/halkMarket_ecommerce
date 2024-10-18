import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/blocs/auth/userProfile/user_profile_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/auth/validateTextField/validate_text_field_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/cart/cartButton/cart_button_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/cart/createOrder/create_order_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/cart/expandCartPrice/expand_cart_price_cubit.dart';
import 'package:halkmarket_ecommerce/blocs/cart/expandIcon/expand_icon_cubit.dart';
import 'package:halkmarket_ecommerce/blocs/cart/getDelivery/get_delivery_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/cart/getPayment/get_payment_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/cart/toOrder/to_order_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/home/selectCard/select_card_cubit.dart';
import 'package:halkmarket_ecommerce/blocs/map/addDeliveryLocation/location_add_bloc.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';
import 'package:halkmarket_ecommerce/data/api_providers/auth_provider.dart';
import 'package:halkmarket_ecommerce/data/models/updateUserData_model.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/animations.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_radio.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_textField.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/bottomNavBar/bottomNavBar_screen.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/cart/components/cartPrice_bottomSheet.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/cart/components/conditionOfOrdering_tile.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/cart/components/extension.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/selection_card.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/login_screen.dart';
import 'package:intl/intl.dart';
import 'package:nested/nested.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

Future<dynamic> toOrderBottomSheet(
  BuildContext context, {
  final TextEditingController? nameController,
  final TextEditingController? phoneController,
  final TextEditingController? adressController,
  final TextEditingController? commentController,
}) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.whiteColor,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (contextt) => MultiBlocProvider(
      providers: _createBlocProviders(context),
      child: DraggableScrollableSheet(
        expand: false,
        builder: (context, scrollController) {
          return BlocBuilder<UserProfileBloc, UserProfileState>(
            builder: (context, userState) {
              return BlocBuilder<GetDeliveryBloc, GetDeliveryState>(
                builder: (context, deliveryState) {
                  return BlocBuilder<GetPaymentBloc, GetPaymentState>(
                    builder: (context, paymentState) {
                      if (userState is UserProfileLoaded) {
                        final userData = userState.userData;
                        phoneController!.text = userData.phone ?? '';
                      }
                      final List<Address>? addressList =
                          userState is UserProfileLoaded
                              ? userState.userData.address
                              : [];
                      final paymentTypes = paymentState is GetPaymentLoaded
                          ? paymentState.paymentList
                          : [];
                      final deliveryTypes = deliveryState is GetDeliveryLoaded
                          ? deliveryState.deliveryList
                          : [];

                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Header(),
                            Expanded(
                              child: ListView(
                                controller: scrollController,
                                physics: const AlwaysScrollableScrollPhysics(),
                                shrinkWrap: true,
                                children: [
                                  //payment selection
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: List.generate(
                                      paymentTypes.length,
                                      (index) => BlocBuilder<ToOrderBloc,
                                          ToOrderState>(
                                        builder: (context, state) {
                                          return CustomRadio(
                                            title: paymentTypes[index].name,
                                            subTitle:
                                                paymentTypes[index].description,
                                            value: state.payment ??
                                                paymentTypes[0].name,
                                            groupValue:
                                                paymentTypes[index].name,
                                            onChanged: (value) => context
                                                .read<ToOrderBloc>()
                                                .add(
                                                  ToOrderEvent(
                                                    paymentTypes[index].name,
                                                    paymentTypes[index].id,
                                                    state.deliveryName,
                                                    state.deliveryPrice,
                                                    state.deliveryId,
                                                    state.selectedAddress,
                                                    state.until,
                                                    state.untilTo,
                                                    state.untilFrom,
                                                  ),
                                                ),
                                            fontSize: AppFonts.fontSize16,
                                          );
                                        },
                                      ),
                                    ),
                                  ).withText(context, topTitle: 'payMethod'),
                                  //deliverySelection
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: List.generate(
                                      deliveryTypes.length,
                                      (index) => BlocBuilder<ToOrderBloc,
                                          ToOrderState>(
                                        builder: (context, state) {
                                          return CustomRadio(
                                            title:
                                                '${deliveryTypes[index].name} (${deliveryTypes[index].price} TMT)',
                                            subTitle: deliveryTypes[index]
                                                .description,
                                            value: state.deliveryName,
                                            groupValue:
                                                '${deliveryTypes[index].name}',
                                            onChanged: (value) => context
                                                .read<ToOrderBloc>()
                                                .add(
                                                  ToOrderEvent(
                                                    state.payment,
                                                    state.paymentId,
                                                    deliveryTypes[index].name,
                                                    deliveryTypes[index].price,
                                                    deliveryTypes[index].id,
                                                    state.selectedAddress,
                                                    state.until,
                                                    state.untilTo,
                                                    state.untilFrom,
                                                  ),
                                                ),
                                            fontSize: 16,
                                          );
                                        },
                                      ),
                                    ),
                                  ).withText(
                                    context,
                                    topTitle: 'deliveryType',
                                  ),
                                  Divider(
                                    color: AppColors.grey5Color,
                                  ),
                                  //fill address
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      //name field
                                      BlocBuilder<ValidateTextFieldBloc,
                                          ValidateTextFieldState>(
                                        builder: (context, state) {
                                          return CustomTextField.normal(
                                            backColor: AppColors.whiteColor,
                                            nonActiveBorderColor:
                                                AppColors.grey5Color,
                                            borderColor: AppColors.purpleColor,
                                            textEditingController:
                                                nameController,
                                            hintText:
                                                AppLocalization.of(context)
                                                        .getTransatedValues(
                                                      'fullName',
                                                    ) ??
                                                    '',
                                            errorText: state.isNameValid
                                                ? ''
                                                : AppLocalization.of(context)
                                                        .getTransatedValues(
                                                      'fillError',
                                                    ) ??
                                                    '',
                                            maxLine: 1,
                                            labelText:
                                                AppLocalization.of(context)
                                                        .getTransatedValues(
                                                      'name',
                                                    ) ??
                                                    '',
                                            keyboardType: TextInputType.text,
                                            onChanged: (value) => context
                                                .read<ValidateTextFieldBloc>()
                                                .add(
                                                  NameChanged(name: value),
                                                ),
                                          );
                                        },
                                      ),
                                      //phone number field
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 10,
                                        ),
                                        child: CustomTextField.normal(
                                          textEditingController:
                                              phoneController!,
                                          backColor: AppColors.whiteColor,
                                          borderColor: AppColors.purpleColor,
                                          nonActiveBorderColor:
                                              AppColors.grey5Color,
                                          labelText: AppLocalization.of(
                                            context,
                                          ).getTransatedValues(
                                            'phoneNumber',
                                          ),
                                          readOnly: true,
                                          hintText: AppLocalization.of(context)
                                                  .getTransatedValues(
                                                'phoneNumber',
                                              ) ??
                                              '',
                                        ),
                                      ),
                                      //address tile
                                      // if address is empty then show textfield
                                      addressList!.isEmpty
                                          ? BlocBuilder<ValidateTextFieldBloc,
                                              ValidateTextFieldState>(
                                              builder: (context, state) {
                                                return CustomTextField.normal(
                                                  backColor:
                                                      AppColors.whiteColor,
                                                  nonActiveBorderColor:
                                                      AppColors.grey5Color,
                                                  borderColor:
                                                      AppColors.purpleColor,
                                                  textEditingController:
                                                      adressController,
                                                  errorText: state
                                                          .isAddressValid
                                                      ? ''
                                                      : AppLocalization.of(
                                                            context,
                                                          ).getTransatedValues(
                                                            'fillError',
                                                          ) ??
                                                          '',
                                                  maxLine: 2,
                                                  hintText: AppLocalization.of(
                                                        context,
                                                      ).getTransatedValues(
                                                        'addressDesc',
                                                      ) ??
                                                      '',
                                                  labelText: AppLocalization.of(
                                                        context,
                                                      ).getTransatedValues(
                                                        'detailedAddress',
                                                      ) ??
                                                      '',
                                                  keyboardType:
                                                      TextInputType.text,
                                                  onChanged: (value) => context
                                                      .read<
                                                          ValidateTextFieldBloc>()
                                                      .add(
                                                        AddressChanged(
                                                          address: value,
                                                        ),
                                                      ),
                                                );
                                              },
                                            )
                                          // if address is not empty show selection of address
                                          : AddressSelectionCard(
                                              addressList: addressList,
                                            ),

                                      //comments for courier
                                      BlocBuilder<ValidateTextFieldBloc,
                                          ValidateTextFieldState>(
                                        builder: (context, state) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 10,
                                            ),
                                            child: CustomTextField.normal(
                                              backColor: AppColors.whiteColor,
                                              nonActiveBorderColor:
                                                  AppColors.grey5Color,
                                              borderColor:
                                                  AppColors.purpleColor,
                                              textEditingController:
                                                  commentController,
                                              maxLine: 2,
                                              labelText:
                                                  AppLocalization.of(context)
                                                          .getTransatedValues(
                                                        'commentsForCourier',
                                                      ) ??
                                                      '',
                                              keyboardType: TextInputType.text,
                                            ),
                                          );
                                        },
                                      ),

                                      Divider(
                                        color: AppColors.grey5Color,
                                      ),
                                    ],
                                  ).withText(
                                    context,
                                    topTitle: 'enterAddress',
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SelectionCard(
                                        optionList: timeList,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 2,
                                        ),
                                        subTitle: [
                                          getDate(time: 0),
                                          getDate(time: 1),
                                        ],
                                      ),
                                      GridView.builder(
                                        itemCount: clockList.length,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 6,
                                          crossAxisSpacing: 6,
                                          mainAxisExtent: 42,
                                        ),
                                        itemBuilder: (context, index) {
                                          return BlocBuilder<ToOrderBloc,
                                              ToOrderState>(
                                            builder: (context, state) {
                                              return BlocBuilder<
                                                  SelectCardCubit, int>(
                                                builder: (context, untilState) {
                                                  return Container(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: AppColors
                                                            .grey5Color,
                                                      ),
                                                      borderRadius: AppBorders
                                                          .borderRadius12,
                                                    ),
                                                    child: CustomRadio(
                                                      title:
                                                          '${clockList[index]['untilTo']}-${clockList[index]['untilFrom']}',
                                                      value: state.untilFrom ??
                                                          clockList[0]
                                                              ['untilFrom'],
                                                      groupValue:
                                                          '${clockList[index]['untilFrom']}',
                                                      onChanged: (value) =>
                                                          context
                                                              .read<
                                                                  ToOrderBloc>()
                                                              .add(
                                                                ToOrderEvent(
                                                                  state.payment,
                                                                  state
                                                                      .paymentId,
                                                                  deliveryTypes[
                                                                          index]
                                                                      .name,
                                                                  deliveryTypes[
                                                                          index]
                                                                      .price,
                                                                  deliveryTypes[
                                                                          index]
                                                                      .id,
                                                                  state
                                                                      .selectedAddress,
                                                                  timeList[
                                                                      untilState],
                                                                  clockList[
                                                                          index]
                                                                      [
                                                                      'untilTo'],
                                                                  clockList[
                                                                          index]
                                                                      [
                                                                      'untilFrom'],
                                                                ),
                                                              ),
                                                      fontSize:
                                                          AppFonts.fontSize14,
                                                      radioLeft: true,
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ).withText(
                                    context,
                                    topTitle: 'selectDeliveryTime',
                                  ),
                                  //condition of ordering
                                  BlocBuilder<ExpandIconCubit, bool>(
                                    builder: (context, state) {
                                      return ConditionsOfOrdering(
                                        state: state,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            BlocConsumer<CreateOrderBloc, CreateOrderState>(
                              listener: (context, state) {
                                if (state is CreateOrderSuccess) {
                                  Animations()
                                      .snackbar(context, 'orderSuccess');

                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    pushScreenWithoutNavBar(
                                      context,
                                      const BottomNavBar(),
                                    );
                                  });
                                } else if (state is CreateOrderFailure) {
                                  Animations().snackbar(context, 'error');
                                }
                              },
                              builder: (context, state) {
                                return BlocBuilder<ToOrderBloc, ToOrderState>(
                                  builder: (context, deliveryState) {
                                    return BlocBuilder<CartButtonBloc,
                                        CartButtonState>(
                                      builder: (context, cartState) {
                                        return CartPriceBottomSheet(
                                          state: cartState,
                                          deliveryPrice:
                                              deliveryState.deliveryPrice ?? 0,
                                          onTap: () {
                                            _handleOnTap(
                                              context,
                                              nameController,
                                              phoneController,
                                              adressController,
                                              deliveryState,
                                              cartState,
                                              addressList,
                                              deliveryTypes,
                                              paymentTypes,
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    ),
  );
}

void _handleOnTap(
  BuildContext context,
  TextEditingController? nameController,
  TextEditingController? phoneController,
  TextEditingController? adressController,
  ToOrderState deliveryState,
  CartButtonState cartState,
  final List<Address> addressList,
  final List deliveryTypes,
  final List paymentTypes,
) {
  if (AuthProvider().getAccessToken() == null) {
    pushScreen(
      context,
      screen: const LoginScreen(),
    );
  } else if (nameController!.text.isEmpty ||
      adressController!.text.isEmpty && addressList.isEmpty) {
    log('''nameController!.text.isEmpty ${nameController.text.isEmpty} ||
          adressController!.text.isEmpty ${adressController!.text.isEmpty && addressList.isEmpty}||
          addressList.isEmpty ${addressList.isEmpty}
      ? adressController!.text.isEmpty${adressController.text.isEmpty}
      : deliveryState.selectedAddress!.isEmpty ${deliveryState.selectedAddress?.isEmpty}''');

    context.read<ValidateTextFieldBloc>().add(
          NameChanged(
            name: nameController.text,
          ),
        );
  } else {
    print(
      cartState.cartList.first?.shopId,
    );
    log(""" 'address': ${addressList.isEmpty ? adressController.text : '${addressList[0].address} ${addressList[0].apartment}'},
    
              'name': ${nameController.text},
              'phone': ${phoneController!.text},
              'deliveryId': ${deliveryState.deliveryId ?? deliveryTypes[0].id},
              'paymentId': ${deliveryState.paymentId ?? paymentTypes[0].id},
              'summa': 100,
              'untilTo':${deliveryState.untilTo ?? clockList[0]['untilTo']},
              'untilFrom':${deliveryState.untilFrom ?? clockList[0]['untilFrom']},
              'until':${getDate(time: deliveryState.until == 'today' ? 0 : 1)},

              'products': ${List.generate(
      cartState.cartList.length,
      (index) => {
        'productId': cartState.cartList[index]?.id,
        'quantity': cartState.cartList[index]?.quantity,
      },
    )},""");

    context.read<CreateOrderBloc>().add(
          CreateOrderPressed(
            postData: {
              'address': addressList.isEmpty
                  ? adressController.text
                  : '${addressList[0].address} ${addressList[0].apartment}',
              'name': nameController.text,
              'phone': phoneController.text,
              'deliveryId': deliveryState.deliveryId ?? deliveryTypes[0].id,
              'paymentId': deliveryState.paymentId ?? paymentTypes[0].id,
              'summa': (cartState is SumProductState) ? cartState.sum : 0,
              'until': getDate(time: deliveryState.until == 'today' ? 0 : 1),
              'untilFrom': deliveryState.untilFrom ?? clockList[0]['untilFrom'],
              'untilTo': deliveryState.untilTo ?? clockList[0]['untilTo'],
              'products': List.generate(
                cartState.cartList.length,
                (index) => {
                  'productId': cartState.cartList[index]?.id,
                  'quantity': cartState.cartList[index]?.quantity,
                },
              ),
            },
          ),
        );
  }
}

List<SingleChildWidget> _createBlocProviders(BuildContext context) {
  return [
    BlocProvider.value(
      value: context.read<ToOrderBloc>(),
    ),
    BlocProvider(
      create: (context) => ValidateTextFieldBloc(),
    ),
    BlocProvider.value(
      value: context.read<CartButtonBloc>(),
    ),
    BlocProvider(
      create: (context) => ExpandCartPriceCubit(),
    ),
    BlocProvider(
      create: (context) => ExpandIconCubit(),
    ),
    BlocProvider(
      create: (context) => SelectCardCubit(),
    ),
    BlocProvider(
      create: (context) {
        return LocationAddBloc()..add(const ShowSavedLocationEvent());
      },
    ),
    BlocProvider(
      create: (context) => CreateOrderBloc(),
    ),
    BlocProvider.value(
      value: context.read<GetPaymentBloc>()..add(GetPaymentList()),
    ),
    BlocProvider.value(
      value: context.read<GetDeliveryBloc>()..add(const GetDeliveryList()),
    ),
    BlocProvider.value(
      value: context.read<UserProfileBloc>()..add(GetUserData()),
    ),
  ];
}

class AddressSelectionCard extends StatelessWidget {
  const AddressSelectionCard({
    required this.addressList,
    super.key,
  });

  final List<Address>? addressList;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalization.of(context).getTransatedValues(
                'selectAddress',
              ) ??
              '',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: AppFonts.fontSize16,
            color: AppColors.grey1Color,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 18,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.grey5Color,
            ),
            borderRadius: AppBorders.borderRadius12,
          ),
          child: ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return BlocBuilder<ToOrderBloc, ToOrderState>(
                builder: (context, state) {
                  return CustomRadio(
                    radioLeft: true,
                    title:
                        '${addressList?[index].address} ${addressList?[index].apartment}',
                    value: state.selectedAddress ?? addressList?[0].id,
                    groupValue: addressList?[index].id,
                    onChanged: (value) => context.read<ToOrderBloc>().add(
                          ToOrderEvent(
                            state.payment,
                            state.paymentId,
                            state.deliveryName,
                            state.deliveryPrice,
                            state.deliveryId,
                            addressList?[index].id,
                            state.until,
                            state.untilTo,
                            state.untilFrom,
                          ),
                        ),
                    fontSize: 16,
                  );
                },
              );
            },
            separatorBuilder: (context, index) {
              if (index != addressList!.length - 1) {
                return Divider(
                  color: AppColors.grey5Color,
                );
              } else {
                return const SizedBox.shrink();
              }
            },
            itemCount: (addressList ?? []).length,
          ),
        ),
      ],
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              CupertinoIcons.clear_thick,
              color: AppColors.grey1Color,
              size: 20,
            ),
          ),
          Text(
            AppLocalization.of(context).getTransatedValues('toOrder') ?? '',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: fontExo2,
              fontWeight: FontWeight.w700,
              fontSize: AppFonts.fontSize18,
            ),
          ),
        ],
      ),
    );
  }
}

String getDate({required int time}) {
  final today = DateTime.now();
  final tomorrow = today.add(const Duration(days: 1));

  // Format the dates as day.month.year
  final String todayFormatted = DateFormat('yyyy-MM-dd').format(today);
  final String tomorrowFormatted = DateFormat('yyyy-MM-dd').format(tomorrow);
  return time == 0 ? todayFormatted : tomorrowFormatted;
}
