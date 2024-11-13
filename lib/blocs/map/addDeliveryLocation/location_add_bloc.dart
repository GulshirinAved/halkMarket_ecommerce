import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geocode/geocode.dart';
import 'package:halkmarket_ecommerce/data/api_providers/auth_provider.dart';
import 'package:halkmarket_ecommerce/data/api_repositories/auth_repository.dart';
import 'package:halkmarket_ecommerce/data/api_repositories/userAddress_repository.dart';
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
      try {
        // Get coordinates
        final GeoCode geoCode = GeoCode();
        final coordinates = await geoCode.forwardGeocoding(
          address: event.address.toString(),
        );

        final newAddress = {
          'address': event.address,
          'apartment': event.apartment,
          'entrance': event.entrance,
          'floor': event.floor,
          'comment': event.comment,
          'latitude': coordinates.latitude?.toString() ?? '0.0',
          'longitude': coordinates.longitude?.toString() ?? '0.0',
        };

        // Get current list and check for duplicates
        final List<Map<String, dynamic>> currentList =
            List<Map<String, dynamic>>.from(
          addressBox.get('addressBox', defaultValue: <Map<String, dynamic>>[]),
        );

        if (!_addressExists(currentList, newAddress)) {
          // Add to local storage
          currentList.add(newAddress);
          await addressBox.put('addressBox', currentList);

          // Sync with backend if logged in
          if (token != null) {
            await userAddressRepository.addAddress(
              id: '',
              address: event.address ?? '',
              apartment: event.apartment ?? '',
              entrance: event.entrance ?? '',
              floor: event.floor ?? '',
              comment: event.comment ?? '',
              latitude: newAddress['latitude']!,
              longitude: newAddress['longitude']!,
            );
          }

          // Emit new state with updated list
          emit(
            SaveAddressState(
              savedLocation: currentList,
              selectedRadioValue:
                  addressBox.get('selectedAddress', defaultValue: ''),
            ),
          );
        }
      } catch (e) {
        print('Error saving address: $e');
        // Consider emitting an error state here
      }
    });

    on<ShowSavedLocationEvent>((event, emit) async {
      try {
        List<Map<String, dynamic>> locationList;

        if (token != null) {
          // Get from backend if logged in
          final addressData = await authRepository.getUserProfile();
          locationList = addressData.address
                  ?.map((address) => address.toJson())
                  .toList() ??
              [];
          // Update local storage with backend data
          await addressBox.put('addressBox', locationList);
        } else {
          // Get from local storage if not logged in
          locationList = List<Map<String, dynamic>>.from(
            addressBox
                .get('addressBox', defaultValue: <Map<String, dynamic>>[]),
          );
        }

        emit(
          SaveAddressState(
            savedLocation: locationList,
            selectedRadioValue:
                addressBox.get('selectedAddress', defaultValue: ''),
          ),
        );
      } catch (e) {
        print('Error loading addresses: $e');
        // Consider emitting an error state here
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

      emit(
        SaveAddressState(
          savedLocation: state.savedLocation,
          selectedRadioValue:
              addressBox.get('selectedAddress', defaultValue: ''),
        ),
      );
    });
  }
  bool _addressExists(
    List<Map<String, dynamic>> list,
    Map<String, dynamic> newAddress,
  ) {
    return list.any(
      (item) =>
          item['address'] == newAddress['address'] &&
          item['apartment'] == newAddress['apartment'] &&
          item['entrance'] == newAddress['entrance'] &&
          item['floor'] == newAddress['floor'],
    );
  }
}
