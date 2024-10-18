import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:halkmarket_ecommerce/data/api_providers/auth_provider.dart';
import 'package:halkmarket_ecommerce/data/models/updateUserData_model.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final AuthProvider userProfileProvider = AuthProvider();
  UserProfileBloc() : super(UserProfileInitial()) {
    on<GetUserData>((event, emit) async {
      try {
        final Data userData = await userProfileProvider.getUserProfile();
        emit(UserProfileLoaded(userData: userData));
      } catch (e) {
        emit(UserProfileError(error: e.toString()));
      }
    });
  }
}
