part of 'change_pass_bloc.dart';

sealed class ChangePassEvent extends Equatable {
  const ChangePassEvent();

  @override
  List<Object> get props => [];
}

final class SubmitChanges extends ChangePassEvent {
  final String? oldPass;
  final String? newPass;

  const SubmitChanges({required this.oldPass, required this.newPass});
  @override
  List<Object> get props => [oldPass ?? '', newPass ?? ''];
}
