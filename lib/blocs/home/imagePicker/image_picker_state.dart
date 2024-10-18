// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'image_picker_bloc.dart';

class ImagePickerState extends Equatable {
  final XFile? file;
  const ImagePickerState(
    this.file,
  );

  @override
  List<Object> get props => [file ?? ''];

  ImagePickerState copyWith({
    XFile? file,
  }) {
    return ImagePickerState(
      file ?? this.file,
    );
  }
}
