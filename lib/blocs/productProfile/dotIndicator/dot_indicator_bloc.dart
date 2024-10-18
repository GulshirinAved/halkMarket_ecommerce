import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'dot_indicator_event.dart';
part 'dot_indicator_state.dart';

class DotIndicatorBloc extends Bloc<DotIndicatorEvent, DotIndicatorState> {
  DotIndicatorBloc() : super(DotIndicatorState(0)) {
    on<DotIndicatorEvent>((event, emit) {
      emit(state.copyWith(selectedIndex: event.pressedIndex));
    });
  }
}
