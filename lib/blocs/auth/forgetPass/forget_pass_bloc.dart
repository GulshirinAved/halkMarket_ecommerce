import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:halkmarket_ecommerce/data/api_repositories/auth_repository.dart';

part 'forget_pass_event.dart';
part 'forget_pass_state.dart';

class ForgetPassBloc extends Bloc<ForgetPassEvent, ForgetPassState> {
  ForgetPassBloc() : super(ForgetPassInitial()) {
    final AuthRepository forgetPassRepository = AuthRepository();
    on<ForgetPassSubmitted>((event, emit) async {
      try {
        final int? statusCode = await forgetPassRepository.forgetPass(
          phone: event.phoneNumber,
          password: event.password,
        );
        print(statusCode);
        if (statusCode == 201 || statusCode == 200) {
          emit(ForgetPassLoaded(statusCode: statusCode!));
        } else {
          emit(ForgetPassFailure(statusCode: statusCode!));
        }
      } catch (e) {
        emit(const ForgetPassFailure(statusCode: 600));
      }
    });
    on<ResetForgetPass>(
      (event, emit) {
        emit(ForgetPassInitial());
      },
    );
  }
}
