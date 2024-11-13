import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'save_otp_input_event.dart';
part 'save_otp_input_state.dart';

class SaveOtpInputBloc extends Bloc<SaveOtpInputEvent, SaveOtpInputState> {
  SaveOtpInputBloc() : super(const SaveOtpInputState('')) {
    final List<String> otpList = List.filled(4, '');

    on<AddCodeEvent>((event, emit) {
      otpList[event.index] = event.otpCode;
      final String otpString = otpList.join('');
      log(otpList.toString());
      emit(SaveOtpInputState(otpString));
    });

    on<RemoveCodeEvent>((event, emit) {
      otpList[event.index] = '';
      final String otpString = otpList.join('');
      emit(SaveOtpInputState(otpString));
    });
  }
}
