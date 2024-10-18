part of 'update_user_data_bloc.dart';

sealed class UpdateUserDataEvent extends Equatable {
  const UpdateUserDataEvent();

  @override
  List<Object> get props => [];
}

class UpdateUserDataSubmitted extends UpdateUserDataEvent {
  final String? name;
  final String? email;
  final String? phone;
  final String? birthday;
  final String? gender;

  const UpdateUserDataSubmitted({
    required this.name,
    required this.email,
    required this.phone,
    required this.birthday,
    required this.gender,
  });
  @override
  List<Object> get props =>
      [name ?? '', phone ?? '', email ?? '', birthday ?? '', gender ?? ''];
}
