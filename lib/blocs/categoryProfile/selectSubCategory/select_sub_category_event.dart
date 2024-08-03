part of 'select_sub_category_bloc.dart';

class SelectSubCategoryEvent extends Equatable {
  final int pressedIndex;
  const SelectSubCategoryEvent({required this.pressedIndex});

  @override
  List<Object> get props => [pressedIndex];
}
