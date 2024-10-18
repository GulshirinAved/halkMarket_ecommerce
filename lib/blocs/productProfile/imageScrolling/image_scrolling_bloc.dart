import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'image_scrolling_event.dart';
part 'image_scrolling_state.dart';

class ImageScrollingBloc
    extends Bloc<ImageScrollingEvent, ImageScrollingState> {
  ImageScrollingBloc() : super(ImageScrollingState(0)) {
    on<ImageScrollingEvent>((event, emit) {
      emit(state.copyWith(selectedIndex: event.pressedIndex));
    });
  }
}
