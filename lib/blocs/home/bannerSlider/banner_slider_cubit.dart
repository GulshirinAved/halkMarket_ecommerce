import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'banner_slider_state.dart';

class BannerSliderCubit extends Cubit<int> {
  BannerSliderCubit() : super(0);
  void changeImage(int value) {
    emit(value);
  }
}
