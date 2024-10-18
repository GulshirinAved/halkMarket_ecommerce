part of 'get_all_brands_bloc.dart';

sealed class GetAllBrandsState extends Equatable {
  const GetAllBrandsState();

  @override
  List<Object> get props => [];
}

final class GetAllBrandsInitial extends GetAllBrandsState {}

final class GetAllBrandsLoading extends GetAllBrandsState {}

final class GetAllBrandsLoaded extends GetAllBrandsState {
  final List<dynamic> allBrandsList;

  const GetAllBrandsLoaded({required this.allBrandsList});
  @override
  List<Object> get props => [allBrandsList];
}

final class GetAllBrandsError extends GetAllBrandsState {
  final String? error;

  const GetAllBrandsError({required this.error});
  @override
  List<Object> get props => [error ?? ''];
}
