part of 'get_one_product_bloc.dart';

sealed class GetOneProductState extends Equatable {
  const GetOneProductState();

  @override
  List<Object> get props => [];
}

final class GetOneProductInitial extends GetOneProductState {}

final class GetOneProductLoading extends GetOneProductState {}

final class GetOneProductLoaded extends GetOneProductState {
  final Data getOneProductList;

  const GetOneProductLoaded({required this.getOneProductList});
  @override
  List<Object> get props => [getOneProductList];
}

final class GetOneProductError extends GetOneProductState {
  final String? error;

  const GetOneProductError({required this.error});
  @override
  List<Object> get props => [error ?? ''];
}
