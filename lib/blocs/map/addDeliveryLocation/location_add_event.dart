// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'location_add_bloc.dart';

sealed class LocationAddEvent extends Equatable {
  final String? address;
  final String? apartment;
  final String? entrance;
  final String? floor;
  final String? comment;
  final String? id;

  const LocationAddEvent({
    this.address,
    this.apartment,
    this.entrance,
    this.floor,
    this.comment,
    this.id,
  });

  @override
  List<Object> get props => [
        address ?? '',
        apartment ?? '',
        entrance ?? '',
        floor ?? '',
        comment ?? '',
        id ?? '',
      ];
}

final class SaveAddressEvent extends LocationAddEvent {
  const SaveAddressEvent({
    super.address,
    super.apartment,
    super.entrance,
    super.floor,
    super.comment,
  });
}

final class ShowSavedLocationEvent extends LocationAddEvent {
  const ShowSavedLocationEvent();
}

class ToggleAddressEvent extends LocationAddEvent {
  final String selectedValue;
  const ToggleAddressEvent({
    required this.selectedValue,
  });
}

class RemoveAddressEvent extends LocationAddEvent {
  const RemoveAddressEvent({
    required super.address,
    required super.apartment,
    required super.entrance,
    required super.floor,
    required super.id,
  });
}
