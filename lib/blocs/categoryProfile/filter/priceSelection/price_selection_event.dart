// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'price_selection_bloc.dart';

class PriceSelectionEvent extends Equatable {
  final String pressedTitle;
  const PriceSelectionEvent({
    required this.pressedTitle,
  });

  @override
  List<Object> get props => [pressedTitle];
}
