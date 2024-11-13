// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

import 'package:halkmarket_ecommerce/blocs/map/getLocation/get_location_cubit.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';

class CurrentLocationButton extends StatelessWidget {
  final MapLibreMapController mapController;
  const CurrentLocationButton({
    required this.mapController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await context.read<LocationCubit>().toggleLocation(mapController);
      },
      child: Container(
        height: 44,
        width: 44,
        // ignore: prefer_const_constructors
        margin: EdgeInsets.only(top: 115),
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
        child: SvgPicture.asset(
          locateIcon,
          colorFilter: ColorFilter.mode(
            AppColors.purpleColor,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
