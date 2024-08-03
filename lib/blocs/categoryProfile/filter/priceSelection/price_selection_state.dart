// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'price_selection_bloc.dart';

class PriceSelectionState extends Equatable {
  final String selectedPrice;
  const PriceSelectionState({required this.selectedPrice});

  @override
  List<Object> get props => [selectedPrice];

  PriceSelectionState copyWith({
    String? selectedPrice,
  }) {
    return PriceSelectionState(
      selectedPrice: selectedPrice ?? this.selectedPrice,
    );
  }
}
