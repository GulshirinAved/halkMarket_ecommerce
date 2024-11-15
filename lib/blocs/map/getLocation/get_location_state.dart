import 'package:maplibre_gl/maplibre_gl.dart';

class LocationState {
  final LatLng? location;
  final int showCurrentLocation;
  final String address;

  LocationState({
    required this.location,
    required this.showCurrentLocation,
    required this.address,
  });

  LocationState copyWith({
    LatLng? location,
    int? showCurrentLocation,
    String? address,
    Symbol? lastSymbol,
  }) {
    return LocationState(
      location: location ?? this.location,
      showCurrentLocation: showCurrentLocation ?? this.showCurrentLocation,
      address: address ?? this.address,
    );
  }
}
