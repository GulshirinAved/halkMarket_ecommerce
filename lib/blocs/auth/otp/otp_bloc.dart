import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:halkmarket_ecommerce/data/api_repositories/auth_repository.dart';

part 'otp_event.dart';
part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final AuthRepository authRepository = AuthRepository();

  OtpBloc() : super(OtpInitial()) {
    on<SendOtp>(_onSendOtp);
  }

  Future<void> _onSendOtp(SendOtp event, Emitter<OtpState> emit) async {
    emit(OtpLoading());

    try {
      final statusCode =
          await authRepository.otp(phone: event.phone, otp: event.otp);
      if (statusCode == 200 || statusCode == 201) {
        emit(OtpSuccess(statusCode: statusCode!));
      } else if (statusCode == 603) {
        emit(OtpFailure(statusCode: statusCode!));
      } else if (statusCode == 602) {
        emit(OtpFailure(statusCode: statusCode!));
      }
    } catch (error) {
      throw Exception(error);
    }
  }
}
