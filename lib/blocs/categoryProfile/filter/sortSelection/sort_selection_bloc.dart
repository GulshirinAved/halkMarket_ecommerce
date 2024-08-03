import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:halkmarket_ecommerce/config/constants/constants.dart';

part 'sort_selection_event.dart';
part 'sort_selection_state.dart';

class SortSelectionBloc extends Bloc<SortSelectionEvent, SortSelectionState> {
  String sort = sortTitle[0];
  SortSelectionBloc() : super(SortSelectionState(selectedTitle: sortTitle[0])) {
    on<ChooseSortTitleEvent>((event, emit) {
      emit(state.copyWith(selectedTitle: event.pressedTitle));
    });
    on<ApplySortEvent>((event, emit) {
      sort = state.selectedTitle;
      emit(state.copyWith(selectedTitle: sort));
    });
    on<CleanSortEvent>((event, emit) {
      emit(state.copyWith(selectedTitle: sortTitle[0]));
    });
  }
}
