// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'save_otp_input_bloc.dart';

sealed class SaveOtpInputEvent extends Equatable {
  const SaveOtpInputEvent();

  @override
  List<Object> get props => [];
}

class AddCodeEvent extends SaveOtpInputEvent {
  final String otpCode;
  final int index;

  const AddCodeEvent({required this.otpCode, required this.index});
}

class RemoveCodeEvent extends SaveOtpInputEvent {
  final int index;

  const RemoveCodeEvent({required this.index});
}
