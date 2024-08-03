import 'package:bloc/bloc.dart';

class BrandExpandCubit extends Cubit<bool> {
  BrandExpandCubit() : super(false);

  void toggle() => emit(!state);
}
