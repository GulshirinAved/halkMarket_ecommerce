import 'package:bloc/bloc.dart';

class SelectCardCubit extends Cubit<int> {
  SelectCardCubit() : super(0);
  void selectCard({required int index}) => emit(index);
}
