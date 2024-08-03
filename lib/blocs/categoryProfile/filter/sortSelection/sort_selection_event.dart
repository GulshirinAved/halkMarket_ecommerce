part of 'sort_selection_bloc.dart';

abstract class SortSelectionEvent extends Equatable {
  const SortSelectionEvent();

  @override
  List<Object> get props => [];
}

class ChooseSortTitleEvent extends SortSelectionEvent {
  final String pressedTitle;

  const ChooseSortTitleEvent({required this.pressedTitle});

  @override
  List<Object> get props => [pressedTitle];
}

class ApplySortEvent extends SortSelectionEvent {
  const ApplySortEvent();

  @override
  List<Object> get props => [];
}

class CleanSortEvent extends SortSelectionEvent {
  const CleanSortEvent();

  @override
  List<Object> get props => [];
}
