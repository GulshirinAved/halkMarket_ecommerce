import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:halkmarket_ecommerce/data/api_repositories/auth_repository.dart';
import 'package:halkmarket_ecommerce/data/models/updateUserData_model.dart';

part 'update_user_data_event.dart';
part 'update_user_data_state.dart';

class UpdateUserDataBloc
    extends Bloc<UpdateUserDataEvent, UpdateUserDataState> {
  final AuthRepository updateUserDataRepository = AuthRepository();
  UpdateUserDataBloc() : super(UpdateUserDataInitial()) {
    on<UpdateUserDataSubmitted>((event, emit) async {
      try {
        final userData = await updateUserDataRepository.updateUserData(
          name: event.name,
          email: event.email,
          phone: event.phone,
          birthday: event.birthday,
          gender: event.gender,
        );

        emit(UpdateUserDataLoaded(userData: userData));
      } catch (e) {
        emit(UpdateUserDataFailure(error: e.toString()));
      }
    });
  }
}
