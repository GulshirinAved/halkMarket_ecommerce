part of 'brand_selection_bloc.dart';

sealed class BrandSelectionState extends Equatable {
  final List<Map<String, dynamic>> brandList;
  final List<Map<String, dynamic>> brandIdList;

  const BrandSelectionState(
      {required this.brandList, required this.brandIdList});

  @override
  List<Object> get props => [brandList];
}

final class BrandSelectionInitial extends BrandSelectionState {
  const BrandSelectionInitial({
    required super.brandList,
    required super.brandIdList,
  });
}

final class BrandSelectionUpdated extends BrandSelectionState {
  const BrandSelectionUpdated({
    required super.brandList,
    required super.brandIdList,
  });
}
