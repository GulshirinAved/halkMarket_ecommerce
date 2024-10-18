part of 'dot_indicator_bloc.dart';

class DotIndicatorEvent extends Equatable {
  final int pressedIndex;
  const DotIndicatorEvent(this.pressedIndex);

  @override
  List<Object> get props => [pressedIndex];
}
