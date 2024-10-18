part of 'otp_bloc.dart';

// bloc/otp_event.dart

abstract class OtpEvent extends Equatable {
  const OtpEvent();

  @override
  List<Object> get props => [];
}

class SendOtp extends OtpEvent {
  final String phone;
  final int otp;

  const SendOtp(this.phone, this.otp);

  @override
  List<Object> get props => [phone, otp];
}
