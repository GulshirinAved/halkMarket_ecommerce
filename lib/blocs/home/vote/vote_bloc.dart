import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:halkmarket_ecommerce/data/api_repositories/quiz_repository.dart';

part 'vote_event.dart';
part 'vote_state.dart';

class VoteBloc extends Bloc<VoteEvent, VoteState> {
  final QuizRepository voteRepository = QuizRepository();
  VoteBloc() : super(VoteInitial()) {
    on<VoteAnswer>((event, emit) async {
      try {
        final bool voteState = await voteRepository.vote(id: event.id);
        if (voteState == true) {
          emit(VoteSucess());
        } else {
          emit(VoteError());
        }
      } catch (e) {
        emit(VoteError());
      }
    });
  }
}
