import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'save_otp_input_event.dart';
part 'save_otp_input_state.dart';

class SaveOtpInputBloc extends Bloc<SaveOtpInputEvent, SaveOtpInputState> {
  SaveOtpInputBloc() : super(SaveOtpInputState('')) {
    final List otpList = [];

    on<AddCodeEvent>((event, emit) {
      otpList.add(event.otpCode);
      String otpString = otpList.join('');
      emit(SaveOtpInputState(otpString));
    });
    on<RemoveCodeEvent>((event, emit) {
      otpList.removeLast();
      String otpString = otpList.join('');
      emit(SaveOtpInputState(otpString));
    });
  }
}
