part of 'answering_tip_bloc.dart';

class AnsweringTipEvent extends Equatable {
  final String pressedTip;
  const AnsweringTipEvent({required this.pressedTip});

  @override
  List<Object> get props => [pressedTip];
}
