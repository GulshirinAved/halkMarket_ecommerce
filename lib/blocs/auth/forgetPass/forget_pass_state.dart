part of 'forget_pass_bloc.dart';

sealed class ForgetPassState extends Equatable {
  const ForgetPassState();

  @override
  List<Object> get props => [];
}

final class ForgetPassInitial extends ForgetPassState {}

final class ForgetPassLoaded extends ForgetPassState {
  final int statusCode;

  const ForgetPassLoaded({required this.statusCode});
  @override
  List<Object> get props => [statusCode];
}

final class ForgetPassFailure extends ForgetPassState {
  final int statusCode;

  const ForgetPassFailure({required this.statusCode});
  @override
  List<Object> get props => [statusCode];
}
