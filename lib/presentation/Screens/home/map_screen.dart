import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:halkmarket_ecommerce/blocs/auth/validateTextField/validate_text_field_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/map/addDeliveryLocation/location_add_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/map/getLocation/get_location_cubit.dart';
import 'package:halkmarket_ecommerce/blocs/map/getLocation/get_location_state.dart';
import 'package:halkmarket_ecommerce/blocs/map/zooming/zooming_cubit.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';
import 'package:halkmarket_ecommerce/presentation/CustomWidgets/custom_textField.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/currentLocation_button.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/location_bottomsheets.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/components/zooming_buttons.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late MapController mapController;
  late TextEditingController addressController;
  late TextEditingController apartmentController;
  late TextEditingController entranceController;
  late TextEditingController floorController;
  late TextEditingController commentController;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
    addressController = TextEditingController();
    apartmentController = TextEditingController();
    entranceController = TextEditingController();
    floorController = TextEditingController();
    commentController = TextEditingController();
  }

  @override
  void dispose() {
    mapController.dispose();
    addressController.dispose();
    apartmentController.dispose();
    entranceController.dispose();
    floorController.dispose();
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LocationCubit(),
        ),
        BlocProvider(
          create: (context) => ValidateTextFieldBloc(),
        ),
        BlocProvider(
          create: (context) => ZoomingCubit(),
        ),
        BlocProvider(
          create: (context) => LocationAddBloc(),
        ),
      ],
      child: BlocBuilder<LocationCubit, LocationState>(
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            body: Stack(
              children: [
                // Map
                FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                    onTap: (tapPosition, point) {
                      print(point.toString());
                      context.read<LocationCubit>().onMapTap(point);
                    },
                    initialCenter:
                        state.location ?? const LatLng(37.862499, 58.238056),
                    initialZoom: 9.2,
                    keepAlive: true,
                    interactionOptions: const InteractionOptions(
                      flags: ~InteractiveFlag.doubleTapDragZoom,
                    ),
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.halkmarket_ecommerce',
                    ),
                    if (state.location != null &&
                        state.showCurrentLocation != 0)
                      MarkerLayer(
                        markers: [
                          Marker(
                            width: 80.0,
                            height: 80.0,
                            point: state.location!,
                            child: SvgPicture.asset(gpsIcon),
                          ),
                        ],
                      ),
                  ],
                ),
                // Back Icon
                Positioned(
                  left: 20,
                  top: 40,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 44,
                      width: 44,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: AppBorders.borderRadius8,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(4, 4),
                            blurRadius: 15,
                            color: AppColors.grey3Color,
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.close,
                        color: AppColors.purpleColor,
                      ),
                    ),
                  ),
                ),
                // Zoom Icon and Locate Icon
                Positioned(
                  right: 20,
                  top: state.showCurrentLocation == 1
                      ? MediaQuery.of(context).size.height / 3.7
                      : state.showCurrentLocation == 2
                          ? MediaQuery.of(context).size.height / 15
                          : MediaQuery.of(context).size.height / 2.2,
                  child: Column(
                    children: [
                      ZoomingIcon(mapController: mapController),
                      GestureDetector(
                        onTap: () {
                          context.read<LocationCubit>().toggleLocation();
                        },
                        child: const CurrentLocationButton(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Toggle between default and current location bottom sheets
            bottomSheet: BlocBuilder<LocationCubit, LocationState>(
              builder: (context, state) {
                return state.showCurrentLocation == 1
                    ? LocationBottomsheet().currentLocationBottomsheet(context)
                    : state.showCurrentLocation == 2
                        ? LocationBottomsheet().addNewAdress(
                            context,
                            addressController: addressController,
                            apartmentController: apartmentController,
                            commentController: commentController,
                            entranceController: entranceController,
                            floorController: floorController,
                          )
                        : LocationBottomsheet().mapDefaultBottomsheet(context);
              },
            ),
          );
        },
      ),
    );
  }
}

class NewAddressTextField extends StatelessWidget {
  final String topTitle;
  final int? maxLine;
  final TextEditingController controller;
  final Function(String)? onChanged;
  final String errorText;

  const NewAddressTextField({
    required this.topTitle,
    required this.controller,
    required this.errorText,
    this.onChanged,
    this.maxLine,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            topTitle,
            style: TextStyle(
              fontSize: AppFonts.fontSize15,
              fontWeight: FontWeight.w400,
              color: AppColors.grey1Color,
            ),
          ),
          CustomTextField.normal(
            hintText: '',
            maxLine: maxLine ?? 1,
            borderColor: AppColors.purpleColor,
            nonActiveBorderColor: AppColors.grey5Color,
            backColor: AppColors.whiteColor,
            textEditingController: controller,
            onChanged: onChanged,
            errorText: errorText,
          ),
        ],
      ),
    );
  }
}
