part of 'brand_selection_bloc.dart';

sealed class BrandSelectionState extends Equatable {
  final List<Map<String, dynamic>> brandList;
  const BrandSelectionState({required this.brandList});

  @override
  List<Object> get props => [brandList];
}

final class BrandSelectionInitial extends BrandSelectionState {
  const BrandSelectionInitial({required List<Map<String, dynamic>> brandList})
      : super(brandList: brandList);
}

final class BrandSelectionUpdated extends BrandSelectionState {
  const BrandSelectionUpdated({required List<Map<String, dynamic>> brandList})
      : super(brandList: brandList);
}
