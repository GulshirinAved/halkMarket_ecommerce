part of 'sort_selection_bloc.dart';

class SortSelectionEvent extends Equatable {
  final String pressedTitle;
  const SortSelectionEvent({required this.pressedTitle});

  @override
  List<Object> get props => [pressedTitle];
}
