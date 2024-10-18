part of 'get_all_products_bloc.dart';

sealed class GetAllProductsState extends Equatable {
  const GetAllProductsState();

  @override
  List<Object> get props => [];
}

final class GetAllProductsInitial extends GetAllProductsState {}

final class GetAllProductsloading extends GetAllProductsState {}

final class GetAllProductsLoaded extends GetAllProductsState {
  final List getAllProductsList;

  const GetAllProductsLoaded({required this.getAllProductsList});
  @override
  List<Object> get props => [getAllProductsList];
}

final class GetAllProductsError extends GetAllProductsState {
  final String error;

  const GetAllProductsError({required this.error});
}
