import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'category_selection_event.dart';
part 'category_selection_state.dart';

class CategorySelectionBloc
    extends Bloc<CategorySelectionEvent, CategorySelectionState> {
  CategorySelectionBloc() : super(CategorySelectionInitial(categoryList: [])) {
    on<ChooseCategoryEvent>((event, emit) {
      final updatedCategoryList =
          List<Map<String, dynamic>>.from(state.categoryList);

      int index = updatedCategoryList.indexWhere(
        (category) => category['name'] == event.pressedCategoryName,
      );

      if (index != -1) {
        updatedCategoryList.removeAt(index);
      } else {
        updatedCategoryList.add({'name': event.pressedCategoryName});
      }

      emit(CategorySelectionUpdated(categoryList: updatedCategoryList));
    });
  }
}
