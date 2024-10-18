import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  static const int _initialDuration = 5 * 60; // 5 minutes in seconds
  Timer? _timer;

  TimerBloc() : super(TimerInitial(duration: _initialDuration)) {
    on<StartTimer>(_onStartTimer);
    on<Tick>(_onTick);
  }

  void _onStartTimer(StartTimer event, Emitter<TimerState> emit) {
    _startTimer();
    emit(TimerRunning(remainingTime: _initialDuration));
  }

  void _onTick(Tick event, Emitter<TimerState> emit) {
    if (event.remainingTime > 0) {
      emit(TimerRunning(remainingTime: event.remainingTime));
    } else {
      _timer?.cancel();
      emit(TimerFinished());
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      add(
        Tick(
          remainingTime: state is TimerRunning
              ? (state as TimerRunning).remainingTime - 1
              : _initialDuration - 1,
        ),
      );
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
