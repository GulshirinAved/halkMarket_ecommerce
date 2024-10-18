part of 'update_user_data_bloc.dart';

sealed class UpdateUserDataState extends Equatable {
  const UpdateUserDataState();

  @override
  List<Object> get props => [];
}

final class UpdateUserDataInitial extends UpdateUserDataState {}

final class UpdateUserDataLoaded extends UpdateUserDataState {
  final Data userData;

  const UpdateUserDataLoaded({required this.userData});
  @override
  List<Object> get props => [userData];
}

final class UpdateUserDataFailure extends UpdateUserDataState {
  final String error;

  const UpdateUserDataFailure({required this.error});
  @override
  List<Object> get props => [error];
}
