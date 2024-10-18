import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'expansion_panel_expand_event.dart';
part 'expansion_panel_expand_state.dart';

class ExpansionPanelExpandBloc
    extends Bloc<ExpansionPanelExpandEvent, ExpansionPanelExpandState> {
  ExpansionPanelExpandBloc()
      : super(
          const ExpansionPanelExpandState(activePanelIndex: -1),
        ) {
    on<PressEvent>((event, emit) {
      emit(ExpansionPanelExpandState(activePanelIndex: event.panelIndex));
    });
  }
}
