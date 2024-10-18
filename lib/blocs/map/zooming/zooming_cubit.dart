import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'zooming_state.dart';

class ZoomingCubit extends Cubit<double> {
  ZoomingCubit() : super(9.2);
  void zoomIn() {
    emit(state - 1);
  }

  void zoomOut() {
    emit(state + 1);
  }
}
