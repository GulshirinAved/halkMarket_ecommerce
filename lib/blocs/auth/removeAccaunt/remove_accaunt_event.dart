part of 'remove_accaunt_bloc.dart';

sealed class RemoveAccauntEvent extends Equatable {
  const RemoveAccauntEvent();

  @override
  List<Object> get props => [];
}

final class RemoveAccauntSubmitted extends RemoveAccauntEvent {}
