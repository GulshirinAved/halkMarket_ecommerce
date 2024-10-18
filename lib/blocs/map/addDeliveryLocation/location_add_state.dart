part of 'location_add_bloc.dart';

sealed class LocationAddState extends Equatable {
  final List<Map<String, dynamic>> savedLocation;
  final String selectedRadioValue;

  const LocationAddState({
    required this.savedLocation,
    this.selectedRadioValue = '',
  });

  @override
  List<Object> get props => [
        savedLocation,
        selectedRadioValue,
      ];
}

final class LocationAddInitial extends LocationAddState {
  const LocationAddInitial({
    required super.savedLocation,
    super.selectedRadioValue,
  });
}

final class SaveAddressState extends LocationAddState {
  const SaveAddressState({
    required super.savedLocation,
    required super.selectedRadioValue,
  });
}
