part of 'category_selection_bloc.dart';

abstract class CategorySelectionState extends Equatable {
  final List<Map<String, dynamic>> categoryList;
  final List<Map<String, dynamic>> categoryIdList;

  const CategorySelectionState(
      {required this.categoryList, required this.categoryIdList});

  @override
  List<Object?> get props => [categoryList];
}

class CategorySelectionInitial extends CategorySelectionState {
  const CategorySelectionInitial(
      {required List<Map<String, dynamic>> categoryList,
      required List<Map<String, dynamic>> categoryIdList})
      : super(categoryList: categoryList, categoryIdList: categoryIdList);
}

class CategorySelectionUpdated extends CategorySelectionState {
  const CategorySelectionUpdated(
      {required List<Map<String, dynamic>> categoryList,
      required List<Map<String, dynamic>> categoryIdList})
      : super(categoryList: categoryList, categoryIdList: categoryIdList);
}
