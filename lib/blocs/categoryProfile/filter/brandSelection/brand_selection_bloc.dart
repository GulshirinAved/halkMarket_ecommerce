import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'brand_selection_event.dart';
part 'brand_selection_state.dart';

class BrandSelectionBloc
    extends Bloc<BrandSelectionEvent, BrandSelectionState> {
  BrandSelectionBloc() : super(const BrandSelectionInitial(brandList: [])) {
    List<Map<String, dynamic>> brand = [];
    on<ChooseBrandEvent>((event, emit) {
      final updatedBrandList = List<Map<String, dynamic>>.from(state.brandList);
      int index = updatedBrandList
          .indexWhere((brand) => brand['name'] == event.pressedBrandName);
      if (index != -1) {
        updatedBrandList.removeAt(index);
      } else {
        updatedBrandList.add({'name': event.pressedBrandName});
      }
      emit(BrandSelectionUpdated(brandList: updatedBrandList));
    });
    on<ApplyBrandEvent>((event, emit) {
      brand = state.brandList;
      emit(BrandSelectionUpdated(brandList: brand));
    });
    on<CleanBrandEvent>((event, emit) {
      emit(BrandSelectionUpdated(brandList: []));
    });
  }
}
