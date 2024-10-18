part of 'save_card_bloc.dart';

sealed class SaveCardState extends Equatable {
  final List cardDataList;

  const SaveCardState(this.cardDataList);

  @override
  List<Object> get props => [cardDataList];
}

final class SaveCardInitial extends SaveCardState {
  const SaveCardInitial(super.cardDataList);
}

final class LoadCardState extends SaveCardState {
  const LoadCardState(super.cardDataList);
}
