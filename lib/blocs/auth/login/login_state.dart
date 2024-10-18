part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

final class LoginLoaded extends LoginState {
  final int statusCode;

  const LoginLoaded({required this.statusCode});
  @override
  List<Object> get props => [statusCode];
}

final class LoginFailure extends LoginState {
  final int statusCode;

  const LoginFailure({required this.statusCode});
  @override
  List<Object> get props => [statusCode];
}
