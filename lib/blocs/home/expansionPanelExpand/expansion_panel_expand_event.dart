part of 'expansion_panel_expand_bloc.dart';

sealed class ExpansionPanelExpandEvent extends Equatable {
  final int panelIndex;
  const ExpansionPanelExpandEvent({required this.panelIndex});

  @override
  List<Object> get props => [panelIndex];
}

class PressEvent extends ExpansionPanelExpandEvent {
  const PressEvent({required super.panelIndex});
}
