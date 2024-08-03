import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'price_selection_event.dart';
part 'price_selection_state.dart';

class PriceSelectionBloc
    extends Bloc<PriceSelectionEvent, PriceSelectionState> {
  PriceSelectionBloc() : super(const PriceSelectionState(selectedPrice: '')) {
    on<PriceSelectionEvent>((event, emit) {
      emit(state.copyWith(selectedPrice: event.pressedTitle));
    });
  }
}
