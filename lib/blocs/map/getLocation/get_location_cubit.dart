import 'package:bloc/bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:halkmarket_ecommerce/blocs/map/getLocation/get_location_state.dart';
import 'package:latlong2/latlong.dart';

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

  Future<void> _initializeLocation() async {
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
  }

  Future<void> toggleLocation() async {
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

  Future<void> onMapTap(LatLng latLng) async {
    if (state.showCurrentLocation == 0) {
      emit(state.copyWith(showCurrentLocation: 1));
      final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (serviceEnabled) {
        await _getAddressFromLatLng(latLng.latitude, latLng.longitude);
        emit(
          state.copyWith(
            location: latLng,
          ),
        );
      }
    }
  }

  void deliverButtonPressed() {
    emit(state.copyWith(showCurrentLocation: 2));
  }
}
