// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'select_sub_category_bloc.dart';

class SelectSubCategoryState extends Equatable {
  final int index;
  const SelectSubCategoryState({required this.index});

  @override
  List<Object> get props => [index];

  SelectSubCategoryState copyWith({
    int? index,
  }) {
    return SelectSubCategoryState(
      index: index ?? this.index,
    );
  }
}
