import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'price_selection_event.dart';
part 'price_selection_state.dart';

class PriceSelectionBloc
    extends Bloc<PriceSelectionEvent, PriceSelectionState> {
  String price = '';
  PriceSelectionBloc() : super(const PriceSelectionState(selectedPrice: '')) {
    on<ChoosePriceEvent>((event, emit) {
      emit(state.copyWith(selectedPrice: event.pressedTitle));
    });
    on<ApplyPriceEvent>((event, emit) {
      price = state.selectedPrice;
      emit(state.copyWith(selectedPrice: price));
    });
    on<CleanPriceEvent>((event, emit) {
      emit(state.copyWith(selectedPrice: ''));
    });
  }
}
