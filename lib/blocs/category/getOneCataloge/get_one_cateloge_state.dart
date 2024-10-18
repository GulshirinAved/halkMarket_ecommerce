part of 'get_one_cateloge_bloc.dart';

sealed class GetOneCatelogeState extends Equatable {
  const GetOneCatelogeState();

  @override
  List<Object> get props => [];
}

final class GetOneCatelogeInitial extends GetOneCatelogeState {}

final class GetOneCatalogeLoading extends GetOneCatelogeState {}

final class GetOneCatalogeLoaded extends GetOneCatelogeState {
  final Data getOneCatalogeList;

  const GetOneCatalogeLoaded({required this.getOneCatalogeList});
  @override
  List<Object> get props => [getOneCatalogeList];
}

final class GetOneCatalogeError extends GetOneCatelogeState {
  final String? error;

  const GetOneCatalogeError({required this.error});
  @override
  List<Object> get props => [error ?? ''];
}
