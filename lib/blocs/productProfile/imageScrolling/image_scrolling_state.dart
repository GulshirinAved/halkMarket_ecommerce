// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'image_scrolling_bloc.dart';

class ImageScrollingState extends Equatable {
  final int selectedIndex;
  const ImageScrollingState(
    this.selectedIndex,
  );

  @override
  List<Object> get props => [selectedIndex];

  ImageScrollingState copyWith({
    int? selectedIndex,
  }) {
    return ImageScrollingState(
      selectedIndex ?? this.selectedIndex,
    );
  }
}
