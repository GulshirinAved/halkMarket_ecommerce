part of 'forget_pass_bloc.dart';

sealed class ForgetPassEvent extends Equatable {
  const ForgetPassEvent();

  @override
  List<Object> get props => [];
}

class ForgetPassSubmitted extends ForgetPassEvent {
  final String? phoneNumber;
  final String? password;

  const ForgetPassSubmitted(
      {required this.phoneNumber, required this.password});
  @override
  List<Object> get props => [phoneNumber ?? '', password ?? ''];
}

class ResetForgetPass extends ForgetPassEvent {}
