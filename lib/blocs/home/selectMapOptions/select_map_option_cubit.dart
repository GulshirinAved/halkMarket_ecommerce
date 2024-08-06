import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'select_map_option_state.dart';

class SelectMapOptionCubit extends Cubit<SelectMapOptionState> {
  SelectMapOptionCubit() : super(SelectMapOptionState(selectedIndex: -1));
  void selectCard(int index) {
    emit(SelectMapOptionState(selectedIndex: index));
  }
}
