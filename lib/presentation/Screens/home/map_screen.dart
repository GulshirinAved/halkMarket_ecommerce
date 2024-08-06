import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/blocs/home/selectMapOptions/select_map_option_cubit.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double markerWidth = MediaQuery.of(context).size.width * 0.2;
    final double markerHeight = MediaQuery.of(context).size.height * 0.2;
    return BlocProvider(
      create: (context) => SelectMapOptionCubit(),
      child: Scaffold(
        body: Stack(
          children: [
            FlutterMap(
              options: const MapOptions(
                initialCenter: LatLng(38.9697, 59.5563),
                initialZoom: 11,
                interactionOptions:
                    InteractionOptions(flags: ~InteractiveFlag.doubleTapZoom),
              ),
              children: [
                openStreetMapTileLayer,
                MarkerLayer(
                  markers: [
                    Marker(
                      point: const LatLng(38.9697, 59.5563),
                      width: markerWidth,
                      height: markerHeight,
                      alignment: Alignment.center,
                      child: SvgPicture.asset(gpsIcon),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(4, 4),
                      blurRadius: 15,
                      color: AppColors.grey4Color.withOpacity(0.55),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalization.of(context)
                              .getTransatedValues('whereToDeliver') ??
                          '',
                      style: TextStyle(
                        fontFamily: fontExo2,
                        fontWeight: FontWeight.w700,
                        fontSize: AppFonts.fontSize18,
                        color: AppColors.darkPurpleColor,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      AppLocalization.of(context)
                              .getTransatedValues('showInMap') ??
                          '',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: AppFonts.fontSize15,
                        color: AppColors.darkPurpleColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 20.w,
              bottom: 142.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: List.generate(
                  mapOptionIcons.length,
                  (index) =>
                      BlocBuilder<SelectMapOptionCubit, SelectMapOptionState>(
                    builder: (context, state) {
                      return GestureDetector(
                        onTap: () => context
                            .read<SelectMapOptionCubit>()
                            .selectCard(index),
                        child: mapIconButton(
                          context: context,
                          iconName: mapOptionIcons[index],
                          backColor: index == state.selectedIndex
                              ? AppColors.whiteColor
                              : AppColors.purpleColor,
                          iconColor: index == state.selectedIndex
                              ? AppColors.purpleColor
                              : AppColors.whiteColor,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget mapIconButton({
    required BuildContext context,
    final String? iconName,
    final Color? backColor,
    final Color? iconColor,
  }) {
    return Container(
      height: 44.h,
      width: 44.w,
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: backColor,
        borderRadius: AppBorders.borderRadius8,
        boxShadow: [
          BoxShadow(
            offset: const Offset(4, 4),
            blurRadius: 15,
            color: AppColors.grey3Color.withOpacity(0.35),
          ),
        ],
      ),
      child: SvgPicture.asset(
        iconName!,
        fit: BoxFit.scaleDown,
        colorFilter: ColorFilter.mode(iconColor!, BlendMode.srcIn),
      ),
    );
  }
}

TileLayer get openStreetMapTileLayer => TileLayer(
      urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
      subdomains: const ['a', 'b', 'c'],
    );
