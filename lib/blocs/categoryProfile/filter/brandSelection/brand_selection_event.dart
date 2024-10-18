// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'brand_selection_bloc.dart';

sealed class BrandSelectionEvent extends Equatable {
  const BrandSelectionEvent();

  @override
  List<Object> get props => [];
}

class ChooseBrandEvent extends BrandSelectionEvent {
  final String pressedBrandName;
  final String pressedBrandId;

  const ChooseBrandEvent({
    required this.pressedBrandName,
    required this.pressedBrandId,
  });
}

class ApplyBrandEvent extends BrandSelectionEvent {
  const ApplyBrandEvent();
}

class CleanBrandEvent extends BrandSelectionEvent {
  const CleanBrandEvent();
}
