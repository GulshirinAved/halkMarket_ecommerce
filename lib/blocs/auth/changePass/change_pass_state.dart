part of 'change_pass_bloc.dart';

sealed class ChangePassState extends Equatable {
  const ChangePassState();

  @override
  List<Object> get props => [];
}

final class ChangePassInitial extends ChangePassState {}

final class ChangePassLoaded extends ChangePassState {
  final Data userData;
  const ChangePassLoaded({required this.userData});
  @override
  List<Object> get props => [userData];
}

final class ChangePassFailure extends ChangePassState {
  final String error;

  const ChangePassFailure({required this.error});
}
