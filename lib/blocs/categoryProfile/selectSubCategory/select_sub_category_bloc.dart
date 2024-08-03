import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'select_sub_category_event.dart';
part 'select_sub_category_state.dart';

class SelectSubCategoryBloc
    extends Bloc<SelectSubCategoryEvent, SelectSubCategoryState> {
  SelectSubCategoryBloc() : super(const SelectSubCategoryState(index: -1)) {
    on<SelectSubCategoryEvent>((event, emit) {
      emit(state.copyWith(index: event.pressedIndex));
    });
  }
}
