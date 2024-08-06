part of 'select_map_option_cubit.dart';

class SelectMapOptionState extends Equatable {
  final int selectedIndex;
  const SelectMapOptionState({required this.selectedIndex});

  @override
  List<Object> get props => [selectedIndex];
}
