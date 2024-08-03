// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'price_selection_bloc.dart';

abstract class PriceSelectionEvent extends Equatable {
  const PriceSelectionEvent();

  @override
  List<Object> get props => [];
}

class ChoosePriceEvent extends PriceSelectionEvent {
  final String pressedTitle;

  const ChoosePriceEvent({required this.pressedTitle});
  @override
  List<Object> get props => [pressedTitle];
}

class ApplyPriceEvent extends PriceSelectionEvent {
  const ApplyPriceEvent();

  @override
  List<Object> get props => [];
}

class CleanPriceEvent extends PriceSelectionEvent {
  const CleanPriceEvent();

  @override
  List<Object> get props => [];
}
