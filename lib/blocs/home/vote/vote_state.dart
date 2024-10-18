part of 'vote_bloc.dart';

sealed class VoteState extends Equatable {
  const VoteState();

  @override
  List<Object> get props => [];
}

final class VoteInitial extends VoteState {}

final class VoteSucess extends VoteState {}

final class VoteError extends VoteState {}
