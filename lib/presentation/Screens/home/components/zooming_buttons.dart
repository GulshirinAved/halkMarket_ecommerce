import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:halkmarket_ecommerce/blocs/map/getLocation/get_location_cubit.dart';
import 'package:halkmarket_ecommerce/blocs/map/getLocation/get_location_state.dart';
import 'package:halkmarket_ecommerce/blocs/map/zooming/zooming_cubit.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';
import 'package:latlong2/latlong.dart';

class ZoomingIcon extends StatelessWidget {
  const ZoomingIcon({
    required this.mapController,
    super.key,
  });

  final MapController mapController;

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocBuilder<LocationCubit, LocationState>(
            builder: (context, locationState) {
              return BlocBuilder<ZoomingCubit, double>(
                builder: (context, state) {
                  return IconButton(
                    onPressed: () {
                      context.read<ZoomingCubit>().zoomOut();
                      mapController.move(
                        locationState.location == null
                            ? const LatLng(37.862499, 58.238056)
                            : locationState.location!,
                        state,
                      );
                    },
                    icon: Icon(
                      CupertinoIcons.add,
                      color: AppColors.purpleColor,
                    ),
                  );
                },
              );
            },
          ),
          BlocBuilder<LocationCubit, LocationState>(
            builder: (context, locationState) {
              return BlocBuilder<ZoomingCubit, double>(
                builder: (context, state) {
                  return IconButton(
                    onPressed: () {
                      context.read<ZoomingCubit>().zoomIn();
                      mapController.move(
                        locationState.location == null
                            ? const LatLng(37.862499, 58.238056)
                            : locationState.location!,
                        state,
                      );
                    },
                    icon: Icon(
                      CupertinoIcons.minus,
                      color: AppColors.purpleColor,
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
