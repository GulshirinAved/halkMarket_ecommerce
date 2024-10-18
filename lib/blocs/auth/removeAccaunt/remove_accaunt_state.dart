part of 'remove_accaunt_bloc.dart';

sealed class RemoveAccauntState extends Equatable {
  const RemoveAccauntState();

  @override
  List<Object> get props => [];
}

final class RemoveAccauntInitial extends RemoveAccauntState {}

final class RemoveAccauntSuccess extends RemoveAccauntState {}

final class RemoveAccauntFailure extends RemoveAccauntState {}
