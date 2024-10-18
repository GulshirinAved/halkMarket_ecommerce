part of 'all_category_bloc.dart';

sealed class AllCategoryState extends Equatable {
  const AllCategoryState();

  @override
  List<Object> get props => [];
}

final class AllCategoryInitial extends AllCategoryState {}

final class AllCategoryLoading extends AllCategoryState {}

final class AllCategoryLoaded extends AllCategoryState {
  final List<Rows> allCategoryList;

  const AllCategoryLoaded({required this.allCategoryList});
  @override
  List<Object> get props => [allCategoryList];
}

final class AllCategoryError extends AllCategoryState {
  final String? error;

  const AllCategoryError({required this.error});
  @override
  List<Object> get props => [error ?? ''];
}
