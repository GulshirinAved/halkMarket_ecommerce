part of 'timer_bloc.dart';

sealed class TimerEvent extends Equatable {
  const TimerEvent();

  @override
  List<Object> get props => [];
}

class StartTimer extends TimerEvent {}

class Tick extends TimerEvent {
  final int remainingTime;

  const Tick({required this.remainingTime});
  @override
  List<Object> get props => [remainingTime];
}
