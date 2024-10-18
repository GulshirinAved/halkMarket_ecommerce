import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:halkmarket_ecommerce/blocs/home/chat/chat_bloc.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/utils/imagePicker_utils.dart';
import 'package:share_plus/share_plus.dart';

part 'image_picker_event.dart';
part 'image_picker_state.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  final ImagepickerUtils imagePickerUtils = ImagepickerUtils();
  final ChatBloc chatBloc; // Pass ChatBloc to ImagePickerBloc

  ImagePickerBloc(this.chatBloc) : super(const ImagePickerState(null)) {
    on<GallaryImagePicker>((event, emit) async {
      final XFile? file = await imagePickerUtils.pickImageFromGallary();
      emit(state.copyWith(file: file));

      if (file != null) {
        chatBloc.add(
          SendMessage(
            text: '',
            attachment: file.path,
            author: 'client',
          ),
        );
      }
    });
  }
}
