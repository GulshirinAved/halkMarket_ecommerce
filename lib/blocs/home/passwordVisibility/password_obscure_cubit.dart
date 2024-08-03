import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'password_obscure_state.dart';

class ObscureCubit extends Cubit<ObscureState> {
  ObscureCubit()
      : super(const ObscureState(
            isPasswordObscured: true, isConfirmPasswordObscured: true));

  void togglePasswordObscure() {
    emit(state.copyWith(isPasswordObscured: !state.isPasswordObscured));
  }

  void toggleConfirmPasswordObscure() {
    emit(state.copyWith(
        isConfirmPasswordObscured: !state.isConfirmPasswordObscured));
  }
}
