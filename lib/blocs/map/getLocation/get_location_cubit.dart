import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:halkmarket_ecommerce/blocs/map/getLocation/get_location_state.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit()
      : super(
          LocationState(
            location: null,
            showCurrentLocation: 0,
            address: '',
          ),
        ) {
    _initializeLocation();
  }
  Symbol? gpsSymbol;
  Future<void> addIcon(MapLibreMapController mapController) async {
    final ByteData bytes = await rootBundle.load('assets/images/gps.png');
    final Uint8List list = bytes.buffer.asUint8List();
    await mapController.addImage('gps', list);
  }

  Future<void> updateIconPosition(
    MapLibreMapController mapController,
    LatLng latLng,
  ) async {
    if (gpsSymbol != null) {
      await mapController.removeSymbol(
        gpsSymbol!,
      );
      gpsSymbol = await mapController.addSymbol(
        SymbolOptions(
          geometry: latLng,
          iconImage: 'gps',
          iconSize: 2.0,
        ),
      );
    } else {
      gpsSymbol = await mapController.addSymbol(
        SymbolOptions(
          geometry: latLng,
          iconImage: 'gps',
          iconSize: 2.0,
        ),
      );
    }
  }

  Future<void> openLocationSettings() async {
    if (await Permission.location.isPermanentlyDenied) {
      await openAppSettings();
    } else {
      await Geolocator.openLocationSettings();
    }
  }

  Future<void> _initializeLocation() async {
    final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await openLocationSettings();
      emit(state.copyWith(location: null));
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      await openLocationSettings();
      emit(state.copyWith(location: null));
      return;
    }

    final Position position = await Geolocator.getCurrentPosition();
    final latLng = LatLng(position.latitude, position.longitude);
    emit(state.copyWith(location: latLng));

    await _getAddressFromLatLng(position.latitude, position.longitude);
  }

  Future<void> toggleLocation(MapLibreMapController mapController) async {
    if (state.showCurrentLocation == 0) {
      emit(state.copyWith(showCurrentLocation: 1));

      final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        emit(state.copyWith(location: null));
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        emit(state.copyWith(location: null));
        return;
      }

      final Position position = await Geolocator.getCurrentPosition();
      final latLng = LatLng(position.latitude, position.longitude);
      emit(state.copyWith(location: latLng));

      await _getAddressFromLatLng(position.latitude, position.longitude);
      await updateIconPosition(mapController, latLng);
    } else {
      emit(state.copyWith(showCurrentLocation: 0, location: null));
    }
  }

  Future<void> _getAddressFromLatLng(double latitude, double longitude) async {
    try {
      final List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isNotEmpty) {
        final placemark = placemarks.first;
        final address =
            '${placemark.country}, ${placemark.locality}, ${placemark.street}';
        emit(state.copyWith(address: address));
      } else {
        emit(state.copyWith(address: 'Unknown Location'));
      }
    } catch (e) {
      emit(state.copyWith(address: 'Failed to get address'));
    }
  }

  Future<void> onMapTap(
    MapLibreMapController mapController,
    LatLng latLng,
  ) async {
    if (state.showCurrentLocation == 0) {
      emit(state.copyWith(showCurrentLocation: 1));
    }
    final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (serviceEnabled) {
      await _getAddressFromLatLng(latLng.latitude, latLng.longitude);
      await updateIconPosition(mapController, latLng);
      emit(state.copyWith(location: latLng));
    }
  }

  void deliverButtonPressed() {
    emit(state.copyWith(showCurrentLocation: 2));
  }
}
