// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'save_otp_input_bloc.dart';

sealed class SaveOtpInputEvent extends Equatable {
  const SaveOtpInputEvent();

  @override
  List<Object> get props => [];
}

class AddCodeEvent extends SaveOtpInputEvent {
  final String otpCode;
  const AddCodeEvent({
    required this.otpCode,
  });
}

class RemoveCodeEvent extends SaveOtpInputEvent {
  final String otpCode;
  const RemoveCodeEvent({
    required this.otpCode,
  });
}
