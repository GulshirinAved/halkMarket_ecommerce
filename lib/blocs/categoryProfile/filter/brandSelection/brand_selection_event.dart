part of 'brand_selection_bloc.dart';

sealed class BrandSelectionEvent extends Equatable {
  const BrandSelectionEvent();

  @override
  List<Object> get props => [];
}

class ChooseBrandEvent extends BrandSelectionEvent {
  final String pressedBrandName;

  const ChooseBrandEvent({required this.pressedBrandName});
}