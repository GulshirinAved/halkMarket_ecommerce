// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'dot_indicator_bloc.dart';

class DotIndicatorState extends Equatable {
  final int selectedIndex;
  const DotIndicatorState(
    this.selectedIndex,
  );

  @override
  List<Object> get props => [selectedIndex];

  DotIndicatorState copyWith({
    int? selectedIndex,
  }) {
    return DotIndicatorState(
      selectedIndex ?? this.selectedIndex,
    );
  }
}
