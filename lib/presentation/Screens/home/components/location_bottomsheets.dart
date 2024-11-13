import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/blocs/auth/validateTextField/validate_text_field_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/map/addDeliveryLocation/location_add_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/map/getLocation/get_location_cubit.dart';
import 'package:halkmarket_ecommerce/blocs/map/getLocation/get_location_state.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/animations.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_button.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_dialog.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_radio.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/addAdress_textButton.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/map_screen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class LocationBottomsheet {
  Future<dynamic> addAddressBottomsheet(BuildContext context) {
    return showModalBottomSheet(
      backgroundColor: AppColors.whiteColor,
      context: context,
      isScrollControlled: true,
      builder: (contextt) => MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: context.read<LocationAddBloc>()
              ..add(const ShowSavedLocationEvent()),
          ),
          BlocProvider.value(
            value: context.read<LocationCubit>(),
          ),
        ],
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //top title and close icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalization.of(context)
                            .getTransatedValues('myAddresses') ??
                        '',
                    style: TextStyle(
                      fontFamily: fontExo2,
                      fontWeight: FontWeight.w700,
                      fontSize: AppFonts.fontSize18,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(contextt);
                    },
                    icon: Icon(
                      Icons.close,
                      size: 20,
                      color: AppColors.grey1Color,
                    ),
                  ),
                ],
              ),
              //if empty show desc of what to do
              BlocBuilder<LocationAddBloc, LocationAddState>(
                builder: (context, state) {
                  if (state is SaveAddressState) {
                    return state.savedLocation.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 20,
                            ),
                            child: Text(
                              AppLocalization.of(context).getTransatedValues(
                                    'addAddressForDelivery',
                                  ) ??
                                  '',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: AppFonts.fontSize15,
                                color: AppColors.grey1Color,
                              ),
                            ),
                          )
                        : SizedBox(
                            height: 160,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.savedLocation.length,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                final address = state.savedLocation.reversed
                                    .toList()[index];
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: CustomRadio(
                                        value:
                                            '${address['address']}, ${address['apartment']}',
                                        radioLeft: true,
                                        fontSize: AppFonts.fontSize15,
                                        groupValue: state.selectedRadioValue,
                                        onChanged: (value) {
                                          context.read<LocationAddBloc>().add(
                                                ToggleAddressEvent(
                                                  selectedValue: value,
                                                ),
                                              );

                                          Navigator.pop(contextt);
                                        },
                                        title:
                                            '${address['address']}, ${address['apartment']}',
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        customDialog(
                                          context,
                                          subTitle: AppLocalization.of(
                                                context,
                                              ).getTransatedValues(
                                                'sureToDeleteAddress',
                                              ) ??
                                              '',
                                          rightOnTap: () {
                                            final selectedAddress = state
                                                .savedLocation.reversed
                                                .toList()[index];

                                            context.read<LocationAddBloc>().add(
                                                  RemoveAddressEvent(
                                                    address: selectedAddress[
                                                        'address'],
                                                    apartment: selectedAddress[
                                                        'apartment'],
                                                    entrance: selectedAddress[
                                                        'entrance'],
                                                    floor: selectedAddress[
                                                        'floor'],
                                                    id: selectedAddress['id'],
                                                  ),
                                                );
                                            context.read<LocationAddBloc>().add(
                                                  const ShowSavedLocationEvent(),
                                                );
                                          },
                                        );
                                      },
                                      icon: SvgPicture.asset(
                                        trashIcon,
                                        colorFilter: ColorFilter.mode(
                                          AppColors.redColor,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          );
                  }
                  return const SizedBox.shrink();
                },
              ),
              //add address text button
              AddAdressTextButton(
                onTap: () {
                  pushScreenWithoutNavBar(context, const MapScreen());
                },
              ),
              //add address button
              Padding(
                padding: const EdgeInsets.only(
                  bottom: kBottomNavigationBarHeight,
                  top: 20,
                ),
                child: CustomButton.text(
                  width: MediaQuery.of(context).size.width,
                  backColor: AppColors.purpleColor,
                  textColor: AppColors.whiteColor,
                  fontSize: AppFonts.fontSize16,
                  title: AppLocalization.of(context)
                          .getTransatedValues('addAddress') ??
                      '',
                  onTap: () {
                    pushScreenWithoutNavBar(context, const MapScreen());
                  },
                  borderRadius: AppBorders.borderRadius12,
                  padding: const EdgeInsets.all(17),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container mapDefaultBottomsheet(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppLocalization.of(context).getTransatedValues('whereToDeliver') ??
                '',
            style: TextStyle(
              fontFamily: fontExo2,
              fontWeight: FontWeight.w700,
              fontSize: AppFonts.fontSize18,
              color: AppColors.darkPurpleColor,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            AppLocalization.of(context).getTransatedValues('showInMap') ?? '',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: AppFonts.fontSize15,
              color: AppColors.darkPurpleColor,
            ),
          ),
        ],
      ),
    );
  }

  Container currentLocationBottomsheet(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          //error
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    AppLocalization.of(context)
                            .getTransatedValues('addressError') ??
                        '',
                    style: TextStyle(
                      color: AppColors.darkPurpleColor,
                      fontFamily: fontExo2,
                      fontWeight: FontWeight.w700,
                      fontSize: AppFonts.fontSize18,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.close,
                    size: 20,
                    color: AppColors.grey1Color,
                  ),
                ),
              ],
            ),
          ),
          //location name
          Row(
            children: [
              SvgPicture.asset(locationIcon),
              const SizedBox(
                width: 12,
              ),
              BlocBuilder<LocationCubit, LocationState>(
                builder: (context, state) {
                  return Expanded(
                    child: Text(
                      state.address,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: AppFonts.fontSize15,
                        color: AppColors.darkPurpleColor,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: AddAdressTextButton(
              onTap: () {
                context.read<LocationCubit>().deliverButtonPressed();
              },
            ),
          ),
          CustomButton.text(
            width: double.infinity,
            backColor: AppColors.lightPurpleColor,
            textColor: AppColors.purpleColor,
            fontSize: AppFonts.fontSize16,
            title: AppLocalization.of(context)
                    .getTransatedValues('deliverToThePoint') ??
                '',
            onTap: () {
              context.read<LocationCubit>().deliverButtonPressed();
            },
            borderRadius: AppBorders.borderRadius12,
            padding: const EdgeInsets.all(17),
          ),
        ],
      ),
    );
  }

  Widget addNewAdress(
    BuildContext context, {
    required String? fullAdress,
    required TextEditingController addressController,
    required TextEditingController apartmentController,
    required TextEditingController entranceController,
    required TextEditingController floorController,
    required TextEditingController commentController,
  }) {
    return BlocListener<LocationAddBloc, LocationAddState>(
      listener: (context, state) {
        if (state is SaveAddressState) {
          Navigator.pop(context);
          context.read<LocationAddBloc>().add(const ShowSavedLocationEvent());
        }
      },
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //top name and back icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalization.of(context).getTransatedValues(
                          'newDeliveryAddress',
                        ) ??
                        '',
                    style: TextStyle(
                      fontFamily: fontExo2,
                      fontSize: AppFonts.fontSize18,
                      color: AppColors.darkPurpleColor,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.close,
                      color: AppColors.grey1Color,
                    ),
                  ),
                ],
              ),
              ListView(
                shrinkWrap: true,
                children: [
                  //address textfield
                  BlocBuilder<ValidateTextFieldBloc, ValidateTextFieldState>(
                    builder: (context, state) {
                      addressController.text = addressController.text.isEmpty
                          ? fullAdress.toString()
                          : addressController.text;
                      return NewAddressTextField(
                        errorText: state.isAddressValid
                            ? ''
                            : AppLocalization.of(context)
                                    .getTransatedValues('fillError') ??
                                '',
                        topTitle: AppLocalization.of(context)
                                .getTransatedValues('address') ??
                            '',
                        controller: addressController,
                        maxLine: 3,
                        onChanged: (value) {
                          context
                              .read<ValidateTextFieldBloc>()
                              .add(AddressChanged(address: value));
                        },
                      );
                    },
                  ),
                  //apartment entrace floor textfield
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BlocBuilder<ValidateTextFieldBloc,
                          ValidateTextFieldState>(
                        builder: (context, state) {
                          return Expanded(
                            child: NewAddressTextField(
                              errorText: state.isApartmentValid
                                  ? ''
                                  : AppLocalization.of(context)
                                          .getTransatedValues('fillError') ??
                                      '',
                              topTitle: AppLocalization.of(context)
                                      .getTransatedValues(
                                    'apartment',
                                  ) ??
                                  '',
                              controller: apartmentController,
                              onChanged: (value) {
                                context
                                    .read<ValidateTextFieldBloc>()
                                    .add(ApartmentChanged(apartment: value));
                              },
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      BlocBuilder<ValidateTextFieldBloc,
                          ValidateTextFieldState>(
                        builder: (context, state) {
                          return Expanded(
                            child: NewAddressTextField(
                              errorText: state.isEntranceValid
                                  ? ''
                                  : AppLocalization.of(context)
                                          .getTransatedValues('fillError') ??
                                      '',
                              topTitle: AppLocalization.of(context)
                                      .getTransatedValues(
                                    'entrance',
                                  ) ??
                                  '',
                              controller: entranceController,
                              onChanged: (value) {
                                context
                                    .read<ValidateTextFieldBloc>()
                                    .add(EntranceChanged(entrance: value));
                              },
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      BlocBuilder<ValidateTextFieldBloc,
                          ValidateTextFieldState>(
                        builder: (context, state) {
                          return Expanded(
                            child: NewAddressTextField(
                              errorText: state.isFloorValid
                                  ? ''
                                  : AppLocalization.of(context)
                                          .getTransatedValues('fillError') ??
                                      '',
                              topTitle: AppLocalization.of(context)
                                      .getTransatedValues(
                                    'floor',
                                  ) ??
                                  '',
                              controller: floorController,
                              onChanged: (value) {
                                context
                                    .read<ValidateTextFieldBloc>()
                                    .add(FloorChanged(floor: value));
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  //comment for courier
                  NewAddressTextField(
                    errorText: '',
                    topTitle: AppLocalization.of(context).getTransatedValues(
                          'courierComment',
                        ) ??
                        '',
                    controller: commentController,
                    maxLine: 3,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: CustomButton.text(
                  width: double.infinity,
                  backColor: AppColors.purpleColor,
                  textColor: AppColors.whiteColor,
                  fontSize: AppFonts.fontSize16,
                  title: AppLocalization.of(context)
                          .getTransatedValues('addAddress') ??
                      '',
                  onTap: () async {
                    if (addressController.text != '' &&
                        apartmentController.text != '' &&
                        entranceController.text != '' &&
                        floorController.text != '') {
                      context.read<LocationAddBloc>().add(
                            SaveAddressEvent(
                              address: addressController.text,
                              apartment: apartmentController.text,
                              entrance: entranceController.text,
                              floor: floorController.text,
                              comment: commentController.text,
                            ),
                          );
                    } else {
                      context.read<ValidateTextFieldBloc>().add(
                            AddressChanged(address: addressController.text),
                          );
                      context.read<ValidateTextFieldBloc>().add(
                            ApartmentChanged(
                              apartment: apartmentController.text,
                            ),
                          );
                      context.read<ValidateTextFieldBloc>().add(
                            EntranceChanged(
                              entrance: entranceController.text,
                            ),
                          );
                      context
                          .read<ValidateTextFieldBloc>()
                          .add(FloorChanged(floor: floorController.text));
                      Animations().snackbar(context, 'fillError');
                    }
                  },
                  borderRadius: AppBorders.borderRadius12,
                  padding: const EdgeInsets.all(17),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
