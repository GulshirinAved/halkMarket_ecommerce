part of 'get_all_brands_bloc.dart';

sealed class GetAllBrandsEvent extends Equatable {
  const GetAllBrandsEvent();

  @override
  List<Object> get props => [];
}

class GetAllBrandsList extends GetAllBrandsEvent {
  const GetAllBrandsList();
  @override
  List<Object> get props => [];
}

class GetMoreBrand extends GetAllBrandsEvent {}
