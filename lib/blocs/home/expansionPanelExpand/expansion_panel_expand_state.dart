part of 'expansion_panel_expand_bloc.dart';

class ExpansionPanelExpandState extends Equatable {
  final int activePanelIndex;
  const ExpansionPanelExpandState({required this.activePanelIndex});

  @override
  List<Object> get props => [activePanelIndex];
}
