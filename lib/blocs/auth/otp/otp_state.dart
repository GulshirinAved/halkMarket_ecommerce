part of 'otp_bloc.dart';

// bloc/otp_state.dart

abstract class OtpState extends Equatable {
  const OtpState();

  @override
  List<Object> get props => [];
}

class OtpInitial extends OtpState {}

class OtpLoading extends OtpState {}

class OtpSuccess extends OtpState {
  final int statusCode;

  const OtpSuccess({required this.statusCode});
}

class OtpFailure extends OtpState {
  final int statusCode;

  const OtpFailure({required this.statusCode});

  @override
  List<Object> get props => [statusCode];
}
