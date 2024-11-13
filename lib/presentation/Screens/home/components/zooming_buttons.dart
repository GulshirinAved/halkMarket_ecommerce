import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

class ZoomingIcon extends StatelessWidget {
  const ZoomingIcon({
    required this.mapController,
    super.key,
  });

  final MapLibreMapController mapController;

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
          IconButton(
            onPressed: () {
              mapController.animateCamera(CameraUpdate.zoomOut());
            },
            icon: Icon(
              CupertinoIcons.add,
              color: AppColors.purpleColor,
            ),
          ),
          IconButton(
            onPressed: () {
              mapController.animateCamera(CameraUpdate.zoomIn());
            },
            icon: Icon(
              CupertinoIcons.minus,
              color: AppColors.purpleColor,
            ),
          ),
        ],
      ),
    );
  }
}
