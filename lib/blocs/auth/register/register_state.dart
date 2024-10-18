part of 'register_bloc.dart';

sealed class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

final class RegisterInitial extends RegisterState {}

final class RegisterLoaded extends RegisterState {
  final int statusCode;

  const RegisterLoaded({required this.statusCode});
  @override
  List<Object> get props => [statusCode];
}

final class RegisterFailure extends RegisterState {
  final int statusCode;

  const RegisterFailure({required this.statusCode});
  @override
  List<Object> get props => [statusCode];
}
