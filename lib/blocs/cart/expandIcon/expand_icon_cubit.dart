import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'expand_icon_state.dart';

class ExpandIconCubit extends Cubit<bool> {
  ExpandIconCubit() : super(false);
  void tapDropDown() {
    emit(!state);
  }
}
