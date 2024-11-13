import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/blocs/map/addDeliveryLocation/location_add_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/map/getLocation/get_location_cubit.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_appBar.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_button.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_radio.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/map_screen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class MyAddressScreen extends StatelessWidget {
  const MyAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocationCubit(),
      child: BlocProvider(
        create: (context) =>
            LocationAddBloc()..add(const ShowSavedLocationEvent()),
        child: Builder(
          builder: (context) {
            return Scaffold(
              appBar: CustomAppBar.leadingTitle(
                title: AppLocalization.of(context)
                        .getTransatedValues('myAddresses') ??
                    '',
                centerTitle: true,
                needBoxshadow: true,
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //add button
                  Center(
                    child: Container(
                      constraints: const BoxConstraints(
                        minWidth: 200,
                        maxWidth: 300,
                      ),
                      padding: const EdgeInsets.all(20).copyWith(bottom: 10),
                      alignment: Alignment.topCenter,
                      child: CustomButton.withIconText(
                        width: 190,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        backColor: AppColors.purpleColor,
                        textColor: AppColors.whiteColor,
                        fontSize: AppFonts.fontSize16,
                        title: AppLocalization.of(context)
                                .getTransatedValues('addAddress') ??
                            '',
                        fontweight: FontWeight.w600,
                        onTap: () {
                          pushScreenWithoutNavBar(
                            context,
                            const MapScreen(),
                          );
                        },
                        icon: plusIcon,
                        borderRadius: AppBorders.borderRadius12,
                      ),
                    ),
                  ),
                  //list of saved addresses

                  BlocBuilder<LocationAddBloc, LocationAddState>(
                    builder: (context, state) {
                      return Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.savedLocation.length,
                          itemBuilder: (context, index) {
                            final address =
                                state.savedLocation.reversed.toList()[index];
                            return Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.grey5Color,
                                ),
                                borderRadius: AppBorders.borderRadius12,
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 2,
                              ),
                              margin: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 6,
                              ),
                              child: CustomRadio(
                                radioLeft: true,
                                title:
                                    '${address['address']}, ${address['apartment']}',
                                value:
                                    '${address['address']}, ${address['apartment']}',
                                groupValue: state.selectedRadioValue,
                                onChanged: (value) {
                                  context.read<LocationAddBloc>().add(
                                        ToggleAddressEvent(
                                          selectedValue: value,
                                        ),
                                      );
                                },
                                fontSize: AppFonts.fontSize14,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
