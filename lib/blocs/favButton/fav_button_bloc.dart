import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:halkmarket_ecommerce/data/models/fav_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'fav_button_event.dart';
part 'fav_button_state.dart';

class FavButtonBloc extends Bloc<FavButtonEvent, FavButtonState> {
  final Box box = Hive.box('favBox');

  FavButtonBloc() : super(const FavButtonInitial(favList: [])) {
    on<ToggleFavEvent>((event, emit) async {
      final existingIndex =
          state.favList.indexWhere((item) => item.id == event.item.id);
      final List<FavItem> updatedFavList = List.from(state.favList);
      if (existingIndex != -1) {
        updatedFavList.removeAt(existingIndex);
      } else {
        updatedFavList.add(event.item);
      }
      await box.put(
        'favList',
        updatedFavList.map((item) => item.toJson()).toList(),
      );
      emit(SuccessState(favList: updatedFavList));
    });

    on<LoadFavEvent>((event, emit) async {
      final List? favList = box.get('favList');
      if (favList != null) {
        final List<FavItem> favItems =
            favList.map((item) => FavItem.fromJson(item)).toList();
        emit(SuccessState(favList: favItems));
      } else {
        emit(SuccessState(favList: []));
      }
    });
  }
}
