import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geocode/geocode.dart';
import 'package:halkmarket_ecommerce/data/api_providers/auth_provider.dart';
import 'package:halkmarket_ecommerce/data/api_repositories/auth_repository.dart';
import 'package:halkmarket_ecommerce/data/api_repositories/userAddress_repository.dart';
import 'package:halkmarket_ecommerce/data/models/updateUserData_model.dart';
import 'package:hive/hive.dart';

part 'location_add_event.dart';
part 'location_add_state.dart';

class LocationAddBloc extends Bloc<LocationAddEvent, LocationAddState> {
  final Box addressBox = Hive.box('addressBox');

  String? token = AuthProvider().getAccessToken();
  final UserAddressRepository userAddressRepository = UserAddressRepository();
  final AuthRepository authRepository = AuthRepository();

  LocationAddBloc()
      : super(
          SaveAddressState(
            savedLocation: List<Map<String, dynamic>>.from(
              (Hive.box('addressBox').get(
                'addressBox',
                defaultValue: <Map<String, dynamic>>[],
              ) as List)
                  .map((item) => Map<String, dynamic>.from(item))
                  .toList(),
            ),
            selectedRadioValue:
                Hive.box('addressBox').get('selectedAddress', defaultValue: ''),
          ),
        ) {
    on<SaveAddressEvent>((event, emit) async {
      final GeoCode geoCode = GeoCode();
      double latitude = 0.0;
      double longitude = 0.0;

      try {
        final Coordinates coordinates = await geoCode.forwardGeocoding(
          address: event.address.toString(),
        );
        latitude = coordinates.latitude ?? 0;
        longitude = coordinates.longitude ?? 0;
      } catch (e) {
        print('Failed to get coordinates: $e');
      }

      final List<Map<String, dynamic>> currentList =
          List<Map<String, dynamic>>.from(
        (addressBox.get('addressBox', defaultValue: <Map<String, dynamic>>[])
                as List)
            .map((item) => Map<String, dynamic>.from(item)),
      );

      final newAddress = {
        'address': event.address,
        'apartment': event.apartment,
        'entrance': event.entrance,
        'floor': event.floor,
        'comment': event.comment,
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
      };

// Check if the address already exists in the list
      final bool addressExists = currentList.any(
        (item) =>
            item['address'] == event.address &&
            item['apartment'] == event.apartment &&
            item['entrance'] == event.entrance &&
            item['floor'] == event.floor &&
            item['comment'] == event.comment,
      );

      if (!addressExists) {
        currentList.add(newAddress);
        await addressBox.put('addressBox', currentList);

// Check if token is available
        if (token != null) {
          try {
            await userAddressRepository.addAddress(
              id: '',
              address: event.address ?? '',
              apartment: event.apartment ?? '',
              entrance: event.entrance ?? '',
              floor: event.floor ?? '',
              comment: event.comment ?? '',
              latitude: latitude.toString(),
              longitude: longitude.toString(),
            );
          } catch (e) {
// Handle error
            print('Failed to save address to backend: $e');
          }
        }
      }
    });

    on<ShowSavedLocationEvent>((event, emit) async {
      if (token != null) {
        final Data addressData = await authRepository.getUserProfile();
        final locationList = addressData.address!;
        final List<Map<String, dynamic>> locationMapList =
            locationList.map((address) => address.toJson()).toList();
        await addressBox.put('addressBox', locationMapList);
        log('it is showSavedLocEvent${addressBox.get('selectedAddress', defaultValue: '')}');
        emit(
          SaveAddressState(
            savedLocation: locationMapList,
            selectedRadioValue:
                addressBox.get('selectedAddress', defaultValue: ''),
          ),
        );
      } else {
        emit(
          SaveAddressState(
            savedLocation: List<Map<String, dynamic>>.from(
              (addressBox.get(
                'addressBox',
                defaultValue: <Map<String, dynamic>>[],
              ) as List)
                  .map((item) => Map<String, dynamic>.from(item))
                  .toList(),
            ),
            selectedRadioValue: state.selectedRadioValue,
          ),
        );
      }
    });

    on<RemoveAddressEvent>((event, emit) async {
      final List<Map<String, dynamic>> currentList =
          List<Map<String, dynamic>>.from(
        (addressBox.get('addressBox', defaultValue: <Map<String, dynamic>>[])
                as List)
            .map((item) => Map<String, dynamic>.from(item)),
      );

      final newAddress = {
        'address': event.address,
        'apartment': event.apartment,
        'entrance': event.entrance,
        'floor': event.floor,
        'comment': event.comment,
      };

// Custom comparison to find and remove the address
      currentList.removeWhere(
        (item) =>
            item['address'] == newAddress['address'] &&
            item['apartment'] == newAddress['apartment'] &&
            item['entrance'] == newAddress['entrance'] &&
            item['floor'] == newAddress['floor'],
      );

      await addressBox.put('addressBox', currentList);

      final List<Map<String, dynamic>> savedLocation =
          List<Map<String, dynamic>>.from(
        (addressBox.get('addressBox', defaultValue: <Map<String, dynamic>>[])
                as List)
            .map((item) => Map<String, dynamic>.from(item)),
      );

      if (token != null) {
        try {
          await userAddressRepository.removeAddress(
            id: event.id!,
          );
        } catch (e) {
// Handle error
          print('Failed to save address to backend: $e');
        }
      }

      if (addressBox.get('selectedAddress') ==
          '${event.address}, ${event.apartment}') {
        await addressBox.delete('selectedAddress');
      }

      emit(
        SaveAddressState(
          savedLocation: savedLocation,
          selectedRadioValue:
              addressBox.get('selectedAddress', defaultValue: ''),
        ),
      );
    });

    on<ToggleAddressEvent>((event, emit) {
      addressBox.put('selectedAddress', event.selectedValue);
      log('it is toggle ${addressBox.get('selectedAddress', defaultValue: '')}');

      emit(
        SaveAddressState(
          savedLocation: state.savedLocation,
          selectedRadioValue:
              addressBox.get('selectedAddress', defaultValue: ''),
        ),
      );
    });
  }
}
