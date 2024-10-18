import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'brand_selection_event.dart';
part 'brand_selection_state.dart';

class BrandSelectionBloc
    extends Bloc<BrandSelectionEvent, BrandSelectionState> {
  BrandSelectionBloc()
      : super(const BrandSelectionInitial(brandList: [], brandIdList: [])) {
    List<Map<String, dynamic>> brand = [];
    on<ChooseBrandEvent>((event, emit) {
      final updatedBrandList = List<Map<String, dynamic>>.from(state.brandList);
      final updatedBrandIdList =
          List<Map<String, dynamic>>.from(state.brandIdList);

      final int index = updatedBrandList
          .indexWhere((brand) => brand['name'] == event.pressedBrandName);
      if (index != -1) {
        updatedBrandList.removeAt(index);
        updatedBrandIdList.removeAt(index);
      } else {
        updatedBrandList.add({'name': event.pressedBrandName});
        updatedBrandIdList.add({'id': event.pressedBrandId});
      }
      emit(
        BrandSelectionUpdated(
          brandList: updatedBrandList,
          brandIdList: updatedBrandIdList,
        ),
      );
    });
    on<ApplyBrandEvent>((event, emit) {
      brand = state.brandList;
      emit(
        BrandSelectionUpdated(
          brandList: brand,
          brandIdList: state.brandIdList,
        ),
      );
    });
    on<CleanBrandEvent>((event, emit) {
      emit(const BrandSelectionUpdated(brandList: [], brandIdList: []));
    });
  }
}
