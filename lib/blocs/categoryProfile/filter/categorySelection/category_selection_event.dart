part of 'category_selection_bloc.dart';

sealed class CategorySelectionEvent extends Equatable {
  const CategorySelectionEvent();

  @override
  List<Object> get props => [];
}

class ChooseCategoryEvent extends CategorySelectionEvent {
  final String pressedCategoryName;
  final String pressedCategoryId;

  const ChooseCategoryEvent(
      {required this.pressedCategoryName, required this.pressedCategoryId});
}

class ApplyCategoryEvent extends CategorySelectionEvent {
  const ApplyCategoryEvent();
}

class CleanCategoryEvent extends CategorySelectionEvent {
  const CleanCategoryEvent();
}
