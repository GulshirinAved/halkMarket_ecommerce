import 'package:bloc/bloc.dart';

class ExpandableTextCubit extends Cubit<bool> {
  ExpandableTextCubit() : super(false);

  void toggleExpanded() => emit(!state);
}
