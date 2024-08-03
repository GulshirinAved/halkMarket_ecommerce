import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';

part 'sort_selection_event.dart';
part 'sort_selection_state.dart';

class SortSelectionBloc extends Bloc<SortSelectionEvent, SortSelectionState> {
  SortSelectionBloc() : super(SortSelectionState(selectedTitle: sortTitle[0])) {
    on<SortSelectionEvent>((event, emit) {
      emit(state.copyWith(selectedTitle: event.pressedTitle));
    });
  }
}
