part of 'vote_bloc.dart';

sealed class VoteEvent extends Equatable {
  const VoteEvent();

  @override
  List<Object> get props => [];
}

final class VoteAnswer extends VoteEvent {
  final String id;

  const VoteAnswer({required this.id});
  @override
  List<Object> get props => [id];
}
