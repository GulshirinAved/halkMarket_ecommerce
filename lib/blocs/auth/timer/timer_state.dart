part of 'timer_bloc.dart';

sealed class TimerState extends Equatable {
  const TimerState();

  @override
  List<Object> get props => [];
}

final class TimerInitial extends TimerState {
  final int duration;

  const TimerInitial({required this.duration});
  @override
  List<Object> get props => [duration];
}

class TimerRunning extends TimerState {
  final int remainingTime;

  const TimerRunning({required this.remainingTime});

  @override
  List<Object> get props => [remainingTime];
}

class TimerFinished extends TimerState {}
