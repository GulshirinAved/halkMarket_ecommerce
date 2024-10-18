part of 'user_profile_bloc.dart';

sealed class UserProfileState extends Equatable {
  const UserProfileState();

  @override
  List<Object> get props => [];
}

final class UserProfileInitial extends UserProfileState {}

final class UserProfileLoaded extends UserProfileState {
  final Data userData;

  const UserProfileLoaded({required this.userData});

  @override
  List<Object> get props => [userData];
}

final class UserProfileError extends UserProfileState {
  final String error;

  const UserProfileError({required this.error});

  @override
  List<Object> get props => [error];
}
