part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterSubmitted extends RegisterEvent {
  final String? phoneNumber;
  final String? password;

  const RegisterSubmitted({required this.phoneNumber, required this.password});
  @override
  List<Object> get props => [phoneNumber ?? '', password ?? ''];
}

class ResetRegister extends RegisterEvent {}
