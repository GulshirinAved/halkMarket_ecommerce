part of 'category_selection_bloc.dart';

abstract class CategorySelectionState extends Equatable {
  final List<Map<String, dynamic>> categoryList;

  const CategorySelectionState({required this.categoryList});

  @override
  List<Object?> get props => [categoryList];
}

class CategorySelectionInitial extends CategorySelectionState {
  const CategorySelectionInitial(
      {required List<Map<String, dynamic>> categoryList})
      : super(categoryList: categoryList);
}

class CategorySelectionUpdated extends CategorySelectionState {
  const CategorySelectionUpdated(
      {required List<Map<String, dynamic>> categoryList})
      : super(categoryList: categoryList);
}
