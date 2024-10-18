part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginSubmitted extends LoginEvent {
  final String? phoneNumber;
  final String? password;

  const LoginSubmitted({required this.phoneNumber, required this.password});
  @override
  List<Object> get props => [phoneNumber ?? '', password ?? ''];
}

class ResetLogin extends LoginEvent {
  const ResetLogin();
}
