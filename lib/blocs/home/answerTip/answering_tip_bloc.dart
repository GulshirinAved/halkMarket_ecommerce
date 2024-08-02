import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'answering_tip_event.dart';
part 'answering_tip_state.dart';

class AnsweringTipBloc extends Bloc<AnsweringTipEvent, AnsweringTipState> {
  AnsweringTipBloc() : super(const AnsweringTipState(selectedTip: '')) {
    on<AnsweringTipEvent>((event, emit) {
      emit(state.copyWith(selectedTip: event.pressedTip));
    });
  }
}
