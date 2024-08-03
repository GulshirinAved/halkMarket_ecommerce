part of 'category_selection_bloc.dart';

sealed class CategorySelectionEvent extends Equatable {
  const CategorySelectionEvent();

  @override
  List<Object> get props => [];
}

class ChooseCategoryEvent extends CategorySelectionEvent {
  final String pressedCategoryName;

  const ChooseCategoryEvent({required this.pressedCategoryName});
}

class ApplyCategoryEvent extends CategorySelectionEvent {
  const ApplyCategoryEvent();
}

class CleanCategoryEvent extends CategorySelectionEvent {
  const CleanCategoryEvent();
}
