// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'image_scrolling_bloc.dart';

class ImageScrollingEvent extends Equatable {
  final int pressedIndex;
  const ImageScrollingEvent(
    this.pressedIndex,
  );

  @override
  List<Object> get props => [pressedIndex];
}
