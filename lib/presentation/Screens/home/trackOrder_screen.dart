import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halkmarket_ecommerce/blocs/map/getLocation/get_location_cubit.dart';
import 'package:halkmarket_ecommerce/blocs/trackOrder/track_order_bloc.dart';
import 'package:halkmarket_ecommerce/config/theme/constants.dart';

import 'package:maplibre_gl/maplibre_gl.dart';

class TrackOrderScreen extends StatefulWidget {
  const TrackOrderScreen({super.key});

  @override
  State<TrackOrderScreen> createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  MapLibreMapController? mapController;
  late TrackOrderBloc _trackOrderBloc;
  late LocationCubit _locationCubit;

  final CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(37.862499, 58.238056),
    zoom: 10.0,
  );
  bool _disposed = false;

  @override
  void initState() {
    super.initState();
    _trackOrderBloc = TrackOrderBloc();
    _locationCubit = LocationCubit();
  }

  @override
  void dispose() {
    _disposed = true;
    _trackOrderBloc.close();
    _locationCubit.close();
    _trackOrderBloc.socketclose();

    super.dispose();
  }

  void _setMapController(MapLibreMapController controller) {
    if (!_disposed) {
      setState(() {
        mapController = controller;
      });
    }
  }

  Future<void> _addSymbolsAndLine(List coordinates) async {
    if (mapController != null) {
      final ByteData bytes =
          await rootBundle.load('assets/images/carImage.png');
      final Uint8List list = bytes.buffer.asUint8List();
      await mapController?.addImage('carImage', list);

      await mapController!.addSymbol(
        SymbolOptions(
          geometry: LatLng(
            coordinates.last['latitude'],
            coordinates.last['longitude'],
          ),
          iconImage: 'carImage',
          iconSize: 2.0,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            BlocConsumer<TrackOrderBloc, TrackOrderState>(
              bloc: _trackOrderBloc,
              listener: (context, state) {
                if (state is TrackOrderNewLocationState) {
                  log('it is newLocation');
                  _addSymbolsAndLine(state.data);
                }
              },
              builder: (context, state) {
                return MapLibreMap(
                  myLocationTrackingMode: MyLocationTrackingMode.tracking,
                  initialCameraPosition: cameraPosition,
                  trackCameraPosition: true,
                  myLocationEnabled: true,
                  styleString:
                      'https://api.maptiler.com/maps/streets-v2/style.json?key=4lFKDjvzydGKRAOqPvTc',
                  onMapCreated: (controller) async {
                    _setMapController(controller);
                  },
                  onStyleLoadedCallback: () async {
                    if (state is TrackOrderNewLocationState) {
                      await _addSymbolsAndLine(
                        state.data,
                      );
                    }
                  },
                );
              },
            ),

            // Back Icon
            Positioned(
              left: 20,
              top: 40,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
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
          ],
        ),
      ),
    );
  }
}
