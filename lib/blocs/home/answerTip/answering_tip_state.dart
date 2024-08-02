// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'answering_tip_bloc.dart';

class AnsweringTipState extends Equatable {
  final String selectedTip;
  const AnsweringTipState({required this.selectedTip});

  @override
  List<Object> get props => [selectedTip];

  AnsweringTipState copyWith({
    String? selectedTip,
  }) {
    return AnsweringTipState(
      selectedTip: selectedTip ?? this.selectedTip,
    );
  }
}
