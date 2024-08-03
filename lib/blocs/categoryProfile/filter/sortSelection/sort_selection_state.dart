// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sort_selection_bloc.dart';

class SortSelectionState extends Equatable {
  final String selectedTitle;
  const SortSelectionState({
    required this.selectedTitle,
  });

  @override
  List<Object> get props => [selectedTitle];

  SortSelectionState copyWith({
    String? selectedTitle,
  }) {
    return SortSelectionState(
      selectedTitle: selectedTitle ?? this.selectedTitle,
    );
  }
}
