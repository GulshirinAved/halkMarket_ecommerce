import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'expand_cart_price_state.dart';

class ExpandCartPriceCubit extends Cubit<bool> {
  ExpandCartPriceCubit() : super(false);

  void toggleExpand() => emit(!state);
}
