import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:halkmarket_ecommerce/data/api_repositories/auth_repository.dart';
import 'package:halkmarket_ecommerce/data/models/updateUserData_model.dart';
part 'change_pass_event.dart';
part 'change_pass_state.dart';

class ChangePassBloc extends Bloc<ChangePassEvent, ChangePassState> {
  ChangePassBloc() : super(ChangePassInitial()) {
    final AuthRepository changePassRepository = AuthRepository();
    on<SubmitChanges>((event, emit) async {
      try {
        final Data? userData = await changePassRepository.changePass(
          newPass: event.newPass ?? '',
          oldPass: event.newPass ?? '',
        );
        emit(ChangePassLoaded(userData: userData!));
      } catch (e) {
        emit(ChangePassFailure(error: e.toString()));
      }
    });
  }
}
