// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'save_otp_input_bloc.dart';

class SaveOtpInputState extends Equatable {
  final String? otpCode;
  const SaveOtpInputState(
    this.otpCode,
  );

  @override
  List<Object> get props => [otpCode ?? ''];

  SaveOtpInputState copyWith({
    String? otpCode,
  }) {
    return SaveOtpInputState(
      otpCode ?? this.otpCode,
    );
  }
}
