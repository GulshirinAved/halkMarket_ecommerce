import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'category_selection_event.dart';
part 'category_selection_state.dart';

class CategorySelectionBloc
    extends Bloc<CategorySelectionEvent, CategorySelectionState> {
  List<Map<String, dynamic>> category = [];
  CategorySelectionBloc()
      : super(CategorySelectionInitial(categoryList: [], categoryIdList: [])) {
    on<ChooseCategoryEvent>((event, emit) {
      final updatedCategoryList =
          List<Map<String, dynamic>>.from(state.categoryList);
      final updatedCategoryIdList =
          List<Map<String, dynamic>>.from(state.categoryIdList);

      int index = updatedCategoryList.indexWhere(
        (category) => category['name'] == event.pressedCategoryName,
      );

      if (index != -1) {
        updatedCategoryList.removeAt(index);
        updatedCategoryIdList.removeAt(index);
      } else {
        updatedCategoryList.add({
          'name': event.pressedCategoryName,
        });
        updatedCategoryIdList.add({'id': event.pressedCategoryId});
      }

      emit(CategorySelectionUpdated(
          categoryList: updatedCategoryList,
          categoryIdList: updatedCategoryIdList));
    });

    on<ApplyCategoryEvent>((event, emit) {
      category = state.categoryList;
      emit(CategorySelectionUpdated(
          categoryList: category, categoryIdList: state.categoryIdList));
    });
    on<CleanCategoryEvent>((event, emit) {
      emit(CategorySelectionUpdated(categoryList: [], categoryIdList: []));
    });
  }
}
